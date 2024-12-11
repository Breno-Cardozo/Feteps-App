import 'dart:io';
import 'package:feteps/Fet_page.dart';
import 'package:feteps/Teps_page.dart';
import 'package:feteps/global.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:feteps/Temas/theme_provider.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/sobre_page.dart';

class MascotePage extends StatefulWidget {
  const MascotePage({super.key});

  @override
  State<MascotePage> createState() => _MascotePageState();
}

class _MascotePageState extends State<MascotePage> {
  int _selectedCardIndex = -1;
  String tokenLogado = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _recuperarToken();
    _recuperarUserId();
  }

  Future<void> _recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenLogado = prefs.getString('token') ?? '';
    });
  }

  Future<void> _recuperarUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('idUsuario') ?? '';
    });
  }

  Future<void> enviarVoto() async {
    if (_selectedCardIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione um mascote'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    String projectId = _selectedCardIndex == 0 ? '3000' : '3001';

    // Verifica se o usuário já votou
    bool jaVotou = await verificarVoto();
    if (jaVotou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você já votou!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final String apiUrl =
        'https://app.feteps.cpscetec.com.br/appfeteps/pages/Users/saveVote.php';

    Map<String, String> headers = {
      'Authorization': 'Bearer $tokenLogado',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'user_id': userId,
      'project_id': projectId,
      'score': 1,
    };

    final httpClient = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    try {
      final response = await httpClient.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Voto realizado com sucesso',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xFFFFD35F),
          ),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        if (responseBody['type'] == 'error' &&
            responseBody['message'].contains('Duplicate entry')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Seu voto já foi computado'),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Erro ao realizar voto: ${responseBody['message']}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao realizar voto: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<bool> verificarVoto() async {
    final String apiUrl =
        'https://app.feteps.cpscetec.com.br/appfeteps/pages/Users/getVotes.php?id=$userId';

    final httpClient = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    try {
      final response = await httpClient.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        for (var vote in responseData['response']) {
          final projectName = vote['project']['name'];
          if (projectName == 'FET' || projectName == 'TEPS') {
            return true;
          }
        }
      } else {
        print('Erro ao verificar votos: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao verificar votos: $e');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar:
          AppBar1_page(screenWidth: screenWidth, destinationPage: SobrePage()),
      endDrawer: MenuPage(),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: themeProvider.getBorderColor(), width: 2),
                          bottom: BorderSide(
                              color: themeProvider.getBorderColor(), width: 2),
                        ),
                      ),
                      child: Image.asset(
                        'lib/assets/banners/banner4.png',
                        width: MediaQuery.of(context).size.width * 1.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Vote no seu mascote favorito!',
                    style: GoogleFonts.poppins(
                      color: themeProvider.getSpecialColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCardIndex = 0;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF830000),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: _selectedCardIndex == 0
                                    ? const Color.fromARGB(255, 247, 186, 65)
                                    : Colors.transparent,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: screenWidth * 0.4,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'lib/assets/Fet/Fet.png',
                                    height: screenHeight * 0.18,
                                  ),
                                ),
                                Text(
                                  'Fet',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const FetPage(),
                                  type: PageTransitionType.size,
                                  alignment: Alignment.center),
                            );
                          },
                          child: Text(
                            'História',
                            style: GoogleFonts.poppins(
                              color: themeProvider.getSpecialColor3(),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              decoration: TextDecoration.underline,
                              decorationColor: themeProvider.getBorderColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCardIndex = 1;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A5B97),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: _selectedCardIndex == 1
                                    ? const Color.fromARGB(255, 247, 186, 65)
                                    : Colors.transparent,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: screenWidth * 0.4,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'lib/assets/Teps/Teps.png',
                                    height: screenHeight * 0.18,
                                  ),
                                ),
                                Text(
                                  'Teps',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const TepsPage(),
                                  type: PageTransitionType.size,
                                  alignment: Alignment.center),
                            );
                          },
                          child: Text(
                            'História',
                            style: GoogleFonts.poppins(
                              color: themeProvider.getSpecialColor3(),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              decoration: TextDecoration.underline,
                              decorationColor: themeProvider.getBorderColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: enviarVoto,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.getSpecialColor2(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Votar',
                        style: GoogleFonts.oswald(
                          color: themeProvider.getSpecialColor21(),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
