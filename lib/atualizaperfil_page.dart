import 'dart:io';

import 'package:feteps/appbar/appbar2_page.dart';
import 'package:feteps/global.dart';
import 'package:feteps/perfil_page.dart';
import 'package:feteps/loginfeteps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';
import 'Apis/cidades.dart';
import 'Apis/estados.dart';

class AtualizarDadosPage extends StatefulWidget {
  const AtualizarDadosPage({super.key});

  @override
  _AtualizarDadosPageState createState() => _AtualizarDadosPageState();
}

class _AtualizarDadosPageState extends State<AtualizarDadosPage> {
  final _userNameController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _institutionCodeController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  String idUsuario = '';
  String tokenLogado = '';
  List<Estado> _estados = [];
  List<Cidade> _cidadesDoEstado = [];
  String? _selectedEstado;
  String _nomeEstado = '';

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  _loadEstados() async {
    try {
      List<Estado> estados = await Estado.getEstados();
      setState(() {
        _estados = estados;
      });
    } catch (e) {
      print('Erro ao carregar estados: $e');
    }
  }

  _loadCidades(String estadoId) async {
    try {
      List<Cidade> cidades = await Cidade.getCidades(estadoId);
      setState(() {
        _cidadesDoEstado = cidades;
      });
      // Buscar o nome do estado com base no ID
      Estado? estado = _estados.firstWhere((e) => e.id == estadoId,
          orElse: () => Estado(id: '', nome: ''));
      setState(() {
        _nomeEstado = estado.nome;
      });
    } catch (e) {
      print('Erro ao carregar cidades: $e');
    }
  }

  Future<bool> _atualizarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUsuario = prefs.getString('idUsuario') ?? '';
      tokenLogado = prefs.getString('token') ?? '';
    });

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          (cert, host, port) => true); // ignore certificate verification

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(GlobalPageState.Url + '/appfeteps/pages/Users/updateUser.php'),
    );

    request.headers['Authorization'] = 'Bearer $tokenLogado';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['userId'] = idUsuario;
    request.fields['userName'] = _userNameController.text;
    request.fields['state'] = _nomeEstado;
    request.fields['city'] = _cidadeController.text;
    request.fields['idInstitution'] = _institutionCodeController.text;

    try {
      final response = await client.send(request);

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        if (responseData['type'] == 'success' &&
            responseData['message'] == 'Operation completed successfully!') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Dados atualizados com sucesso',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFFFFD35F),
              duration: const Duration(seconds: 3)));
          Future.delayed(const Duration(seconds: 2), () {
            _deucerto();
          });
          return true;
        } else {
          setState(() {
            _errorMessage = responseData['message'];
          });
          return false;
        }
      } else {
        setState(() {
          _errorMessage = 'Falha ao atualizar os dados';
        });
        return false;
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao atualizar os dados: $e';
      });
      return false;
    }
  }

  Future<void> _deucerto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
          child: const LoginFetepsPage(), type: PageTransitionType.topToBottom),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String UserAsset = themeProvider.getUserAsset();

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
                      "Atualizar dados",
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
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      UserAsset,
                      width: screenWidth * 0.45,
                    ),
                  ],
                ),
              ),
              buildTextField(
                context,
                labelText: 'Nome de usuário:',
                controller: _userNameController,
              ),
              buildTextField(
                context,
                labelText: 'Cod Instituição:',
                controller: _institutionCodeController,
              ),
              _buildDropdownEstado(screenWidth, screenHeight),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _buildDropdownCidade(screenWidth, screenHeight),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _errorMessage.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.04, bottom: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: const Color(0xFFB6382B),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.012,
                          right: MediaQuery.of(context).size.width * 0.012,
                        ),
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  bool dadosAtualizados =
                                      await _atualizarDados();
                                  if (dadosAtualizados) {
                                    _deucerto();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 39),
                            backgroundColor: themeProvider.getSpecialColor4(),
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                          child: Text(
                            _isLoading ? 'Atualizando...' : 'Atualizar',
                            style: GoogleFonts.oswald(
                              color: themeProvider.getSpecialColor3(),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.8,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: GoogleFonts.poppins(
                  color: themeProvider.getSpecialColor3(),
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: themeProvider.getSpecialColor3()),
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

  Widget _buildDropdownEstado(double screenWidth, double screenHeight) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.grey,
            decoration: InputDecoration(
              labelText: 'Estado:',
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: themeProvider.getSpecialColor3(),
            ),
            value: _selectedEstado,
            onChanged: (String? newValue) {
              setState(() {
                _selectedEstado = newValue;
                _estadoController.text = newValue!;
                _loadCidades(newValue);
              });
            },
            items: _estados.map((estado) {
              return DropdownMenuItem<String>(
                value: estado.id,
                child: Text(
                  estado.nome,
                  style: TextStyle(color: themeProvider.getSpecialColor3()),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione um estado.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCidade(double screenWidth, double screenHeight) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.grey,
            decoration: InputDecoration(
              labelText: 'Cidade:',
              labelStyle: GoogleFonts.roboto(
                color: themeProvider.getSpecialColor3(),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.getBorderColor()),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: themeProvider.getSpecialColor3(),
            ),
            value: _cidadeController.text.isNotEmpty
                ? _cidadeController.text
                : null,
            onChanged: (String? newValue) {
              setState(() {
                _cidadeController.text = newValue!;
              });
            },
            items: _cidadesDoEstado.map((cidade) {
              return DropdownMenuItem<String>(
                value: cidade.nome,
                child: Text(
                  cidade.nome,
                  style: TextStyle(color: themeProvider.getSpecialColor3()),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma cidade.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
