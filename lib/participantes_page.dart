import 'package:feteps/DetalheProject_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/appbar/appbar1_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'global.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class ParticipantesPage extends StatefulWidget {
  const ParticipantesPage({super.key});

  @override
  State<ParticipantesPage> createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage> {
  final Map<String, List<dynamic>> _projectsCache = {
    "ETEC": [],
    "FATEC": [],
    "OUTROS": []
  };
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _fetchProjects();
    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text;
      });
    });
  }

  Future<void> _fetchProjects() async {
    await Future.wait([
      _fetchProjectsByClassification("ETEC"),
      _fetchProjectsByClassification("FATEC"),
      _fetchProjectsByClassification("OUTROS")
    ]);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchProjectsByClassification(String classification) async {
    final response = await http.get(Uri.parse(GlobalPageState.Url +
        '/appfeteps/pages/Project/get.php?classification=$classification&limit=50'));

    if (response.statusCode == 200) {
      setState(() {
        _projectsCache[classification] = json.decode(response.body)['response'];
      });
    } else {
      throw Exception('Falha ao carregar os projetos');
    }
  }

  List<dynamic> _filterProjects(List<dynamic> projects) {
    if (_searchTerm.isEmpty) {
      return projects;
    }
    return projects.where((project) {
      final projectName = (project['name_project'] ?? '').toLowerCase();
      final List<dynamic>? exhibitors = project['exhibitors'];
      String institutionName = '';

      if (exhibitors != null && exhibitors.isNotEmpty) {
        final dynamic firstExhibitor = exhibitors.first;
        if (firstExhibitor is Map<String, dynamic>) {
          final dynamic institution = firstExhibitor['institution'];
          if (institution != null && institution is Map<String, dynamic>) {
            institutionName =
                (institution['name_institution'] ?? '').toLowerCase();
          }
        }
      }

      return projectName.contains(_searchTerm.toLowerCase()) ||
          institutionName.contains(_searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar1_page(
          screenWidth: screenWidth, destinationPage: const SobrePage()),
      endDrawer: const MenuPage(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFD35F)))
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            child: Text('Participantes',
                                style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.08,
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.getSpecialColor2())),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: screenHeight * 0.03,
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.06),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Pesquise um projeto ou instituição...',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3.0,
                              color: Color.fromARGB(255, 255, 209, 64),
                              style: BorderStyle.solid,
                            ),
                          ),
                          prefixIcon: Icon(Icons.search,
                              color: Color.fromARGB(255, 255, 209, 64)),
                        ),
                      ),
                    ),
                    _buildProjectSection('Etecs', 'ETEC'),
                    const SizedBox(height: 10.0),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                    _buildProjectSection('Fatecs', 'FATEC'),
                    const SizedBox(height: 10.0),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                    _buildProjectSection('Outras Instituições', 'OUTROS'),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildProjectSection(String title, String classification) {
    final screenWidth = MediaQuery.of(context).size.width;
    final filteredProjects = _filterProjects(_projectsCache[classification]!);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Text(
            title,
            style: GoogleFonts.inter(
                fontSize: screenWidth * 0.065,
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        filteredProjects.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var project in filteredProjects)
                      CardWidget2(
                        project: project,
                        classification: classification,
                      )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(screenWidth * 0.1),
                child: Text(
                  'Nenhum projeto encontrado.',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05,
                      color: themeProvider.getSpecialColor()),
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }
}

class CardWidget2 extends StatelessWidget {
  final Map<String, dynamic> project;
  final String classification;

  const CardWidget2(
      {super.key, required this.project, required this.classification});

  Color Cor(String classification) {
    switch (classification) {
      case 'ETEC':
        return const Color(0xFF830000);
      case 'FATEC':
        return const Color(0xFF1A5B97);
      case 'OUTROS':
        return const Color(0xFFDDA73A);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
      padding: EdgeInsets.all(screenWidth * 0.015),
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
          color: Cor(classification),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.5,
            height: screenWidth * 0.65,
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
                      ),
                    ),
                    child: Image.network(
                      bannerUrl,
                      width: screenWidth * 0.42,
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
                const SizedBox(height: 5.0),
                Text(
                  _shortenText(project['name_project'], 25),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.042,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3.0),
                Text(_shortenText(institutionName, 45),
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
    return '${text.substring(0, maxLength)}...';
  }
}
