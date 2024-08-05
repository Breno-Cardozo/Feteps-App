import 'dart:math';
import 'package:feteps/Mascote_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';
import 'package:feteps/avaliar_page.dart';
import 'package:feteps/curiosidades_page.dart';
import 'package:feteps/participantes_page.dart';
import 'package:feteps/mapa_page.dart';
import 'package:feteps/patrocinadores_page.dart';
import 'package:feteps/perfil_page.dart';
import 'package:feteps/projetos_page.dart';
import 'package:feteps/palestrantes_page.dart';
import 'package:feteps/sobrenos_page.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late String fraseAvatar;

  final List<String> frases = [
    'Seja Bem vindo ao app da Feteps!!',
    'Já deu uma olhada nos projetos hj?',
    'Muito claro? Clique aqui para alterar o tema',
    'Muito escuro? Clique aqui para alterar o tema',
    'Os palestrantes de hj são Incriveis!',
    'Confira nossos apoiadores',
    'Nossa equipe fez o melhor app para vc!',
    'Não esqueça de votar nos projetos!',
    'Confira a aba "Sobre" para conhcer nossa equipe'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fraseAvatar = frases[Random().nextInt(frases.length)];
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: Builder(
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      themeProvider.toggleTheme();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.015),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0E414F),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                themeProvider.getBorderColor(),
                                            width: 3,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: SvgPicture.network(
                                            'https://api.dicebear.com/9.x/bottts/svg?seed=$nomeUsuario',
                                            height: screenHeight * 0.12,
                                            placeholderBuilder: (context) =>
                                                CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: screenHeight * 0.04,
                                right: screenWidth * 0.3,
                                child: Container(
                                  width: screenWidth * 0.3,
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    fraseAvatar,
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.03,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.home,
                    text: 'Início',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: SobrePage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    text: 'Perfil',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: PerfilPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.lightbulb,
                    text: 'Projetos',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: ProjetosPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.business,
                    text: 'Participantes',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: ParticipantesPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.mic,
                    text: 'Palestrantes',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: PalestrantesPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.android,
                    text: 'Mascote',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: MascotePage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  // _buildDrawerItem(
                  //   icon: Icons.thumb_up,
                  //   text: 'Avaliações',
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       PageTransition(
                  //         child: AvaliacaoPage(),
                  //         type: PageTransitionType.fade,
                  //       ),
                  //     );
                  //   },
                  //   context: context,
                  // ),
                  _buildDrawerItem(
                    icon: Icons.place,
                    text: 'Mapa',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: MapaPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.help,
                    text: 'Curiosidade',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: CuriosidadePage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.group,
                    text: 'Apoiadores',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: PatrocinadoresPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildDrawerItem(
                    icon: Icons.info,
                    text: 'Sobre',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: SobreNosPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    context: context,
                  ),
                ],
              ),
            ),
            Divider(
              color: themeProvider.getSpecialColor3(),
              thickness: 1.5,
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: themeProvider.getBorderColor()),
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
                                child: TelaInicialPage(),
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
    required BuildContext context,
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: Icon(icon, color: themeProvider.getSpecialColor3(), size: 35),
        title: Text(
          text,
          style: GoogleFonts.openSans(
            color: themeProvider.getSpecialColor3(),
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
