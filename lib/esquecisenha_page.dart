import 'dart:convert';
import 'package:feteps/loginfeteps_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({super.key});

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  final snackBar = const SnackBar(
    content: Text(
      'E-mail ou Cpf são inválidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  @override
  Widget build(BuildContext context) {
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
                      child: const LoginFetepsPage(),
                      type: PageTransitionType.topToBottom,
                    ),
                  );
                },
                icon: Icon(
                  size: MediaQuery.of(context).size.width * 0.075,
                  Icons.arrow_back_sharp,
                  color: const Color(0xFF0E414F),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
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
                height: MediaQuery.of(context).size.height * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFB6382B),
                          width: 3.5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/fundo.png',
                          width: MediaQuery.of(context).size.width * 0.65,
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
                    "Esqueceu sua senha?",
                    style: GoogleFonts.roboto(
                      fontSize: MediaQuery.of(context).size.width * 0.069,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // TextFormField EMAIL
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.82,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Por favor digite seu e-mail';
                                } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(_emailController.text)) {
                                  return 'Por favor, digite um e-mail correto';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          // TextFormField SENHA
                          Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'CPF',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              controller: _cpfController,
                              keyboardType: TextInputType.text,
                              validator: (senha) {
                                if (senha == null || senha.isEmpty) {
                                  return 'Por favor, digite a seu cpf';
                                } else if (senha.length < 3) {
                                  return 'Por favor, digite uma cpf válido';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Nova senha',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              validator: (senha) {
                                if (senha == null || senha.isEmpty) {
                                  return 'Por favor, digite a sua nova senha';
                                } else if (senha.length < 3) {
                                  return 'Por favor, digite uma senha maior de 3 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: const Color(0xFFB6382B),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.012,
                                    right: MediaQuery.of(context).size.width *
                                        0.012,
                                  ),
                                  child: ElevatedButton(
                                    onPressed:
                                        _isLoading ? null : _alterarSenha,
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 39),
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    child: Text(
                                      _isLoading
                                          ? 'Atualizando...'
                                          : 'Atualizar Senha',
                                      style: GoogleFonts.oswald(
                                        color: Colors.black,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _alterarSenha() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          GlobalPageState.Url + '/appfeteps/pages/Users/updatePassword.php'),
    );

    request.fields['userEmail'] = _emailController.text;
    request.fields['cpf'] = _cpfController.text;
    request.fields['newPassword'] = _passwordController.text;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString());
      print('Response data: $responseData');
      if (responseData['type'] == 'success' &&
          responseData['message'] == 'Password updated') {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const LoginFetepsPage(),
              type: PageTransitionType.topToBottom),
          (route) => false,
        );
      } else {
        setState(() {
          _errorMessage = responseData['message'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Falha ao alterar a senha';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }
}
