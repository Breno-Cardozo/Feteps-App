import 'package:feteps/global.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:async';
import 'sobre_page.dart';
import 'loginfeteps_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await verificarToken();

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: const SobrePage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 2000)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: const TelaInicialPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 2000)),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFBF5F),
              const Color(0xFFFFAA5F),
              const Color(0xFFA66736),
              const Color(0xFF85491A),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                  scale: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF0E414F),
                          width: 3.5,
                        )),
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/fundo.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> verificarToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');

  print('token: $token'); //capturando o token corretamente

  if (token != null) {
    final url = Uri.parse(
        GlobalPageState.Url + '/appfeteps/pages/Auth/verifyToken.php');

    final jsonData = {'token': token};

    final jsonString = jsonEncode(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Response Data: $data');

        if (data['type'] == 'success' && data['message'] == 'Token válido!') {
          return true;
        }
      } else {
        print('Falha ao verificar token: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao verificar token: $e');
    }
  }
  return false;
}
