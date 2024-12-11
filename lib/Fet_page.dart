import 'package:feteps/Mascote_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class FetPage extends StatefulWidget {
  const FetPage({super.key});

  @override
  State<FetPage> createState() => _FetPageState();
}

class _FetPageState extends State<FetPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1B096),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1B096),
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
                        child: MascotePage(),
                        type: PageTransitionType.size,
                        alignment: Alignment.center),
                  );
                  return false;
                },
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: MascotePage(),
                          type: PageTransitionType.size,
                          alignment: Alignment.center),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 15),
                    child: Icon(
                      size: screenWidth * 0.075,
                      Icons.arrow_back_sharp,
                      color: const Color(0xFF0E414F),
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
                  'lib/assets/logo.png',
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
                  Text('Fet',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA62929)))
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
                      'Era uma vez, um pequeno robô chamado Fet. Inicialmente, ele era apenas uma caixa com olhos e rodas, projetado para tarefas simples. No entanto, ao passar de dono para dono, Fet foi modificado e aprimorado, ganhando novos recursos e habilidades.',
                      style: GoogleFonts.roboto(
                          fontSize: screenWidth * 0.045,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/Fet/Fet2.png',
                    width: screenWidth * 0.35,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Transformação',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA62929)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.85,
                    child: Text(
                      'Com braços longos e elásticos, mãos curvas e a capacidade de se auto-modificar, Fet podia construir qualquer engenhoca maluca e alterar sua própria composição e cores. Sua aparência, com tronco vermelho, rodas azuis e olhos brilhantes, refletia sua natureza atrapalhada e engenhosa.',
                      style: GoogleFonts.roboto(
                          fontSize: screenWidth * 0.045,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/Fet/Fet3.png',
                    width: screenWidth * 0.35,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Moral da história',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA62929)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.85,
                    child: Text(
                      'A história de Fet mostra como uma pequena ideia pode se transformar em algo incrível, exemplificando a importância de apoiar a criatividade e a inovação. Como Fet sempre diz, "É de uma pequena ideia que surge uma grande criação."',
                      style: GoogleFonts.roboto(
                          fontSize: screenWidth * 0.045,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Criadores',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA62929)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.85,
                    child: Text(
                      'Vitória das Neves Oliveira\nArthur Barros Martins Pereira',
                      style: GoogleFonts.roboto(
                          fontSize: screenWidth * 0.045,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
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
