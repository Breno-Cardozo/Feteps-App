import 'dart:ui';

import 'package:feteps/appbar/appbar2_page.dart';
import 'package:feteps/atualizaperfil_page.dart';
import 'package:feteps/global.dart';
import 'package:feteps/perfil_page.dart';
import 'package:feteps/loginfeteps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class MeusDadosPage extends StatefulWidget {
  const MeusDadosPage({super.key});

  @override
  _MeusDadosPagePageState createState() => _MeusDadosPagePageState();
}

class _MeusDadosPagePageState extends State<MeusDadosPage> {
  Map<String, dynamic>? userData;
  final _userNameController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _institutionCodeController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataController = TextEditingController();
  String idUsuario = '';
  String nomeUsuario = '';
  String email = '';
  String estado = '';
  String cidade = '';
  String registro = '';
  String institutionid = '';
  String tokenLogado = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUsuario = prefs.getString('idUsuario') ?? '';
      nomeUsuario = prefs.getString('nomeUsuario') ?? 'No Username';
      tokenLogado = prefs.getString('token') ?? '';
      email = prefs.getString('email') ?? '';
      estado = prefs.getString('state') ?? '';
      cidade = prefs.getString('city') ?? '';

      // Set the values to the controllers
      _idController.text = idUsuario;
      _userNameController.text = nomeUsuario;
      _emailController.text = email;
      _stateController.text = estado;
      _cityController.text = cidade;
    });

    if (idUsuario.isNotEmpty) {
      await fetchUserData(int.tryParse(idUsuario) ?? 0);
    }
  }

  Future<void> fetchUserData(int id) async {
    setState(() {
      isLoading = true;
    });

    String url =
        GlobalPageState.Url + '/appfeteps/pages/Users/getUserById.php?id=$id';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $tokenLogado',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data;
          institutionid = data['institution']?['id'].toString() ??
              'Sua instituição não possui um codigo';
          registro = data['registerDate']?.toString() ?? 'Data não encontrada';

          _institutionCodeController.text = institutionid;
          _dataController.text = registro;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar2_page(
          screenWidth: screenWidth, destinationPage: const PerfilPage()),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.07,
                  bottom: screenHeight * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Meus Dados",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.069,
                        color: themeProvider.getSpecialColor2(),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              buildTextField(
                context,
                labelText: 'Email do Usuário:',
                controller: _emailController,
              ),
              buildTextField(
                context,
                labelText: 'Nome do usuário:',
                controller: _userNameController,
              ),
              buildTextField(
                context,
                labelText: 'Estado:',
                controller: _stateController,
              ),
              buildTextField(
                context,
                labelText: 'Cidade:',
                controller: _cityController,
              ),
              buildTextField(
                context,
                labelText: 'Data de registro:',
                controller: _dataController,
              ),
              buildTextField(
                context,
                labelText: 'Cod Instituição(Etecs/Fatecs):',
                controller: _institutionCodeController,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const AtualizarDadosPage(),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    },
                    child: Text(
                      "Atualizar Meus Dados",
                      style: GoogleFonts.oswald(
                        color: themeProvider.getSpecialColor(),
                        decoration: TextDecoration.underline,
                        decorationColor: themeProvider.getSpecialColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildTextField(BuildContext context,
      {required String labelText, required TextEditingController controller}) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.8,
            child: TextFormField(
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: GoogleFonts.poppins(
                  color: themeProvider.getSpecialColor3(),
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: themeProvider.getBorderColor()),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFFD4A03D),
                      width: screenWidth * 0.005),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
