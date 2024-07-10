import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    // Converte o 'id_ods' para string e fornece um valor padrão se for null
    String odsId =
        project['ods']['id_ods']?.toString() ?? 'ID ODS Não Disponível';
    String nameOds =
        project['ods']['name_ods']?.toString() ?? 'Nome ODS Não Disponível';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: Scaffold(
        appBar: AppBar(
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
                      color: const Color(0xFF0E414F),
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
                  color: Colors.black,
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
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Resumo',
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.048,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 208, 20, 20),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project['project_abstract'] ?? 'Lorem ipsum dolor sit amet...',
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.042,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            const Divider(
              color: Colors.black,
              height: 40,
              thickness: 2,
            ),
            Text(
              "Integrantes",
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 14, 56, 70),
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
                  IconPerson(exhibitor: exhibitor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconPerson extends StatelessWidget {
  final Map<String, dynamic> exhibitor;

  const IconPerson({super.key, required this.exhibitor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exibe a foto do expositor, ou um ícone padrão se não houver foto
        exhibitor['photo'] != null && exhibitor['photo'].isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(exhibitor['photo']),
                radius: 25,
              )
            : const FaIcon(
                FontAwesomeIcons.userCircle,
                size: 50.0,
                color: Color.fromARGB(255, 14, 56, 70),
              ),
        const SizedBox(height: 8),
        Text(
          exhibitor['name_exhibitor'] ?? 'Nome Desconhecido',
          style: GoogleFonts.inter(
            fontSize: 14.4,
            color: const Color.fromARGB(255, 14, 56, 70),
          ),
        ),
      ],
    );
  }
}
