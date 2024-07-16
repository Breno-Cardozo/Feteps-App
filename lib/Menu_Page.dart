import 'package:feteps/avaliar_page.dart';
import 'package:feteps/NossaEquipe_page.dart';
import 'package:feteps/curiosidades_page.dart';
import 'package:feteps/participantes_page.dart';
import 'package:feteps/mapa_page.dart';
import 'package:feteps/patrocinadores_page.dart';
import 'package:feteps/perfil_page.dart';
import 'package:feteps/projetos_page.dart';
import 'package:feteps/palestrantes_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:feteps/sobrenos_page.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, dynamic>? userData;
  bool isLoading = false;

  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario') ?? 'No Username';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                            color: Colors.white,
                          ))),
                      child: Builder(builder: (BuildContext context) {
                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E414F),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                ),
                                child: ClipOval(
                                  child: SvgPicture.network(
                                    'https://api.dicebear.com/9.x/bottts/svg?seed=$nomeUsuario',
                                    height: screenWidth * 0.3,
                                    width: screenWidth * 0.3,
                                    placeholderBuilder: (context) =>
                                        CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.home,
                    text: 'Início',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const SobrePage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    text: 'Perfil',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const PerfilPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.lightbulb,
                    text: 'Projetos',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const ProjetosPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.business,
                    text: 'Participantes',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const ParticipantesPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.mic,
                    text: 'Palestrantes',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const PalestrantesPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.thumb_up,
                    text: 'Avaliações',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const AvaliacaoPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.place,
                    text: 'Mapa',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const MapaPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.help,
                    text: 'Curiosidade',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const CuriosidadePage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.group,
                    text: 'Apoiadores',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const PatrocinadoresPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.info,
                    text: 'Sobre',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const SobreNosPage(),
                            type: PageTransitionType.fade),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.012,
                        right: MediaQuery.of(context).size.width * 0.012),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool saiu = await sair();
                        if (saiu) {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const TelaInicialPage(),
                                type: PageTransitionType.topToBottom),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 39),
                        backgroundColor: const Color(0xFF0E414F),
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: Colors.transparent, width: 0),
                        ),
                      ),
                      child: Text(
                        "Sair",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
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
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black, size: 35),
        title: Text(
          text,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
