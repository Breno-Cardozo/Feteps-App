import 'package:feteps/Menu_Page.dart';
import 'package:feteps/curiosidades_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class Curiosidade2Page extends StatelessWidget {
  const Curiosidade2Page({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: CuriosidadePage(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
                return false;
              },
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const CuriosidadePage(),
                        type: PageTransitionType.bottomToTop),
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 15),
                  child: Icon(
                    size: screenWidth * 0.075,
                    Icons.arrow_back_sharp,
                    color: themeProvider.getSpecialColor2(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                bottom: 15,
              ),
              child: Image.asset(
                logoAsset,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vamos conhecer cada ODS?',
                        style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.055,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.getSpecialColor2()),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFD32F2F),
                    collapsedBackgroundColor: const Color(0xFFD32F2F),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 1',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.7,
                                  child: Text(
                                    'Acabar com a pobreza em todas as suas formas, em todos os lugares',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Até 2030, reduzir pelo menos à metade a proporção de homens, mulheres e crianças, de todas as idades, que vivem na pobreza, em todas as suas dimensões, de acordo com as definições nacionais.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFDDA73A),
                    collapsedBackgroundColor: const Color(0xFFDDA73A),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 2',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Acabar com a fome, alcançar a segurança alimentar e melhoria da nutrição e promover a agricultura sustentável',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Até 2030, acabar com a fome e garantir o acesso de todas as pessoas, em particular pessoas em situações vulneráveis, incluindo crianças, a alimentos seguros, nutritivos e suficientes durante todo o ano.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF4CA146),
                    collapsedBackgroundColor: const Color(0xFF4CA146),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 3',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Assegurar uma vida saudável e promover o bem-estar para todas e todos, em todas as idades',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Até 2030, acabar com as epidemias de AIDS, tuberculose, malária e doenças tropicais negligenciadas, e combater a hepatite, doenças transmitidas pela água, e outras doenças transmissíveis e reduzir em um terço a mortalidade prematura por doenças não transmissíveis via prevenção e tratamento, e promover a saúde mental e o bem-estar',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFC7212F),
                    collapsedBackgroundColor: const Color(0xFFC7212F),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 4',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Assegurar a educação inclusiva e equitativa e de qualidade, e promover oportunidades de aprendizagem ao longo da vida para todas e todos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Até 2030, garantir que todas as meninas e meninos completem o ensino primário e secundário livre, equitativo e de qualidade, que conduza a resultados de aprendizagem relevantes e eficazes. Assegurar a igualdade de acesso para todos os  homens e mulheres à educação técnica, profissional e superior de qualidade, a preços  acessíveis, incluindo universidade.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFEF402D),
                    collapsedBackgroundColor: const Color(0xFFEF402D),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 5',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Alcançar a igualdade de gênero e empoderar todas as mulheres e meninas',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Visa alcançar a igualdade de gênero e empoderamento das mulheres. Isso inclui acabar com discriminação e violência, reconhecer trabalho doméstico, promover participação política das mulheres, garantir acesso à saúde sexual e reprodutiva, e fortalecer políticas de igualdade de gênero.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF27BFE6),
                    collapsedBackgroundColor: const Color(0xFF27BFE6),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 6',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Assegurar a disponibilidade e gestão sustentável da água e saneamento para todas e todos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Visa garantir o acesso universal à água potável e saneamento até 2030. Isso inclui melhorar a qualidade da água, reduzir a poluição, aumentar a eficiência no uso da água e enfrentar a escassez hídrica. Também propõe a gestão integrada dos recursos hídricos, proteção de ecossistemas relacionados à água e cooperação internacional para apoiar países em desenvolvimento. Além disso, busca fortalecer a participação das comunidades locais na gestão da água e saneamento.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFFBC412),
                    collapsedBackgroundColor: const Color(0xFFFBC412),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 7',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Assegurar o acesso confiável,  sustentável, moderno e a preço acessível à energia para todas e todos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Visa garantir acesso universal a serviços de energia até 2030, com ênfase em energias renováveis e eficiência energética. Isso inclui aumentar a participação das energias renováveis, dobrar a taxa de melhoria da eficiência energética e fortalecer a cooperação internacional para pesquisa e tecnologias de energia limpa. Além disso, propõe expandir a infraestrutura de energia sustentável nos países em desenvolvimento,  especialmente os menos desenvolvidos e os pequenos Estados insulares em desenvolvimento.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFA31C44),
                    collapsedBackgroundColor: const Color(0xFFA31C44),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 8',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Promover o crescimento econômico sustentado, inclusivo e sustentável, emprego pleno e produtivo e trabalho decente para todas e todos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Busca promover o crescimento econômico sustentável e emprego decente. Isso inclui sustentar o crescimento do PIB nos países menos desenvolvidos, aumentar a produtividade, promover políticas de desenvolvimento, melhorar a eficiência no uso de recursos e erradicar o trabalho forçado e infantil. Também visa garantir ambientes de trabalho seguros e promover o turismo sustentável, além de expandir o acesso aos serviços financeiros e apoiar o comércio nos países em desenvolvimento.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFF26A2E),
                    collapsedBackgroundColor: const Color(0xFFF26A2E),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 9',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Construir infraestruturas resilientes, promover a industrialização inclusiva e sustentável e fomentar a inovação',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'O Objetivo 9 da Agenda 2030 busca promover  infraestrutura sustentável e industrialização inclusiva. Isso inclui desenvolver infraestrutura de qualidade, acessível e resiliente para apoiar o crescimento econômico e o bem-estar humano, especialmente em áreas regionais e transfronteiriças. É também sobre aumentar a participação da indústria no emprego e no PIB, fortalecer pequenas indústrias com acesso a serviços financeiros, modernizar e tornar sustentáveis as indústrias, promover pesquisa e inovação tecnológica, facilitar o desenvolvimento de infraestrutura em países em desenvolvimento, apoiar tecnologia e inovação nacional, e melhorar o acesso à tecnologia da informação e comunicação,  incluindo internet acessível nos países menos desenvolvidos.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFDE1768),
                    collapsedBackgroundColor: const Color(0xFFDE1768),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 10',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Reduzir a desigualdade dentro dos países e entre eles',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'O Objetivo 10 da Agenda 2030 visa reduzir as desigualdades dentro e entre os países. Isso inclui alcançar um crescimento de renda mais rápido para os 40% mais pobres da população, promover a inclusão social, econômica e política para todos, eliminar práticas discriminatórias, adotar políticas fiscais e de proteção social para aumentar a igualdade, fortalecer a regulamentação financeira global, aumentar a representação dos países em desenvolvimento em instituições financeiras internacionais, facilitar a migração segura e ordenada, implementar tratamento especial para países em desenvolvimento, aumentar a assistência ao desenvolvimento, e reduzir os custos de transação de remessas dos migrantes.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFF89D2A),
                    collapsedBackgroundColor: const Color(0xFFF89D2A),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 11',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Tornar as cidades e os assentamentos humanos inclusivos, seguros, resilientes e sustentáveis',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'O Objetivo 11 da Agenda 2030 visa tornar as cidades e assentamentos humanos inclusivos, seguros, resilientes e sustentáveis. Isso inclui garantir acesso à habitação segura e acessível, urbanizar favelas, melhorar sistemas de transporte sustentáveis e seguros, promover urbanização inclusiva e capacidades de gestão de assentamentos humanos, proteger patrimônios cultural e natural, reduzir mortes e impactos econômicos de desastres, diminuir o impacto ambiental das cidades, proporcionar acesso universal a espaços públicos seguros e verdes, apoiar relações positivas entre áreas urbanas, periurbanas e rurais, implementar políticas para mitigação e adaptação às mudanças climáticas, e apoiar construções sustentáveis em países menos desenvolvidos.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFFBF8D2C),
                    collapsedBackgroundColor: const Color(0xFFBF8D2C),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 12',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Assegurar padrões de produção e de consumo sustentáveis',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'O Objetivo 12 da Agenda 2030 visa promover padrões sustentáveis de produção e consumo. Isso inclui implementar o Plano Decenal de Programas sobre Produção e Consumo Sustentáveis, alcançar gestão sustentável e uso eficiente dos recursos naturais, reduzir desperdício de alimentos e perdas ao longo das cadeias de produção, alcançar manejo ambientalmente saudável de produtos químicos e resíduos, reduzir geração de resíduos através de prevenção, redução, reciclagem e reuso, incentivar práticas sustentáveis nas empresas, promover compras públicas sustentáveis, aumentar a conscientização sobre desenvolvimento sustentável, apoiar capacidades científicas e tecnológicas em países em desenvolvimento, monitorar impactos do turismo sustentável, e racionalizar subsídios aos combustíveis fósseis de forma a minimizar impactos adversos e proteger comunidades afetadas.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF407F46),
                    collapsedBackgroundColor: const Color(0xFF407F46),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 13',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Tomar medidas urgentes para combater a mudança climática e seus impactos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Reforçar a resiliência e a capacidade de adaptação a riscos relacionados ao clima e às catástrofes naturais em todos os países Integrar medidas da mudança do clima nas políticas, estratégias e planejamentos nacionais Melhorar a educação, aumentar a conscientização e a capacidade humana e institucional sobre mitigação, adaptação redução de impacto e alerta precoce da mudança do clima.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF1F87D4),
                    collapsedBackgroundColor: const Color(0xFF1F87D4),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 14',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Conservaçãoe uso sustentável dos oceanos, dos mares e dos recursos marinhos para o desenvolvimento sustentável',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Até 2025, prevenir e reduzir significativamente a poluição marinha de todos os tipos, especialmente a advinda de atividades terrestres, incluindo detritos marinhos e a poluição por nutrientes.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF4DB638),
                    collapsedBackgroundColor: const Color(0xFF4DB638),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 15',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Proteger, recuperar e promover o uso sustentável dos ecossistemas terrestres, gerir de forma sustentável as florestas, combater a desertificação, deter e reverter a degradação da terra e deter a perda de biodiversidade',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Garantir uma repartição justa e equitativa dos benefícios derivados da utilização dos recursos genéticos e promover o acesso adequado aos recursos genéticos Tomar medidas urgentes para acabar com a caça ilegal e o tráfico de espécies da flora e fauna protegidas e abordar tanto a demanda quanto a oferta de produtos ilegais da vida selvagem Mobilizar e aumentar significativamente, a partir de todas as fontes, os recursos financeiros para a conservação e o uso sustentável da biodiversidade e dos ecossistemasMobilizar recursos significativos de todas as fontes e em todos os níveis para financiar o manejo florestal sustentável e proporcionar incentivos adequados aos países em desenvolvimento para promover o manejo florestal sustentável, inclusive para a conservação e o reflorestamento Reforçar o apoio global para os esforços de combate à caça ilegal e ao tráfico de espécies protegidas, inclusive por meio do aumento da capacidade das comunidades locais para buscar oportunidades de subsistência sustentável.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF136A9F),
                    collapsedBackgroundColor: const Color(0xFF136A9F),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 16',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Promover sociedades pacíficas e inclusivas para o desenvolvimento sustentável, proporcionar o acesso à justiça para todos e construir instituições eficazes, responsáveis e inclusivas em todos os níveis',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'Reduzir significativamente todas as formas de violência e as taxas de mortalidade relacionada em todos os lugares Acabar com abuso, exploração, tráfico e todas as formas de violência e tortura contra crianças Promover o Estado de Direito, em nível nacional e internacional, e garantir a igualdade de acesso à justiça para todos.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    backgroundColor: const Color(0xFF14496B),
                    collapsedBackgroundColor: const Color(0xFF14496B),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Objetivo 17',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.75,
                                  child: Text(
                                    'Fortalecer os meios de implementação e revitalizar a parceria global para o desenvolvimento sustentável',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'FINANÇAS:\nFortalecer a mobilização de recursos internos, inclusive por meio do apoio internacional aos países em desenvolvimento, para melhorar a capacidade nacional para arrecadação de impostos e outras receitas.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'TECNOLOGIA:\nPromover o desenvolvimento, a transferência, a disseminação e a difusão de tecnologias ambientalmente corretas para os países em desenvolvimento, em condições favoráveis, inclusive em condições concessionais e preferenciais, conforme mutuamente acordado',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'CAPACITAÇÃO:\nReforçar o apoio internacional para a implementação eficaz e orientada da capacitação em países em desenvolvimento, a fim de apoiar os planos nacionais para implementar todos os objetivos de desenvolvimento sustentável, inclusive por meio da cooperação Norte-Sul, Sul-Sul e triangular.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'COMÉRCIO:\nPromover um sistema multilateral de comércio universal, baseado em regras, aberto, não discriminatório e equitativo no âmbito da Organização Mundial do Comércio, inclusive por meio da conclusão das negociações no âmbito de sua Agenda de Desenvolvimento de Doha.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'QUESTÕES SISTÊMICAS:\nCoerência de políticas e institucional. Aumentar a estabilidade macroeconômica global, inclusive por meio da coordenação e da coerência de políticas Aumentar a coerência das políticas para o desenvolvimento sustentável Respeitar o espaço político e a liderança de cada país para estabelecer e implementar políticas para a erradicação da pobreza e o desenvolvimento sustentável.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'AS PARCERIAS MULTISSETORIAIS:\nReforçar a parceria global para o desenvolvimento sustentável, complementada por parcerias multissetoriais que mobilizem e compartilhem conhecimento, expertise, tecnologia e recursos financeiros, para apoiar a realização dos objetivos do desenvolvimento sustentável em todos os países, particularmente nos países em desenvolvimento Incentivar e promover parcerias públicas, público-privadas e com a sociedade civil eficazes, a partir da experiência das estratégias de mobilização de recursos dessas parcerias.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    width: screenWidth * 0.75,
                                    child: Text(
                                      'DADOS, MONITORAMNETO E PRESTAÇÃO DE CONTAS:\nAté 2030, valer-se de iniciativas existentes para desenvolver medidas do progresso do desenvolvimento sustentável que complementem o produto interno bruto [PIB] e apoiem a capacitação estatística nos países em desenvolvimento.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
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
              ])),
        ],
      ),
    );
  }
}
