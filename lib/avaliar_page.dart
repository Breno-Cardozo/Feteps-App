import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'Temas/theme_provider.dart';
import 'Menu_Page.dart';
import 'Votar_page.dart';
import 'appbar/appbar1_page.dart';
import 'sobre_page.dart';

class AvaliacaoPage extends StatefulWidget {
  const AvaliacaoPage({super.key});

  @override
  _AvaliacaoPageState createState() => _AvaliacaoPageState();
}

class _AvaliacaoPageState extends State<AvaliacaoPage> {
  final TextEditingController _idController = TextEditingController();

  Future<void> _fetchProjectAndNavigate() async {
    final String id = _idController.text;
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite um ID')),
      );
      return;
    }

    final String url =
        GlobalPageState.Url + '/appfeteps/pages/Project/getById.php?id=$id';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> projectData = jsonDecode(response.body);

        // Extrair os valores das chaves
        final int fiveStars = projectData['five_stars'] ?? 0;
        final int fourStars = projectData['four_stars'] ?? 0;
        final int threeStars = projectData['three_stars'] ?? 0;
        final int twoStars = projectData['two_stars'] ?? 0;
        final int oneStar = projectData['one_star'] ?? 0;

        // Navegar para a próxima tela passando os valores
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VotarPage(
              project: projectData,
              fiveStars: fiveStars,
              fourStars: fourStars,
              threeStars: threeStars,
              twoStars: twoStars,
              oneStar: oneStar,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Projeto não encontrado')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar o projeto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar1_page(
        screenWidth: MediaQuery.of(context).size.width * 1.0,
        destinationPage: SobrePage(),
      ),
      endDrawer: const MenuPage(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Digite o ID do \nprojeto para avaliar:',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: themeProvider.getSpecialColor(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) => _fetchProjectAndNavigate(),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
