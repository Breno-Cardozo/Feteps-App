import 'dart:convert';
import 'package:feteps/cadastro1_page.dart';
import 'package:feteps/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'Apis/cidades.dart';
import 'Apis/estados.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class CadastroInstituicaoPage extends StatefulWidget {
  @override
  _CadastroInstituicaoPageState createState() =>
      _CadastroInstituicaoPageState();
}

class _CadastroInstituicaoPageState extends State<CadastroInstituicaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _campusController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  String? _selectedEstado;
  String? _selectedInstitutionType;
  List<Estado> _estados = [];
  List<Cidade> _cidadesDoEstado = [];
  String _nomeEstado = '';

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  _loadEstados() async {
    try {
      List<Estado> estados = await Estado.getEstados();
      setState(() {
        _estados = estados;
      });
    } catch (e) {
      print('Erro ao carregar estados: $e');
    }
  }

  _loadCidades(String estadoId) async {
    try {
      List<Cidade> cidades = await Cidade.getCidades(estadoId);
      setState(() {
        _cidadesDoEstado = cidades;
      });
      // Buscar o nome do estado com base no ID
      Estado? estado = _estados.firstWhere((e) => e.id == estadoId,
          orElse: () => Estado(id: '', nome: ''));
      setState(() {
        _nomeEstado = estado.nome;
      });
    } catch (e) {
      print('Erro ao carregar cidades: $e');
    }
  }

  Future<void> cadastrarInstituicao(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var url = Uri.parse(
        GlobalPageState.Url + '/appfeteps/pages/Institution/save.php');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name_institution': _nomeController.text,
          'campus': _campusController.text,
          'city_institution': _cidadeController.text,
          'state_institution': _nomeEstado,
          'institution_type': _selectedInstitutionType,
          'classification': 'OUTROS',
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Instituição cadastrada com sucesso!'),
            backgroundColor: const Color(0xFFFFD35F),
            duration: const Duration(seconds: 3),
          ),
        );
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Cadastro1Page(),
            ),
          );
        });
      } else {
        print('Erro ao cadastrar instituição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao cadastrar instituição: $e');
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
              WillPopScope(
                onWillPop: () async {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: Cadastro1Page(),
                      type: PageTransitionType.topToBottom,
                    ),
                  );
                  return false;
                },
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: Cadastro1Page(),
                        type: PageTransitionType.topToBottom,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: themeProvider.getSpecialColor2(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: Image.asset(
                  logoAsset,
                  width: MediaQuery.of(context).size.width * 0.7,
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
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFB6382B),
                          width: screenWidth * 0.01,
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
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cadastre uma',
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.05,
                        color: themeProvider.getSpecialColor3(),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'INSTITUIÇÃO',
                    style: GoogleFonts.roboto(
                      fontSize: screenWidth * 0.07,
                      color: themeProvider.getSpecialColor3(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(screenWidth, screenHeight,
                        'Nome da Instituição:', _nomeController),
                    SizedBox(height: screenHeight * 0.02),
                    _buildTextField(screenWidth, screenHeight,
                        'Campus (Opcional):', _campusController),
                    SizedBox(height: screenHeight * 0.02),
                    _buildDropdownInstitutionType(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildDropdownEstado(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildDropdownCidade(screenWidth, screenHeight),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                      child: Row(
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
                                  left:
                                      MediaQuery.of(context).size.width * 0.012,
                                  right: MediaQuery.of(context).size.width *
                                      0.012),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Verifica se algum campo está focado
                                  if (FocusScope.of(context).hasFocus) {
                                    // Se sim, remove o foco para permitir a leitura dos controladores
                                    FocusScope.of(context).unfocus();
                                  }
                                  cadastrarInstituicao(context);
                                },
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
                                  "Cadastrar",
                                  style: GoogleFonts.oswald(
                                    color: themeProvider.getSpecialColor3(),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildTextField(double screenWidth, double screenHeight, String label,
      TextEditingController controller) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownInstitutionType(
      double screenWidth, double screenHeight) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.grey,
            decoration: InputDecoration(
              labelText: 'Tipo da instituição:',
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: themeProvider.getSpecialColor3(),
            ),
            value: _selectedInstitutionType,
            onChanged: (String? newValue) {
              setState(() {
                _selectedInstitutionType = newValue;
              });
            },
            items: ['URBANA', 'RURAL'].map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: TextStyle(color: themeProvider.getSpecialColor3()),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione o tipo da instituição.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownEstado(double screenWidth, double screenHeight) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.grey,
            decoration: InputDecoration(
              labelText: 'Estado:',
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: themeProvider.getSpecialColor3(),
            ),
            value: _selectedEstado,
            onChanged: (String? newValue) {
              setState(() {
                _selectedEstado = newValue;
                _estadoController.text = newValue!;
                _loadCidades(newValue);
              });
            },
            items: _estados.map((estado) {
              return DropdownMenuItem<String>(
                value: estado.id,
                child: Text(
                  estado.nome,
                  style: TextStyle(color: themeProvider.getSpecialColor3()),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione um estado.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCidade(double screenWidth, double screenHeight) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.grey,
            decoration: InputDecoration(
              labelText: 'Cidade:',
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: themeProvider.getSpecialColor3(),
            ),
            value: _cidadeController.text.isNotEmpty
                ? _cidadeController.text
                : null,
            onChanged: (String? newValue) {
              setState(() {
                _cidadeController.text = newValue!;
              });
            },
            items: _cidadesDoEstado.map((cidade) {
              return DropdownMenuItem<String>(
                value: cidade.nome,
                child: Text(
                  cidade.nome,
                  style: TextStyle(color: themeProvider.getSpecialColor3()),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma cidade.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
