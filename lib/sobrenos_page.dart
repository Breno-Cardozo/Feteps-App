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
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class SobreNosPage extends StatefulWidget {
  const SobreNosPage({super.key});

  @override
  State<SobreNosPage> createState() => _SobreNosPageState();
}

class _SobreNosPageState extends State<SobreNosPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar1_page(
          screenWidth: screenWidth * 1.0, destinationPage: SobrePage()),
      endDrawer: MenuPage(),
      body: Column(children: [
        SizedBox(
          height: screenHeight * 0.3,
          child: Row(
            children: [
              Image.asset(
                'lib/assets/banner2.png',
                width: screenWidth * 1.0,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: screenHeight * 0.05,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: themeProvider.getBorderColor(),
                        width: 1), // Define a linha de borda inferior
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sobre Nós',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.064,
                        color: themeProvider.getSpecialColor2(),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      screenWidth * 0.05,
                    ),
                    child: Container(
                      width: screenWidth *
                          0.9, // Ajuste a largura conforme necessário
                      child: Text(
                        'Somos um grupo de alunos dedicados e inovadores que uniram suas paixões pela tecnologia e educação. Movidos pelo desejo de fazer a diferença, desenvolvemos um aplicativo para a Feira Tecnológica do Estado de São Paulo (Feteps). Nossa jornada foi marcada por colaboração, aprendizado e superação de desafios. Este aplicativo é o resultado do nosso comprometimento em proporcionar uma experiência única aos participantes da Feteps, conectando pessoas, ideias e tecnologia. Estamos orgulhosos de contribuir para o sucesso deste evento e ansiosos para compartilhar essa jornada emocionante com vocês.',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: themeProvider.getSpecialColor3(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/estudantes.png',
                    width: screenWidth * 0.45,
                  )
                ],
              ),
              SizedBox(
                  child: Container(
                height: screenHeight * 0.01,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: const NossaEquipePage(),
                            type: PageTransitionType.topToBottom,
                          ),
                        );
                      },
                      child: Text(
                        'Nossa Equipe',
                        style: GoogleFonts.poppins(
                            color: themeProvider.getSpecialColor3(),
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
    );
  }
}
