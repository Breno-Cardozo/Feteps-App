import 'dart:io';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

final TextStyle interTextStyle = GoogleFonts.inter();

class tela_palestrante extends StatelessWidget {
  final List<dynamic> lista;
  final Map<String, dynamic> palestrante;
  final Map<String, List<dynamic>> totalP;

  const tela_palestrante({
    super.key,
    required this.lista,
    required this.palestrante,
    required this.totalP,
  });

  Future<ImageProvider> _loadImage(String url) async {
    final httpClient = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      print('Erro ao carregar imagem: ${response.statusCode}');
      return AssetImage('lib/assets/placeholder.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String logoAsset = themeProvider.getLogoAsset();
    final exhibitor = palestrante["exhibitors"] as List<dynamic>?;

    // Obtém todos os palestrantes a partir do totalP
    final allSpeakers = totalP.values.expand((list) => list).toList();

    // Filtra a lista para excluir o palestrante atual
    final outrosPalestrantes =
        allSpeakers.where((p) => p != palestrante).toList();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 400,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: Image.asset(
                  logoAsset,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
      body: exhibitor == null || exhibitor.isEmpty
          ? Center(
              child: Text(
                'Nenhum palestrante encontrado',
                style: GoogleFonts.inter(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.8,
                            child: Text(
                              exhibitor[0]["name_exhibitor"] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.getSpecialColor2(),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (exhibitor[0]["photo"] != null &&
                                exhibitor[0]["photo"].isNotEmpty)
                              FutureBuilder<ImageProvider>(
                                future: _loadImage(exhibitor[0]["photo"]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  } else if (snapshot.hasError ||
                                      !snapshot.hasData) {
                                    return Image.asset(
                                      'lib/assets/placeholder.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                    );
                                  } else {
                                    return Image(
                                      image: snapshot.data!,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                              )
                            else
                              Image.asset(
                                'lib/assets/placeholder.png',
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              palestrante["title"] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.getSpecialColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Resumo:',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.048,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.getSpecialColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.8,
                              child: Text(
                                palestrante["summary"] ?? '',
                                style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.042,
                                    color: themeProvider.getSpecialColor3()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Outros Palestrantes:',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.048,
                                color: themeProvider.getSpecialColor2(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: themeProvider.getBorderColor(),
                          thickness: 1,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var outroPalestrante in outrosPalestrantes)
                              CardWidget(
                                oPalestrante: outroPalestrante,
                                list: lista,
                                totalPP: totalP,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Map<String, dynamic> oPalestrante;
  final List<dynamic> list;
  final Map<String, List<dynamic>> totalPP;

  CardWidget({
    Key? key,
    required this.oPalestrante,
    required this.list,
    required this.totalPP,
  }) : super(key: key);

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final ex = (oPalestrante["exhibitors"] as List).isNotEmpty
        ? oPalestrante["exhibitors"][0]
        : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => tela_palestrante(
                lista: list,
                palestrante: oPalestrante,
                totalP: totalPP,
              ),
            ),
          );
        },
        child: Card(
          color: const Color(0xFFFFD35F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.5,
            height: screenHeight * 0.29,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: themeProvider.getSpecialColor4(),
                          border: Border.all(
                              color: themeProvider.getSpecialColor3(),
                              width: 2)),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        ex != null
                            ? _shortenText(ex["name_exhibitor"], 38) ?? ''
                            : '',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: themeProvider.getSpecialColor3(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      child: Text(
                        _shortenText(oPalestrante["title"], 38) ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.getSpecialColor3(),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                          color: themeProvider.getSpecialColor4()),
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        _getHorario(oPalestrante[
                            "date_time"]), // Exibe apenas o horário
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: themeProvider.getSpecialColor3(),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: themeProvider.getBorderColor(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _shortenText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

String _getHorario(String dateTime) {
  if (dateTime.isNotEmpty && dateTime.contains(' ')) {
    String horarioCompleto = dateTime.split(' ')[1]; // Pega o horário completo
    return horarioCompleto.substring(
        0, 5); // Extrai apenas os primeiros 5 caracteres (HH:MM)
  }
  return '';
}
