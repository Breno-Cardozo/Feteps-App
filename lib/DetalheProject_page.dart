import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:feteps/Temas/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalheProjectPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const DetalheProjectPage({super.key, required this.project});

  static Color cor(int ods) {
    switch (ods) {
      case 1:
        return const Color.fromARGB(255, 179, 0, 0);
      case 2:
        return const Color.fromARGB(255, 201, 177, 0);
      case 3:
        return const Color.fromARGB(255, 60, 131, 66);
      case 4:
        return const Color.fromARGB(255, 127, 13, 13);
      case 5:
        return const Color.fromARGB(255, 201, 59, 7);
      case 6:
        return const Color.fromARGB(255, 22, 149, 199);
      case 7:
        return const Color.fromARGB(255, 255, 234, 71);
      case 8:
        return const Color.fromARGB(255, 88, 3, 27);
      case 9:
        return const Color.fromARGB(255, 225, 107, 16);
      case 10:
        return const Color.fromARGB(255, 222, 79, 48);
      case 11:
        return const Color.fromARGB(255, 241, 150, 1);
      case 12:
        return const Color.fromARGB(255, 229, 194, 1);
      case 13:
        return const Color.fromARGB(255, 51, 128, 56);
      case 14:
        return const Color.fromARGB(255, 36, 119, 198);
      case 15:
        return const Color.fromARGB(255, 94, 147, 48);
      case 16:
        return const Color.fromARGB(255, 14, 101, 184);
      case 17:
        return const Color.fromARGB(255, 22, 71, 141);
      default:
        return const Color.fromARGB(255, 0, 0, 0);
    }
  }

  Future<ImageProvider> _loadImage(String url) async {
    final httpClient = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      print('Erro ao carregar imagem: ${response.statusCode}');
      return AssetImage('lib/assets/Rectangle.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String? bannerUrl = project['banner'];
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    String odsId =
        project['ods']['id_ods']?.toString() ?? 'ID ODS Não Disponível';
    String nameOds =
        project['ods']['name_ods']?.toString() ?? 'Nome ODS Não Disponível';
    String link = project['video_url'] ?? 'Link Não Disponível';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: 400,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, bottom: 15),
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
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              'ODS $odsId: $nameOds',
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
                color: cor(project["ods"]["id_ods"]),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          if (bannerUrl != null && bannerUrl.isNotEmpty)
            FutureBuilder<ImageProvider>(
              future: _loadImage(bannerUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: screenHeight * 0.25,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Image.asset(
                    'lib/assets/Rectangle.png',
                    width: screenWidth * 0.42,
                  );
                } else {
                  return Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: themeProvider.getBorderColor(),
                      width: 2.5,
                    )),
                    child: Image(
                      image: snapshot.data ??
                          AssetImage('lib/assets/Rectangle.png'),
                      width: screenWidth * 0.42,
                      height: screenHeight * 0.19,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            )
          else
            Image.asset(
              'lib/assets/Rectangle.png',
              width: screenWidth * 0.42,
            ),
          const SizedBox(height: 20),
          Text(
            project['name_project'] ?? 'Nome do Projeto',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor3(),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.035),
          Text(
            'Resumo',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor(),
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Text(
            project['project_abstract'] ?? 'Este projeto não possui um resumo.',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.042,
              color: themeProvider.getSpecialColor3(),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'Link do Youtube',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor(),
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          InkWell(
            onTap: () async {
              _launchURL(link);
            },
            child: Text(
              project['video_url'] ?? 'Este projeto não possui um link.',
              style: GoogleFonts.roboto(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD35F),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(
            color: themeProvider.getSpecialColor3(),
            height: 40,
            thickness: 2,
          ),
          Text(
            "Integrantes",
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor(),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            runSpacing: screenHeight * 0.01,
            alignment: WrapAlignment.spaceAround,
            children: [
              for (var exhibitor in project['exhibitors'])
                FlipCardPerson(exhibitor: exhibitor),
            ],
          ),
        ],
      ),
    );
  }
}

class FlipCardPerson extends StatelessWidget {
  final Map<String, dynamic> exhibitor;

  const FlipCardPerson({
    super.key,
    required this.exhibitor,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Remove "Expositor - " se estiver presente
    String description = exhibitor['user_type']?['description']
            ?.replaceFirst('Expositor - ', '') ??
        'Tipo não identificado';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.23,
          padding: const EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: themeProvider.getSpecialColor2(),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeProvider.getSpecialColor2(),
                    width: 1,
                  ),
                ),
                child: ClipOval(
                    child: Image.asset(
                  'lib/assets/user2.png',
                  width: screenWidth * 0.2,
                )),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: screenWidth * 0.35,
                child: Text(
                  exhibitor['name_exhibitor'],
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getSpecialColor2(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        back: Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.23,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: themeProvider.getSpecialColor2(),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeProvider.getSpecialColor2(),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'lib/assets/fundo.png',
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description, // Exibe apenas "Prof. Orientador" ou "Aluno"
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.034,
                  color: themeProvider.getSpecialColor3(),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
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
