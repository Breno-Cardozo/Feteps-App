import 'dart:convert';
import 'package:feteps/cadastroInstitu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'cadastro2_page.dart';
import 'telainicial_page.dart';
import 'global.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';

class Cadastro1Page extends StatefulWidget {
  const Cadastro1Page({Key? key}) : super(key: key);

  @override
  _Cadastro1PageState createState() => _Cadastro1PageState();
}

class _Cadastro1PageState extends State<Cadastro1Page> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> items = [];
  String? selectedItem;

  List<Map<String, dynamic>> itemsInstituicao = [];
  String? selectedItemInstituicao;
  String? selectedUserType;
  String? selectedMainOption;
  String? selectedSubOption;
  List<String> userTypes = [];

  Map<String, List<Map<String, dynamic>>> options = {
    'Etec': [],
    'Fatec': [],
    'Outros': [],
  };

  bool isLoading = false;
  String searchQuery = '';
  List<Map<String, dynamic>> filteredOptions = [];

  final Map<String, String> apiUrls = {
    'Etec': GlobalPageState.Url +
        '/appfeteps/pages/Institution/get.php?type=ETEC&limit=300',
    'Fatec': GlobalPageState.Url +
        '/appfeteps/pages/Institution/get.php?type=FATEC&limit=300',
    'Outros': GlobalPageState.Url +
        '/appfeteps/pages/Institution/get.php?type=OUTROS&limit=300',
  };

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response = await http.get(
        Uri.parse(GlobalPageState.Url + '/appfeteps/pages/TypesUser/get.php'));

    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);

      if (decodedData is List<dynamic>) {
        setState(() {
          items = decodedData.cast<Map<String, dynamic>>();
        });
      } else if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('response')) {
        setState(() {
          items = List<Map<String, dynamic>>.from(decodedData['response']);
        });
      } else {
        throw Exception(
            'A resposta da API não é uma lista ou um mapa com a chave "response"');
      }
    } else {
      throw Exception('Falha ao carregar itens da API');
    }
  }

  Future<void> fetchOptions(String type) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrls[type]!));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map && data['response'] is List) {
          List<Map<String, dynamic>> institutions =
              (data['response'] as List<dynamic>)
                  .map((e) => {'id': e['id'], 'name': e['name_institution']})
                  .toList();

          institutions.sort((a, b) {
            String cleanA = a['name']
                .toUpperCase()
                .replaceFirst(RegExp(r'^PROFESSOR(A)? '), '');
            String cleanB = b['name']
                .toUpperCase()
                .replaceFirst(RegExp(r'^PROFESSOR(A)? '), '');
            return cleanA.compareTo(cleanB);
          });

          setState(() {
            options[type] = institutions;
            filteredOptions = institutions;
          });
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load institutions');
      }
    } catch (e) {
      print('Error fetching options: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterOptions(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredOptions = options[selectedMainOption!] ?? [];
      } else {
        filteredOptions = options[selectedMainOption!]
                ?.where((option) =>
                    option['name'].toLowerCase().contains(query.toLowerCase()))
                .toList() ??
            [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: screenWidth * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const TelaInicialPage(),
                        type: PageTransitionType.leftToRightWithFade,
                      ),
                    );
                  },
                  icon: Icon(
                    size: MediaQuery.of(context).size.width * 0.075,
                    Icons.arrow_back_sharp,
                    color: themeProvider.getSpecialColor3(),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: Image.asset(
                  logoAsset,
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFB6382B),
                          width: 3.5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/fundo.png',
                          width: screenWidth * 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CADASTRO",
                    style: TextStyle(
                      fontSize: screenWidth * 0.069,
                      color: themeProvider.getSpecialColor3(),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: screenWidth * 0.85,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: items.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: CircularProgressIndicator(
                                        color: Color(0xFFFFD35F)),
                                  )
                                : DropdownButtonFormField(
                                    dropdownColor: Colors.grey,
                                    icon: Icon(
                                      Icons.person,
                                      size: screenWidth * 0.072,
                                      color: themeProvider.getSpecialColor2(),
                                    ),
                                    value: selectedItem,
                                    items: items
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'].toString(),
                                        child: Text(
                                          item['description'],
                                          style: TextStyle(
                                              color: themeProvider
                                                  .getSpecialColor3()),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedItem = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Selecione um tipo de usuário',
                                      labelStyle: TextStyle(
                                        color: themeProvider.getSpecialColor2(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                themeProvider.getBorderColor()),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, selecione um tipo de usuário';
                                      }
                                      return null;
                                    },
                                  ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey,
                            icon: Icon(
                              Icons.business,
                              size: screenWidth * 0.072,
                              color: themeProvider.getSpecialColor2(),
                            ),
                            value: selectedMainOption,
                            items: options.keys.map<DropdownMenuItem<String>>(
                              (option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                        color:
                                            themeProvider.getSpecialColor3()),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMainOption = value;
                                selectedSubOption = null;
                                filterOptions('');
                              });
                              if (value != null) {
                                fetchOptions(value);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Selecione um tipo de instituição',
                              labelStyle: TextStyle(
                                color: themeProvider.getSpecialColor2(),
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeProvider.getBorderColor()),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, selecione um tipo de instituição';
                              }
                              return null;
                            },
                            isExpanded: true,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          if (selectedMainOption != null)
                            isLoading
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFFFD35F),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.035,
                                          ),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Pesquisar instituição',
                                              labelStyle: TextStyle(
                                                color: themeProvider
                                                    .getSpecialColor2(),
                                                fontSize: screenWidth * 0.0425,
                                              ),
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0E414F)),
                                              ),
                                              suffixIcon: Icon(Icons.search,
                                                  color: themeProvider
                                                      .getSpecialColor2()),
                                            ),
                                            onChanged: filterOptions,
                                          )),
                                      SizedBox(
                                        height: screenHeight * 0.13,
                                        child: DropdownButtonFormField<String>(
                                          dropdownColor: Colors.grey,
                                          icon: Icon(
                                            Icons.house,
                                            size: screenWidth * 0.072,
                                            color: themeProvider
                                                .getSpecialColor2(),
                                          ),
                                          value: selectedSubOption,
                                          items: filteredOptions
                                              .map<DropdownMenuItem<String>>(
                                            (subOption) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    subOption['id'].toString(),
                                                child: Text(
                                                  subOption['name'],
                                                  style: TextStyle(
                                                      color: themeProvider
                                                          .getSpecialColor3()),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSubOption = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText:
                                                'Selecione sua instituição',
                                            labelStyle: TextStyle(
                                              color: themeProvider
                                                  .getSpecialColor2(),
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth * 0.045,
                                            ),
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeProvider
                                                      .getBorderColor()),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Por favor, selecione uma instituição';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: const Color(0xFFB6382B),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.012,
                                      right: MediaQuery.of(context).size.width *
                                          0.012),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final selectedUserTypeName =
                                            items.firstWhere((item) =>
                                                item['id'].toString() ==
                                                selectedItem)['description'];
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Cadastro2Page(
                                              selectedItem: selectedItem,
                                              selectedItemInstituicao:
                                                  selectedSubOption,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 39),
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    child: Text(
                                      "Continuar",
                                      style: GoogleFonts.oswald(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: CadastroInstituicaoPage(),
                                      type: PageTransitionType.bottomToTop,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sua instituição não está na lista?',
                                  style: GoogleFonts.oswald(
                                    color: const Color(0xFFB6382B),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.044,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
