import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                          Text(
                            exhibitor[0]["name_exhibitor"] ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 14, 56, 70),
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
                              Image.network(
                                exhibitor[0]["photo"],
                                width: MediaQuery.of(context).size.width * 0.7,
                              )
                            else
                              Image.asset(
                                'lib/assets/placeholder.png',
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              palestrante["title"] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0E414F),
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
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 179, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              _shortenText(palestrante["summary"] ?? '', 25),
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                color: Colors.black,
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
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 14, 56, 70),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: Colors.black38,
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

  @override
  Widget build(BuildContext context) {
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
            width: 185.0,
            height: 240.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                if (ex != null && ex["photo"] != null && ex["photo"].isNotEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.185,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.5,
                      ),
                    ),
                    child: Image.network(
                      ex["photo"],
                      width: MediaQuery.of(context).size.width * 0.42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/assets/Rectangle.png',
                          width: MediaQuery.of(context).size.width * 0.42,
                        );
                      },
                    ),
                  )
                else
                  Image.asset(
                    'lib/assets/Rectangle.png',
                    width: MediaQuery.of(context).size.width * 0.42,
                  ),
                const SizedBox(height: 5.0),
                Text(
                  ex != null ? ex["name_exhibitor"] ?? '' : '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  oPalestrante["title"] ?? '',
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
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
