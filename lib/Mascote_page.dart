import 'package:carousel_slider/carousel_slider.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/participantes_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:feteps/sobrenos_page.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class MascotePage extends StatefulWidget {
  const MascotePage({super.key});

  @override
  State<MascotePage> createState() => _MascotePageState();
}

class _MascotePageState extends State<MascotePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar1_page(
            screenWidth: screenWidth, destinationPage: SobrePage()),
        endDrawer: MenuPage(),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color.fromARGB(255, 49, 163, 194),
                                width: 2),
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 49, 163, 194),
                                width: 2))),
                    child: Image.asset(
                      'lib/assets/bannermascote.png',
                      width: MediaQuery.of(context).size.width * 1.0,
                    ),
                  )
                ],
              ),
            ),
            TabBar(
              indicatorColor: Color.fromARGB(255, 49, 163, 194),
              labelColor: themeProvider.getSpecialColor3(),
              labelStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
              tabs: const [
                Tab(text: 'Fet'),
                Tab(text: 'Teps'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.04,
                            ),
                            child: Image.asset(
                              'lib/assets/Fet.png',
                              width: screenWidth * 0.35,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CRIADORES:\nVitória das Neves Oliveira\nArthur Barros Martins Pereira',
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 49, 163, 194),
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.09,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Era uma vez, um pequeno robô chamado Fet.',
                                style: GoogleFonts.roboto(
                                    color: themeProvider.getSpecialColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.042),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth * 0.8,
                                  child: Text(
                                    'Inicialmente, ele era apenas uma caixa como lhos e rodas, projetado para tarefas simples. No entanto, ao passar de dono para dono, Fet foi modificado e aprimorado, ganhando novos recursos e habilidades.',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color:
                                            themeProvider.getSpecialColor3()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth * 0.8,
                                  child: Text(
                                    'Com braços longos e elásticos, mãos curvas e a capacidade de se auto-modificar, Fet podia construir qualquer engenhoca maluca e alterar sua própria composição e cores. Sua aparência, com tronco vermelho, rodas azuis e olhos brilhantes, refletia sua natureza atrapalhada e engenhosa.',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color:
                                            themeProvider.getSpecialColor3()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Lição',
                                style: GoogleFonts.roboto(
                                    color: themeProvider.getSpecialColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth * 0.85,
                                  child: Text(
                                    'A história de Fet mostra como uma pequena ideia pode se transformar em algo incrível, exemplificando a importância de apoiar a criatividade e a inovação. Como Fet sempre diz:',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color:
                                            themeProvider.getSpecialColor3()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.8,
                                child: Text(
                                  '"É de uma pequena ideia que surge uma grande criação."',
                                  style: GoogleFonts.poppins(
                                      color: themeProvider.getSpecialColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.042),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          ),
                        ],
                      ),
                    ],
                  ), // Conteúdo da primeira guia
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/Teps.png',
                              width: MediaQuery.of(context).size.width * 0.65,
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.055,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CRIADORA:\nEmily Takara',
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(255, 49, 163, 194),
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.114,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Era uma vez, um pequeno robô chamado Teps.',
                              style: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.042),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.8,
                                child: Text(
                                  'Criado pelos estudantes da CPS para ajudar e apoiar todos na feira tecnológica.',
                                  style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: themeProvider.getSpecialColor3()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.8,
                                child: Text(
                                  'Teps pode esticar os braços e transformar suas mãos em qualquer ferramenta necessária, sendo sempre amigável, prestativo e carismático.',
                                  style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: themeProvider.getSpecialColor3()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.8,
                                child: Text(
                                  'Com um design fofo e redondo, antenas em formato de "F", óculos com detalhes de engrenagem e mãos de garra, Teps tem uma paleta de cores inspirada nos logos da FETEPS e do CPS',
                                  style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: themeProvider.getSpecialColor3()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lição',
                              style: GoogleFonts.roboto(
                                  color: themeProvider.getSpecialColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.85,
                                child: Text(
                                  'Com tecnologia no núcleo e carisma no circuito, Teps na FETEPS, o encanto é o intuito!',
                                  style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: themeProvider.getSpecialColor3()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                      ]),
                    ],
                  ), // Conteúdo da segunda guia
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
