// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:feteps/participantes_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/sobrenos_page.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  bool _isExpanded = false;

  final String _fullText =
      'A Feteps é um evento que reúne projetos desenvolvidos por alunos do Centro Paula Souza e outras instituições participantes. Com projetos inovadores, de transformação social, tecnológicos e criativos. A diversidade e a qualidade dos trabalhos demonstram a excelência dos projetos pedagógicos do ensino médio, cursos técnicos de nível médio e superior tecnológico. A Feteps tem como objetivo desenvolver a visão empreendedora, criativa, inovadora e científico-tecnológica dos alunos. Nível médio e superior tecnológico. A Feteps tem como objetivo desenvolver a visão empreendedora, criativa, inovadora e científico-tecnológica dos alunos.\n\n'
      'CENTRO PAULA SOUZA\n\n'
      'O Centro Paula Souza (CPS) é uma autarquia do Governo do Estado de São Paulo, vinculada à Secretaria de Ciência, Tecnologia e Inovação. Presente em 363 municípios, a instituição administra 227 Escolas Técnicas (Etecs) e 77 Faculdades de Tecnologia (Fatecs) estaduais, com mais de 316 mil alunos em cursos técnicos de nível médio e superior tecnológicos.\n\n'
      'A instituição também é reconhecida como Instituto de Ciência e Tecnologia (ICT), uma organização sem fins lucrativos de administrações públicas ou privadas, que tem como principal objetivo a criação e o incentivo a pesquisas científicas e tecnológicas.\n\n'
      'ETEC E FATEC\n\n'
      'Nas Etecs, mais de 226 mil estudantes estão matriculados nos Ensinos Médio, Técnico integrado ao Médio e no Ensino Técnico, incluindo habilitações nas modalidades presencial, semipresencial, online, Educação de Jovens e Adultos (EJA) e especialização técnica. As Etecs oferecem 224 cursos, voltados a todos os setores produtivos públicos e privados.\n\n'
      'Já as Fatecs atendem mais de 96 mil alunos matriculados em 86 cursos de graduação tecnológica, em diversas áreas, como Construção Civil, Mecânica, Informática, Tecnologia da Informação, Turismo, entre outras.';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: 400,
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 30, bottom: 15),
                  child: Image.asset(
                    logoAsset,
                    width: MediaQuery.of(context).size.width * 0.65,
                  ),
                )
              ],
            ),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: MediaQuery.of(context).size.width * 0.095,
                    color: themeProvider.getSpecialColor2(),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        endDrawer: MenuPage(),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/banner2.png',
                    width: MediaQuery.of(context).size.width * 1.0,
                  )
                ],
              ),
            ),
            TabBar(
              indicatorColor: const Color(0xFFFFD35F),
              labelColor: themeProvider.getSpecialColor3(),
              labelStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.043,
              ),
              tabs: const [
                Tab(text: 'Feteps'),
                Tab(text: 'Programação'),
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
                              'lib/assets/alunos.png',
                              width: screenWidth * 0.65,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.07,
                                  ),
                                  child: Text(
                                    _isExpanded
                                        ? _fullText
                                        : _fullText.substring(0, 636) + '...',
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color:
                                            themeProvider.getSpecialColor3()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _isExpanded ? "Leia Menos" : "Leia Mais",
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    color: const Color(0xFFB6382B),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFFB6382B),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ), // Conteúdo da primeira guia
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          child: const EventTable(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/calendario.png',
                              width: MediaQuery.of(context).size.width * 0.55,
                            )
                          ],
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

class EventTable extends StatelessWidget {
  const EventTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        border: Border.all(color: Colors.black),
      ),
      child: Table(
        columnWidths: {
          0: const FlexColumnWidth(1),
          1: const FlexColumnWidth(2),
        },
        children: [
          _buildTableRow(
            '10/10/2023\n25/03/2024',
            'Submissão dos Trabalhos [Prorrogado]',
            Color(0xFFFFD35F),
          ),
          _buildTableRow(
              '22/04/2024', 'Início da Etapa de Avaliação', Colors.white),
          _buildTableRow(
              '15/05/2024', 'Divulgação dos Finalistas', Color(0xFFFFD35F)),
          _buildTableRow('19, 20, 21 e 22/08/2024',
              'Feira Presencial: São Paulo Expo - Pavilhão 7', Colors.white),
        ],
      ),
    );
  }

  TableRow _buildTableRow(
      String date, String description, Color backgroundColor) {
    return TableRow(
      children: [
        Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(20.66), // Aumenta a altura da linha
          child: Text(
            date,
            style: TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(20.0), // Aumenta a altura da linha
          child: Text(
            description,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
