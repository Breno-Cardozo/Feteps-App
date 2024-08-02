import 'package:feteps/DetalheProject_page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:feteps/Menu_Page.dart';
import 'global.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class ProjetosPage extends StatelessWidget {
  const ProjetosPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProjetosHomePage(),
    );
  }
}

class ProjetosHomePage extends StatefulWidget {
  const ProjetosHomePage({Key? key});

  @override
  ProjetosHomeState createState() => ProjetosHomeState();
}

class ProjetosHomeState extends State<ProjetosHomePage> {
  int _selectedOds = 1;
  Map<int, List<dynamic>> _projectsCache = {};
  bool _isLoading = false;
  String _qtdeString = '';
  late List<dynamic> _filteredProjects;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredProjects = [];
    _updateSelectedOds(_selectedOds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSelectedOds(int ods) {
    if (_projectsCache.containsKey(ods)) {
      setState(() {
        _selectedOds = ods;
        _filteredProjects = List.from(_projectsCache[ods]!);
      });
    } else {
      setState(() {
        _selectedOds = ods;
        _isLoading = true;
      });
      _fetchProjects(ods);
    }
  }

  Future<void> _fetchProjects(int ods) async {
    final response = await http.get(
      Uri.parse(GlobalPageState.Url +
          '/appfeteps/pages/Project/get.php?id_ods=$ods&limit=500'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _projectsCache[ods] = json.decode(response.body)['response'];
        _filteredProjects = List.from(_projectsCache[ods]!);
        final jsonResponse = jsonDecode(response.body);
        int contentLength = jsonResponse['content_length'];
        _qtdeString = contentLength.toString();
        _isLoading = false;
      });
    } else {
      setState(() {
        _qtdeString = 'Erro ao carregar';
        _isLoading = false;
      });
      throw Exception('Falha ao carregar os projetos');
    }
  }

  void _filterProjects(String query) {
    setState(() {
      _filteredProjects = _projectsCache[_selectedOds]!.where((project) {
        String projectName = project['name_project'].toString().toLowerCase();
        return projectName.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar1_page(
          screenWidth: screenWidth, destinationPage: const SobrePage()),
      endDrawer: const MenuPage(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  'Projetos',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getSpecialColor2(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  'Selecione uma ODS:',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.06,
                    color: themeProvider.getSpecialColor3(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i < 18; i++)
                      GestureDetector(
                        onTap: () => _updateSelectedOds(i),
                        child: CardWidget(
                          ods: i,
                          isSelected: _selectedOds == i,
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  "ODS ${CardWidget.texto(_selectedOds)[0]} - ${CardWidget.texto(_selectedOds)[1]}",
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.05,
                    color: themeProvider.getSpecialColor3(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.03,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterProjects,
                  decoration: const InputDecoration(
                    hintText: 'Pesquise um projeto...',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: Color.fromARGB(255, 255, 209, 64),
                        style: BorderStyle.solid,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 255, 209, 64),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFD35F),
                      ),
                    )
                  : _projectsCache.containsKey(_selectedOds)
                      ? _filteredProjects.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < _filteredProjects.length;
                                      i++)
                                    CardWidget2(
                                      project: _filteredProjects[i],
                                      ods: _selectedOds,
                                    ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(screenWidth * 0.05),
                              child: Text(
                                'Nenhum projeto encontrado.',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.05,
                                  color: themeProvider.getSpecialColor(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                      : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int ods;
  final bool isSelected;

  CardWidget({
    required this.ods,
    required this.isSelected,
  });

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

  static List<String> texto(int ods) {
    switch (ods) {
      case 1:
        return ['1', 'Erradicação da pobreza', 'lib/assets/ods/ods1.png'];
      case 2:
        return [
          '2',
          'Fome zero e agricultura sustentável',
          'lib/assets/ods/ods2.png'
        ];
      case 3:
        return ['3', 'Saúde e bem-estar', 'lib/assets/ods/ods3.png'];
      case 4:
        return ['4', 'Educação de qualidade', 'lib/assets/ods/ods4.png'];
      case 5:
        return ['5', 'Igualdade de gênero', 'lib/assets/ods/ods5.png'];
      case 6:
        return ['6', 'Água potável e saneamento', 'lib/assets/ods/ods6.png'];
      case 7:
        return ['7', 'Energia acessível e limpa', 'lib/assets/ods/ods7.png'];
      case 8:
        return [
          '8',
          'Trabalho decente e crescimento econômico',
          'lib/assets/ods/ods8.png'
        ];
      case 9:
        return [
          '9',
          'Indústria, inovação e infraestrutura',
          'lib/assets/ods/ods9.png'
        ];
      case 10:
        return ['10', 'Redução das desigualdades', 'lib/assets/ods/ods10.png'];
      case 11:
        return [
          '11',
          'Cidades e comunidades sustentáveis',
          'lib/assets/ods/ods11.png'
        ];
      case 12:
        return [
          '12',
          'Consumo e produção responsáveis',
          'lib/assets/ods/ods12.png'
        ];
      case 13:
        return [
          '13',
          'Ação contra a mudança global do clima',
          'lib/assets/ods/ods13.png'
        ];
      case 14:
        return ['14', 'Vida na água', 'lib/assets/ods/ods14.png'];
      case 15:
        return ['15', 'Vida terrestre', 'lib/assets/ods/ods15.png'];
      case 16:
        return [
          '16',
          'Paz, justiça e instituições eficazes',
          'lib/assets/ods/ods16.png'
        ];
      case 17:
        return [
          '17',
          'Parcerias e meios de implementação',
          'lib/assets/ods/ods17.png'
        ];
      default:
        return ['?', 'Meta desconhecida', 'lib/assets/default.png'];
    }
  }

  @override
  Widget build(BuildContext context) {
    const Alignment _startAlignment = Alignment.topLeft;
    const Alignment _endAlignment = Alignment.centerLeft;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final intermediateAlignment = Alignment.lerp(
      _startAlignment,
      _endAlignment,
      0.5,
    ) as AlignmentGeometry;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: screenWidth * 0.48,
        width: screenWidth * 0.65,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          elevation: 5,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: cor(ods),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(
                        color: themeProvider.getBorderColor(), width: 2),
                  ),
                ),
              ),
              Align(
                alignment: intermediateAlignment,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.085,
                      left: screenWidth * 0.005,
                      right: screenWidth * 0.005),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        border: Border.all(
                            color: themeProvider.getBorderColor(), width: 0.3)),
                    child: Image.asset(
                      texto(ods)[2],
                      width: screenWidth * 1.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenWidth * 0.20,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.getBorderColor(), width: 2),
                  ),
                  child: SizedBox(
                    child: Container(
                      color: cor(ods),
                      width: double.infinity,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "CLIQUE PARA VER OS PROJETOS",
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.035,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget2 extends StatelessWidget {
  final Map<String, dynamic> project;
  final int ods;

  CardWidget2({required this.project, required this.ods});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String? bannerUrl = project['banner'];
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<dynamic>? exhibitors = project['exhibitors'];
    String institutionName = '';

    if (exhibitors != null && exhibitors.isNotEmpty) {
      final dynamic firstExhibitor = exhibitors.first;
      if (firstExhibitor is Map<String, dynamic>) {
        final dynamic institution = firstExhibitor['institution'];
        if (institution != null && institution is Map<String, dynamic>) {
          institutionName = institution['name_institution'] ?? '';
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheProjectPage(project: project),
            ),
          );
        },
        child: Card(
          color: CardWidget.cor(ods),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.45,
            height: screenWidth * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                if (bannerUrl != null && bannerUrl.isNotEmpty)
                  Container(
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: themeProvider.getBorderColor(),
                      width: 2.5,
                    )),
                    child: Image.network(
                      bannerUrl,
                      width: screenWidth * 0.42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(error);
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
                const SizedBox(height: 2.0),
                Text(
                  _shortenText(project['name_project'], 15),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3.0),
                Text(
                  'ID: ' + project['id'].toString(),
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                Text(_shortenText(institutionName, 35),
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center),
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
    return text.substring(0, maxLength) + '...';
  }
}
