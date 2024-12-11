import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Menu_Page.dart';
import 'appbar/appbar1_page.dart';
import 'global.dart';
import 'sobre_page.dart';
import 'Temas/theme_provider.dart';

class PatrocinadoresPage extends StatefulWidget {
  const PatrocinadoresPage({super.key});

  @override
  _PatrocinadoresPageState createState() => _PatrocinadoresPageState();
}

class _PatrocinadoresPageState extends State<PatrocinadoresPage> {
  final Map<String, List<dynamic>> _patrocinadoresCache = {
    "Apoio Especial": [],
    "Patrocinador Especial": [],
    "Patrocinador Master": [],
    "Patrocinador Diamante": [],
    "Patrocinador Ouro": [],
    "Patrocinador Prata": [],
    "Apoio Institucional": [],
    "Apoio Comunicação e Mídia": []
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatrocinadores();
  }

  Future<void> _fetchPatrocinadores() async {
    await Future.wait([
      _fetchPatrocinadoresByType("Apoio Especial"),
      _fetchPatrocinadoresByType("Patrocinador Especial"),
      _fetchPatrocinadoresByType("Patrocinador Master"),
      _fetchPatrocinadoresByType("Patrocinador Diamante"),
      _fetchPatrocinadoresByType("Patrocinador Ouro"),
      _fetchPatrocinadoresByType("Patrocinador Prata"),
      _fetchPatrocinadoresByType("Apoio Institucional"),
      _fetchPatrocinadoresByType("Apoio Comunicação e Mídia"),
    ]);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchPatrocinadoresByType(String type) async {
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    final response = await client.get(Uri.parse(
        GlobalPageState.Url + '/appfeteps/pages/Exhibitor/get.php?type=$type'));

    if (response.statusCode == 200) {
      final List<dynamic> patrocinadores =
          json.decode(response.body)['response'];
      setState(() {
        _patrocinadoresCache[type] = patrocinadores;
      });
    } else {
      throw Exception('Falha ao carregar os patrocinadores');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.getSpecialColor5(),
      appBar:
          AppBar1_page(screenWidth: screenWidth, destinationPage: SobrePage()),
      endDrawer: const MenuPage(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFD35F)))
          : ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          child: Text(
                            'Parceiros',
                            style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.getSpecialColor3()),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildPatrocinadoresSection('Apoio Especial'),
                    _buildPatrocinadoresSection('Patrocinador Especial'),
                    _buildPatrocinadoresSection('Patrocinador Master'),
                    _buildPatrocinadoresSection('Patrocinador Diamante'),
                    _buildPatrocinadoresSection('Patrocinador Ouro'),
                    _buildPatrocinadoresSection('Patrocinador Prata'),
                    _buildPatrocinadoresSection('Apoio Institucional'),
                    _buildPatrocinadoresSection('Apoio Comunicação e Mídia'),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildPatrocinadoresSection(String type) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<dynamic>? patrocinadores = _patrocinadoresCache[type];
    if (patrocinadores == null) {
      // Trate o caso em que a lista é nula
      return Text('Erro ao carregar patrocinadores');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Row(
            children: [
              Text(
                type,
                style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getSpecialColor3()),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.05),
        patrocinadores.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Wrap(
                  spacing: 8.0, // Espaçamento horizontal entre as imagens
                  runSpacing: 8.0, // Espaçamento vertical entre as imagens
                  alignment: WrapAlignment.start,
                  children: patrocinadores
                      .map((patrocinador) =>
                          _buildPatrocinadorImage(patrocinador))
                      .toList(),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(screenWidth * 0.1),
                child: Text(
                  'Nenhum patrocinador encontrado.',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05,
                      color: themeProvider.getSpecialColor()),
                  textAlign: TextAlign.center,
                ),
              ),
        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }

  Widget _buildPatrocinadorImage(dynamic patrocinador) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String emailExpositor = patrocinador['email_expositor'] ?? 'Contato';
    String photo = patrocinador['photo'] ?? 'lib/assets/Rectangle.png';

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.012),
      child: InkWell(
        onTap: () => _launchURL(emailExpositor),
        child: FutureBuilder<ImageProvider>(
          future: _loadImage(photo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: screenHeight * 0.15,
                width: screenWidth * 0.4,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Image.asset(
                'lib/assets/Rectangle.png',
                width: screenWidth * 0.42,
              );
            } else {
              return Image(
                image: snapshot.data ?? AssetImage('lib/assets/Rectangle.png'),
                width: screenWidth * 0.42,
                fit: BoxFit.cover,
              );
            }
          },
        ),
      ),
    );
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
