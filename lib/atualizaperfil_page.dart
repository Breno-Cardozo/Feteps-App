import 'package:feteps/appbar/appbar2_page.dart';
import 'package:feteps/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'global.dart';

class AtualizarDadosPage extends StatelessWidget {
  const AtualizarDadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0E414F))),
      home: Scaffold(
        appBar: AppBar2_page(
            screenWidth: screenWidth, destinationPage: const PerfilPage()),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    left: screenWidth * 0.07,
                    bottom: screenHeight * 0.04,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Atualizar dados",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.069,
                          color: const Color(0xFF0E414F),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/user.png',
                        width: screenWidth * 0.45,
                      ),
                    ],
                  ),
                ),
                buildTextField(
                  context,
                  labelText: 'Nome de usuário:',
                ),
                buildTextField(
                  context,
                  labelText: 'Estado:',
                ),
                buildTextField(
                  context,
                  labelText: 'Cidade:',
                ),
                buildTextField(
                  context,
                  labelText: ' Cod Instituição:',
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.04, bottom: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: const Color(0xFFB6382B),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.012,
                              right: MediaQuery.of(context).size.width * 0.012),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 39),
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                            ),
                            child: Text(
                              "Atualizar",
                              style: GoogleFonts.oswald(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextField(BuildContext context, {required String labelText}) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.8,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
