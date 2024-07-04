// ignore_for_file: prefer_const_constructors

import 'package:feteps/NossaEquipe_page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/participantes_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SobreNosPage extends StatefulWidget {
  const SobreNosPage({super.key});

  @override
  State<SobreNosPage> createState() => _SobreNosPageState();
}

class _SobreNosPageState extends State<SobreNosPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
       ),
        home: Scaffold(
          appBar: AppBar1_page(screenWidth:  MediaQuery.of(context).size.width * 1.0, destinationPage: SobrePage()),
          endDrawer: MenuPage(),
          body: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.299,
                    color: const Color(0xFFFFD35F),
                    child: Image.asset(
                      'lib/assets/banner2.png',
                      width: MediaQuery.of(context).size.width * 1.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.black38,
                              width: 1), // Define a linha de borda inferior
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sobre Nós',
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.064,
                              color: const Color(0xFF0E414F),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Somos um grupo de alunos\ndedicados  e inovadores que uniram\nsuas paixões pela tecnologia e\neducação. Movidos pelo desejo de\nfazer a diferença, \ndesenvolvemos um aplicativo\npara a Feira Tecnológica\ndo Estado de São Paulo (Feteps).\nNossa jornada foi marcada por colaboração,\naprendizado e superação de desafios.\nEste aplicativo é o resultado\n do nosso comprometimento\nem proporcionar uma\nexperiência única aos participantes\n da Feteps, conectando pessoas,\nideias e tecnologia. Estamos orgulhosos\nde contribuir para o sucesso\ndeste evento e ansiosos para compartilhar\nessa jornada emocionante com vocês.',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/estudantes.png',
                        width: MediaQuery.of(context).size.width * 0.45,
                      )
                    ],
                  ),
                  SizedBox(
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child:  const NossaEquipePage(), type:  PageTransitionType.topToBottom,
                              ),
                            );
                          },
                          child: Text(
                            'Nossa Equipe',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
