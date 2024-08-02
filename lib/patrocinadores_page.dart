// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/global.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class PatrocinadoresPage extends StatefulWidget {
  const PatrocinadoresPage({super.key});

  @override
  _PatrocinadoresPageState createState() => _PatrocinadoresPageState();
}

class _PatrocinadoresPageState extends State<PatrocinadoresPage> {
  List<dynamic> patrocinadores = [];

  @override
  void initState() {
    super.initState();
    fetchPatrocinadores();
  }

  Future<void> fetchPatrocinadores() async {
    final url = Uri.parse(GlobalPageState.Url +
        '/appfeteps/pages/Exhibitor/get.php?type=Patrocinador');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        patrocinadores = data['response'] ?? [];
      });
    } else {
      // Lidar com erro de requisição
      print('Erro ao buscar patrocinadores: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar:
          AppBar1_page(screenWidth: screenWidth, destinationPage: SobrePage()),
      endDrawer: const MenuPage(),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Text(
                      'Apoiadores',
                      style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.getSpecialColor2()),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              for (int i = 0; i < patrocinadores.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (i < patrocinadores.length)
                      CardWidget(
                        patrocinador: patrocinadores[i],
                      ),
                    if (i + 1 < patrocinadores.length)
                      CardWidget(
                        patrocinador: patrocinadores[i + 1],
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final dynamic patrocinador;
  const CardWidget({super.key, required this.patrocinador});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String nameExhibitor =
        patrocinador['name_exhibitor'] ?? 'Nome do Patrocinador';
    String emailExpositor = patrocinador['email_expositor'] ?? 'Contato';
    String photo = patrocinador['photo'] ?? 'lib/assets/Rectangle.png';

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.012),
      child: InkWell(
        onTap: () => _launchURL(emailExpositor),
        child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
          child: SizedBox(
            width: screenWidth * 0.42,
            height: screenHeight * 0.15,
            child: Center(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.015),
                      Image.network(
                        photo,
                        width: screenWidth * 0.4,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('lib/assets/Rectangle.png',
                              width: screenWidth * 0.33);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        nameExhibitor,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (url.isEmpty) {
      print('URL is empty');
      return;
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      print('Could not launch $url');
    }
  }
}
