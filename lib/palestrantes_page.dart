import 'dart:convert';
import 'dart:io';

import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:feteps/tela_palestrante.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/io_client.dart';
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
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    try {
      final response = await client.get(
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

    // Ordena as listas de palestrantes por horário (HH:MM)
    for (var entry in _palestrantesPorData.entries) {
      entry.value.sort((a, b) {
        String timeA = a['date_time'].substring(11, 16); // Pega o horário de A
        String timeB = b['date_time'].substring(11, 16); // Pega o horário de B
        return timeA.compareTo(timeB); // Compara os horários
      });
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

    // Obtenha as chaves (datas) e ordene-as cronologicamente
    final sortedDates = _palestrantesPorData.keys.toList()
      ..sort((a, b) => _parseDate(a).compareTo(_parseDate(b)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedDates.map((data) {
        String displayDate = displayDates[data]!;
        List<dynamic> palestrantes = _palestrantesPorData[data]!;

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

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(2024, int.parse(parts[0]), int.parse(parts[1]));
  }
}

class CardWidget extends StatefulWidget {
  final Map<String, dynamic> palestrante;
  final Map<String, List<dynamic>> total;
  final List<dynamic> lista;

  const CardWidget({
    required this.palestrante,
    required this.lista,
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<ImageProvider> _loadImage(String url) async {
    final httpClient = IOClient(
        HttpClient()..badCertificateCallback = (cert, host, port) => true);

    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      print('Erro ao carregar imagem: ${response.statusCode}');
      return const AssetImage('lib/assets/Rectangle.png');
    }
  }

  String _shortenText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final exhibitor = (widget.palestrante["exhibitors"] as List).isNotEmpty
        ? widget.palestrante["exhibitors"][0]
        : null;

    return GestureDetector(
        onTap: () async {
          await _controller.forward();
          await _controller.reverse();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => tela_palestrante(
                lista: widget.lista,
                palestrante: widget.palestrante,
                totalP: widget.total,
              ),
            ),
          );
        },
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            child: Card(
              color: const Color(0xFFFFD35F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.295,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005),
                    exhibitor != null
                        ? Row(
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
                                  _shortenText(exhibitor["name_exhibitor"], 38),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    color: themeProvider.getSpecialColor3(),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            _shortenText(widget.palestrante["title"], 38),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
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
                            _getHorario(widget.palestrante[
                                "date_time"]), // Exibe apenas o horário
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
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
        ));
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
