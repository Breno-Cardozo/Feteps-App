import 'package:feteps/Mascote_page.dart';
import 'package:feteps/cadastro2_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class TermosUsoPage extends StatefulWidget {
  const TermosUsoPage({super.key});

  @override
  State<TermosUsoPage> createState() => _TermosUsoPageState();
}

class _TermosUsoPageState extends State<TermosUsoPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                        child: Cadastro2Page(
                          selectedItem: '',
                          selectedItemInstituicao: '',
                        ),
                        type: PageTransitionType.leftToRightWithFade,
                        alignment: Alignment.center),
                  );
                  return false;
                },
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: Cadastro2Page(
                              selectedItem: '', selectedItemInstituicao: ''),
                          type: PageTransitionType.leftToRightWithFade,
                          alignment: Alignment.center),
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
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TERMOS DE USO",
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenWidth * 0.08,
                      color: themeProvider.getSpecialColor2(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    child: Text(
                      'O presente Termo de Uso regula as condições para o uso dos ambientes FETEPS (http://feteps.cpscetec.com.br/) e FETEPS Virtual (http://fetepsvirtual.cpscetec.com.br/), celebrado entre Centro Estadual de Educação Tecnológica Paula Souza e o “USUÁRIO”, nos termos a seguir:',
                      style: GoogleFonts.oswald(
                          color: themeProvider.getSpecialColor3(),
                          fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1ª DEFINIÇÕES",
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenWidth * 0.065,
                      color: themeProvider.getSpecialColor2(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    child: Text(
                      'Para facilitar o entendimento deste Termo de Uso editado pela Centro Paula Souza, tem-se que os termos a seguir sempre que usados em maiúsculo, terão o seguinte significado:',
                      style: GoogleFonts.oswald(
                          color: themeProvider.getSpecialColor3(),
                          fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1.1 USUÁRIO",
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenWidth * 0.05,
                      color: themeProvider.getSpecialColor2(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    child: Text(
                      'Trata-se de alunos e professores do Centro Paula Souza (Fatec e Etec), e/ou escolas de Educação Profissional de Nível Médio e Nível Superior Tecnológico Nacionais e Internacionais;',
                      style: GoogleFonts.oswald(
                          color: themeProvider.getSpecialColor3(),
                          fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1.2 COMISSÃO ORGANIZADORA",
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenWidth * 0.05,
                      color: themeProvider.getSpecialColor2(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    child: Text(
                      'A comissão organizadora do evento é responsável pela infraestrutura de apresentação dos projetos. Ela é composta por docentes e técnicos administrativos do Centro Paula Souza, vinculados à Cetec, Cesu e Arinter, sendo responsável por:',
                      style: GoogleFonts.oswald(
                          color: themeProvider.getSpecialColor3(),
                          fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
