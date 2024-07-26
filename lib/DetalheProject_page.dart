import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Atualização aqui
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String? bannerUrl = project['banner'];
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    // Converte o 'id_ods' para string e fornece um valor padrão se for null
    String odsId =
        project['ods']['id_ods']?.toString() ?? 'ID ODS Não Disponível';
    String nameOds =
        project['ods']['name_ods']?.toString() ?? 'Nome ODS Não Disponível';

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
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              // Exibe o ID ODS convertido para string
              'ODS $odsId: $nameOds',
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
                color: cor(project["ods"]["id_ods"]),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          if (bannerUrl != null && bannerUrl.isNotEmpty)
            Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                  border: Border.all(
                color: themeProvider.getBorderColor(),
                width: 2.5,
              )),
              child: Image.network(
                bannerUrl,
                width: screenWidth * 0.42,
                height: screenHeight * 0.19,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/assets/Rectangle.png',
                    width: screenWidth * 0.42,
                  );
                },
              ),
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
          const SizedBox(height: 30),
          Text(
            'Resumo',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor(),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            project['project_abstract'] ?? 'Este projeto não possuí um resumo.',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.042,
              color: themeProvider.getSpecialColor3(),
            ),
            textAlign: TextAlign.justify,
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
            spacing: 20.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.spaceAround,
            children: [
              // Itera sobre os expositores e cria um IconPerson para cada um
              for (var exhibitor in project['exhibitors'])
                IconPerson(
                  exhibitor: exhibitor,
                  numberOfExhibitors: project['exhibitors'].length,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconPerson extends StatelessWidget {
  final Map<String, dynamic> exhibitor;
  final int numberOfExhibitors; // Novo parâmetro

  const IconPerson(
      {super.key, required this.exhibitor, required this.numberOfExhibitors});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double getPhotoSize(int numberOfPhotos) {
      if (numberOfPhotos >= 4) {
        return screenWidth * 0.12;
      } else if (numberOfPhotos == 3) {
        return screenWidth * 0.15;
      } else if (numberOfPhotos == 2) {
        return screenWidth * 0.18;
      } else {
        return screenWidth * 0.2;
      }
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: themeProvider.getSpecialColor5(),
                    title: Text(
                      'Informações do Integrante:',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF0E414F),
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                      height: screenHeight * 0.23,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0E414F),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: SvgPicture.network(
                                      'https://api.dicebear.com/9.x/bottts/svg?seed=${exhibitor['name_exhibitor']} ',
                                      width:
                                          screenWidth * 0.2, // Corrigido aqui
                                      placeholderBuilder: (context) =>
                                          CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth * 0.64,
                                child: Text(
                                  'Nome: ${exhibitor['name_exhibitor'] ?? 'Nome Desconhecido'}',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  'Tipo: ${exhibitor['user_type']?['description'] ?? 'Tipo não indentificado'}'),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: exhibitor['photo'] != null && exhibitor['photo'].isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(exhibitor['photo']),
                  radius: 25,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E414F),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeProvider.getBorderColor(),
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: SvgPicture.network(
                      'https://api.dicebear.com/9.x/bottts/svg?seed=${exhibitor['name_exhibitor']} ',
                      width: getPhotoSize(numberOfExhibitors), // Corrigido aqui
                      placeholderBuilder: (context) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
