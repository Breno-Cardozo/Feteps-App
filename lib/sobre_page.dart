import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Mascote_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/patrocinadores_page.dart';
import 'package:feteps/projetos_page.dart';
import 'package:feteps/Temas/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores e animações para cada imagem
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    // Dispose de todos os controladores
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onImageTap(int index) async {
    await Future.delayed(const Duration(milliseconds: 0));
    switch (index) {
      case 0:
        _launchURL('http://feteps.cpscetec.com.br/feteps.php');
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageTransition(
              child: const ProjetosHomePage(),
              type: PageTransitionType.size,
              alignment: Alignment.center),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageTransition(
              child: const PatrocinadoresPage(),
              type: PageTransitionType.size,
              alignment: Alignment.center),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          PageTransition(
              child: MascotePage(),
              type: PageTransitionType.size,
              alignment: Alignment.center),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: 400,
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 30, bottom: 15),
                  child: Image.asset(
                    logoAsset,
                    width: MediaQuery.of(context).size.width * 0.65,
                  ),
                )
              ],
            ),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: MediaQuery.of(context).size.width * 0.095,
                    color: themeProvider.getSpecialColor2(),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        endDrawer: MenuPage(),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                _buildImageWithBorder(
                    context, 'lib/assets/banners/banner2.png', screenWidth, 0),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                _buildImageWithBorder(
                    context, 'lib/assets/banners/banner1.png', screenWidth, 1),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                _buildImageWithBorder(
                    context, 'lib/assets/banners/banner3.png', screenWidth, 2),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                _buildImageWithBorder(
                    context, 'lib/assets/banners/banner4.png', screenWidth, 3),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithBorder(
      BuildContext context, String imagePath, double screenWidth, int index) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () async {
        // Animação de clique
        await _controllers[index].forward();
        await _controllers[index].reverse();
        _onImageTap(index);
      },
      child: ScaleTransition(
        scale: _animations[index],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: themeProvider.getSpecialColor3(),
              width: 3.0,
            ),
          ),
          child: Image.asset(
            imagePath,
            width: screenWidth * 0.88,
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  if (url.isEmpty) {
    print('URL is empty');
    return;
  }

  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    print('Could not launch $url');
  }
}
