import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class AppBar1_page extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final Widget destinationPage;

  AppBar1_page({required this.screenWidth, required this.destinationPage});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: destinationPage,
                  type: PageTransitionType.bottomToTop,
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
                    type: PageTransitionType.topToBottom,
                  ),
                );
              },
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Icon(
                  size: screenWidth * 0.075,
                  Icons.arrow_back_sharp,
                  color: themeProvider.getSpecialColor2(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, bottom: 15),
            child: Image.asset(
              logoAsset,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          )
        ],
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              size: screenWidth * 0.095,
              color: themeProvider.getSpecialColor2(),
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
