import 'package:feteps/appbar/appbar2_page.dart';
import 'package:feteps/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'perfil_page.dart';
import 'loginfeteps_page.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class AlterarSenhaPage extends StatefulWidget {
  const AlterarSenhaPage({super.key, required String idUsuario});

  @override
  _AlterarSenhaPageState createState() => _AlterarSenhaPageState();
}

class _AlterarSenhaPageState extends State<AlterarSenhaPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  Map<String, dynamic>? userData;
  bool isLoading = false;
  String email = '';
  String tokenLogado = '';

  Future<void> _alterarSenha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      tokenLogado = prefs.getString('token') ?? '';
    });

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'As novas senhas não coincidem';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          GlobalPageState.Url + '/appfeteps/pages/Users/updatePassword.php'),
    );

    request.headers['Authorization'] = 'Bearer $tokenLogado';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['userEmail'] = email;
    request.fields['cpf'] = _currentPasswordController.text;
    request.fields['newPassword'] = _newPasswordController.text;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString());
      print('Response data: $responseData');
      if (responseData['type'] == 'success' &&
          responseData['message'] == 'Password updated') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Senha alterada com sucesso',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFFFFD35F),
            duration: const Duration(seconds: 3)));
        Future.delayed(const Duration(seconds: 2), () {
          _logout();
        });
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
          child: const LoginFetepsPage(), type: PageTransitionType.topToBottom),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar2_page(
          screenWidth: screenWidth, destinationPage: const PerfilPage()),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.08,
                  bottom: screenHeight * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Alterar Senha',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.06,
                        color: themeProvider.getSpecialColor2(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        controller: _currentPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Digite seu cpf:',
                          labelStyle: GoogleFonts.poppins(
                            color: themeProvider.getSpecialColor3(),
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: themeProvider.getBorderColor()),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFFD4A03D),
                                width: screenWidth * 0.005),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85,
                      child: TextFormField(
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Digite a nova senha:',
                          labelStyle: GoogleFonts.poppins(
                            color: themeProvider.getSpecialColor3(),
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: themeProvider.getBorderColor()),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFFD4A03D),
                                width: screenWidth * 0.005),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar nova senha:',
                          labelStyle: GoogleFonts.poppins(
                            color: themeProvider.getSpecialColor3(),
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: themeProvider.getBorderColor()),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFFD4A03D),
                                width: screenWidth * 0.005),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              _errorMessage.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : Container(),
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
                        left: MediaQuery.of(context).size.width * 0.012,
                        right: MediaQuery.of(context).size.width * 0.012,
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _alterarSenha,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 39),
                          backgroundColor: themeProvider.getSpecialColor4(),
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Text(
                          _isLoading ? 'Atualizando...' : 'Atualizar Senha',
                          style: GoogleFonts.oswald(
                            color: themeProvider.getSpecialColor3(),
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/senha.png',
                      width: screenWidth * 0.75,
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
