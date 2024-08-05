import 'package:feteps/perfil_page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class AppBar2_page extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final Widget destinationPage;

  const AppBar2_page(
      {super.key, required this.screenWidth, required this.destinationPage});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    return AppBar(
      elevation: 0,
      title: SizedBox(
        width: 400,
        height: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: destinationPage,
                    type: PageTransitionType.leftToRight,
                  ),
                );
                return false;
              },
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: destinationPage,
                        type: PageTransitionType.leftToRight),
                  );
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
