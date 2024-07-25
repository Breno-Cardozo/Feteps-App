import 'package:feteps/cadastro1_page.dart';
import 'package:feteps/loginfeteps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:http/http.dart' as http;
import 'global.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class Cadastro2Page extends StatefulWidget {
  final String? selectedItem;
  final String? selectedItemInstituicao;

  const Cadastro2Page({
    Key? key,
    required this.selectedItem,
    required this.selectedItemInstituicao,
  }) : super(key: key);

  @override
  State<Cadastro2Page> createState() => _Cadastro2PageState();
}

class _Cadastro2PageState extends State<Cadastro2Page> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _areaatividadeController = TextEditingController();
  String valorExpositor = 'Não';

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _ufController.dispose();
    _cidadeController.dispose();
    _areaatividadeController.dispose();
    super.dispose();
  }

  void enviarDados() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool valorBool = valorExpositor == 'Sim';
    String dataAtual = DateTime.now().toIso8601String().split('T')[0];

    int? idType = int.tryParse(widget.selectedItem ?? '');
    int? idInstitution = int.tryParse(widget.selectedItemInstituicao ?? '');

    if (idType == null || idInstitution == null) {
      print('Erro: idType e idInstitution devem ser valores numéricos válidos');
      return;
    }

    var url = Uri.parse(
        GlobalPageState.Url + '/appfeteps/pages/Users/createUser.php');
    var request = http.MultipartRequest('POST', url);

    request.fields['userName'] = _nomeController.text;
    request.fields['userEmail'] = _emailController.text;
    request.fields['cpf'] = _cpfController.text;
    request.fields['city'] = _cidadeController.text;
    request.fields['state'] = _ufController.text;
    request.fields['userPassword'] = _passwordController.text;
    request.fields['exhibitor'] = valorBool.toString();
    request.fields['idType'] = idType.toString();
    request.fields['idInstitution'] = idInstitution.toString();
    request.fields['registerDate'] = dataAtual;
    request.fields['areaOfActivityCourse'] = _areaatividadeController.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text(
          'Cadastro concluído com sucesso',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD35F),
        duration: const Duration(seconds: 3),
      );

      // Mostra o SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Espera 3 segundos antes de navegar
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginFetepsPage()),
        );
      });
    } else {
      print('Falha ao enviar dados: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 400,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Cadastro1Page(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
                icon: Icon(
                  size: MediaQuery.of(context).size.width * 0.075,
                  Icons.arrow_back_sharp,
                  color: themeProvider.getSpecialColor2(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: Image.asset(
                  logoAsset,
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFB6382B),
                          width: screenWidth * 0.009,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/fundo.png',
                          width: screenWidth * 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CADASTRO",
                    style: GoogleFonts.roboto(
                      fontSize: screenWidth * 0.069,
                      color: themeProvider.getSpecialColor3(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dados pessoais',
                    style: GoogleFonts.roboto(
                      fontSize: screenWidth * 0.052,
                      color: themeProvider.getSpecialColor3(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _nomeController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu nome';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CPF',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _cpfController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu cpf';
                                } else if (!RegExp('').hasMatch(value)) {
                                  return 'Por favor, digite um cpf válido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu e-mail';
                                } else if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                    .hasMatch(value)) {
                                  return 'Por favor, digite um e-mail válido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua senha';
                                } else if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Estado',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _ufController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua UF';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Cidade',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _cidadeController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua cidade';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Área de Atividade',
                                labelStyle: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.getBorderColor()),
                                ),
                              ),
                              controller: _areaatividadeController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua área de atividade';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: Row(
                              children: [
                                Text(
                                  'Expositor:',
                                  style: GoogleFonts.roboto(
                                    color: themeProvider.getSpecialColor3(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      value: 'Não',
                                      groupValue: valorExpositor,
                                      onChanged: (value) {
                                        setState(() {
                                          valorExpositor = value.toString();
                                        });
                                      },
                                      activeColor: const Color(0xFFB6382B),
                                    ),
                                    Text(
                                      'Não',
                                      style: GoogleFonts.roboto(
                                        color: themeProvider.getSpecialColor3(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                    Radio(
                                      value: 'Sim',
                                      groupValue: valorExpositor,
                                      onChanged: (value) {
                                        setState(() {
                                          valorExpositor = value.toString();
                                        });
                                      },
                                      activeColor: const Color(0xFFB6382B),
                                    ),
                                    Text(
                                      'Sim',
                                      style: GoogleFonts.roboto(
                                        color: themeProvider.getSpecialColor3(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: const Color(0xFFB6382B),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.012,
                                right:
                                    MediaQuery.of(context).size.width * 0.012),
                            child: ElevatedButton(
                              onPressed: enviarDados,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 39),
                                backgroundColor:
                                    themeProvider.getSpecialColor4(),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                              ),
                              child: Text(
                                "Continuar",
                                style: GoogleFonts.oswald(
                                  color: themeProvider.getSpecialColor3(),
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
