import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:feteps/tela_palestrante.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'global.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class PalestrantesPage extends StatelessWidget {
  const PalestrantesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PalestrantesHomePage(),
    );
  }
}

class PalestrantesHomePage extends StatefulWidget {
  const PalestrantesHomePage({Key? key}) : super(key: key);

  @override
  PalestrantesHomeState createState() => PalestrantesHomeState();
}

class PalestrantesHomeState extends State<PalestrantesHomePage> {
  final Map<String, List<dynamic>> _palestrantesPorData = {};
  final Map<String, String> displayDates = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPalestrantes();
  }

  Future<void> _fetchPalestrantes() async {
    try {
      final response = await http.get(
          Uri.parse(GlobalPageState.Url + '/appfeteps/pages/Event/get.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['response'];
        _organizePalestrantesPorData(data);
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar os palestrantes');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  void _organizePalestrantesPorData(List<dynamic> palestrantes) {
    for (var palestrante in palestrantes) {
      final eventType = palestrante['type_event'];
      if (eventType != null && eventType['description'] == 'Palestra') {
        String data =
            palestrante['date_time'].substring(5, 10).replaceAll('-', '/');
        String fixedDate = _mapDate(palestrante['date_time']);

        if (_palestrantesPorData.containsKey(data)) {
          _palestrantesPorData[data]!.add(palestrante);
        } else {
          _palestrantesPorData[data] = [palestrante];
          displayDates[data] = fixedDate;
        }
      }
    }
  }

  String _mapDate(String date) {
    DateTime dataC = DateTime.parse(date);
    return "${dataC.day}/${dataC.month}";
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar1_page(
          screenWidth: MediaQuery.of(context).size.width * 1.0,
          destinationPage: SobrePage()),
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
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.05),
                          child: Text(
                            'Palestrantes',
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.getSpecialColor2(),
                            ),
                          ),
                        )
                      ],
                    ),
                    _buildPalestranteSections(),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildPalestranteSections() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _palestrantesPorData.entries.map((entry) {
        String data = entry.key;
        String displayDate = displayDates[data]!;
        List<dynamic> palestrantes = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                displayDate,
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: themeProvider.getSpecialColor2(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: MediaQuery.of(context).size.width * 0.005,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: palestrantes.isNotEmpty
                    ? palestrantes.map((palestrante) {
                        return CardWidget(
                            palestrante: palestrante,
                            lista: palestrantes,
                            total: _palestrantesPorData);
                      }).toList()
                    : [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Text(
                            'Ainda não há palestrantes para este dia.',
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Map<String, dynamic> palestrante;
  final Map<String, List<dynamic>> total;
  final List<dynamic> lista;

  CardWidget(
      {required this.palestrante, required this.lista, required this.total});

  @override
  Widget build(BuildContext context) {
    final exhibitor = (palestrante["exhibitors"] as List).isNotEmpty
        ? palestrante["exhibitors"][0]
        : null;
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => tela_palestrante(
                  lista: lista, palestrante: palestrante, totalP: total),
            ),
          );
        },
        child: Card(
          color: const Color(0xFFFFD35F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                if (exhibitor != null && exhibitor["photo"] != null)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.185,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    )),
                    child: Image.network(
                      exhibitor["photo"],
                      width: MediaQuery.of(context).size.width * 0.42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/assets/Rectangle.png',
                          width: MediaQuery.of(context).size.width * 0.4,
                        );
                      },
                    ),
                  )
                else
                  Image.asset(
                    'lib/assets/Rectangle.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                exhibitor != null
                    ? Text(
                        exhibitor["name_exhibitor"],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.036,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      )
                    : Container(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.003),
                Text(
                  palestrante["title"],
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: const Color.fromARGB(255, 0, 0, 0),
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
