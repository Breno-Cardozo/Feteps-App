import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar1_page(
          screenWidth: screenWidth, destinationPage: const SobrePage()),
      endDrawer: const MenuPage(),
      body: ListView(children: [
        Column(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  'Mapa',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.getSpecialColor2()),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 6.0,
                  child: Image.asset(
                    'lib/assets/MapaFeira.png',
                    width: screenWidth * 0.9,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CA146),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Estande de Apoiadores',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: themeProvider.getSpecialColor3()),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB6382B),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Estande dos estudantes\n(Cada espaço com 4 estandes)',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: themeProvider.getSpecialColor3()),
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
