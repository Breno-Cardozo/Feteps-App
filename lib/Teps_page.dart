import 'package:feteps/Mascote_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class TepsPage extends StatefulWidget {
  const TepsPage({super.key});

  @override
  State<TepsPage> createState() => _TepsPageState();
}

class _TepsPageState extends State<TepsPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFCDDFDF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDDFDF),
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
                  Text('Teps',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF18424D)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.75,
                    child: Text(
                      'Era uma vez, um robô chamado Teps, criado pelos estudantes da CPS para ajudar e apoiar todos na feira tecnológica.',
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
                    'lib/assets/Teps/Teps2.png',
                    width: screenWidth * 0.4,
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
                          color: const Color(0xFF18424D)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.78,
                    child: Text(
                      'Teps pode esticar os braços e transformar suas mãos em qualquer ferramenta necessária, sendo sempre amigável, prestativo e carismático.',
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
                    'lib/assets/Teps/Teps3.png',
                    width: screenWidth * 0.4,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Aparência',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF18424D)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.78,
                    child: Text(
                      'Com um design fofo e redondo, antenas em formato de "F", óculos com detalhes de engrenagem e mãos de garra, Teps tem uma paleta de cores inspirada nos logos da FETEPS.',
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
                  Text('Moral da história',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF18424D)))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.76,
                    child: Text(
                      'Com tecnologia no núcleo e carisma no circuito, Teps na FETEPS, o encanto é o intuito!',
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
                          color: const Color(0xFF18424D)))
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
                      'Emily Takara',
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
