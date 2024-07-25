import 'package:feteps/NossaEquipe_page.dart';
import 'package:feteps/appbar/appbar2_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class RibasPage extends StatelessWidget {
  final String githubUrl = "https://github.com/edwardribas";
  final String linkedinUrl = "https://www.linkedin.com/in/edwardribas/";
  final String email = "";

  const RibasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String gitAsset = themeProvider.getGitAsset();

    return Scaffold(
      appBar: AppBar2_page(
          screenWidth: screenWidth, destinationPage: const NossaEquipePage()),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.03, bottom: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Participante do Projeto',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.getSpecialColor3(),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'lib/assets/equipe/ribas.png',
                      height: screenHeight * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.03),
                  child: Container(
                    color: const Color(0xFFFFD35F),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Text(
                        'Ribas',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                  ),
                  child: Container(
                    color: const Color(0xFFD9D9D9),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Text(
                        'Prototipação e desenvolvimento da plataforma web',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ex estudante da ETEC Prof Maria Cristina Medeiros',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.getSpecialColor3(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () async {
                            _launchURL(githubUrl);
                          },
                          child: Image.asset(
                            gitAsset,
                            width: screenWidth * 0.12,
                          )),
                      InkWell(
                          onTap: () async {
                            _launchURL(linkedinUrl);
                          },
                          child: Image.asset(
                            'lib/assets/linkedin.png',
                            width: screenWidth * 0.1,
                          )),
                      IconButton(
                        icon: Icon(Icons.email,
                            color: themeProvider.getSpecialColor(),
                            size: screenWidth * 0.1),
                        onPressed: () => _copyToClipboard(email, context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
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

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Email copiado para a área de transferência')),
    );
  }
}
