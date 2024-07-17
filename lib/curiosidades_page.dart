import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/curiosidades2_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class CuriosidadePage extends StatelessWidget {
  const CuriosidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar1_page(
            screenWidth: screenWidth, destinationPage: const SobrePage()),
        endDrawer: const MenuPage(),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Curiosidades',
                          style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.getSpecialColor2()),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0C414F),
                          border: Border(
                            left: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                            top: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                            right: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Text(
                            'Por que os projetos da Feteps\nsão baseados em ODS?',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                            right: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                            bottom: BorderSide(
                                color: themeProvider.getBorderColor(),
                                width: 2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.022),
                                  child: Text(
                                    'Os Objetivos de Desenvolvimento\nSustentável são metas globais da\n ONU para acabar com a pobreza,\nproteger o meio ambiente, promover\na paz e garantir prosperidade até\n2030. Integrados em dimensões\nsocial, ambiental e econômica, são\nresponsabilidade de governos,\nsociedade civil, setor privado e\nindivíduos comprometidos com\n o futuro.\nComo cada ODS tem como objetivo\nde acabar com algum problema\ndecorrente em nosso mundo,\nprojetos baseados nesses objetivos\najudam aos alunos criarem soluções\n sustentáveis e assim, sendo\ninspirações para a próxima geração\npara que pensem em como salvar e\npreservar o meio em que vivem.',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: screenWidth * 0.0415),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.022),
                                  child: Image.asset(
                                    'lib/assets/curiosidade.png',
                                    width: screenWidth * 0.45,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.86,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const Curiosidade2Page(),
                                    type: PageTransitionType.topToBottom),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 39),
                              backgroundColor: const Color(0xFF0C414F),
                              shadowColor: Colors.transparent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Colors.transparent, width: 5),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.015),
                              child: Text(
                                "Vamos conhecer cada ODS?",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
