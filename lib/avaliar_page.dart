// import 'package:feteps/global.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:feteps/Temas/theme_provider.dart';
// import 'package:feteps/appbar/appbar1_page.dart';
// import 'package:feteps/Menu_Page.dart';
// import 'package:feteps/sobre_page.dart';

// class MascotePage extends StatefulWidget {
//   const MascotePage({super.key});

//   @override
//   State<MascotePage> createState() => _MascotePageState();
// }

// class _MascotePageState extends State<MascotePage> {
//   int _selectedCardIndex = -1;
//   String tokenLogado = '';
//   int _currentFiveStars = 0;

//   @override
//   void initState() {
//     super.initState();
//     _recuperarToken();
//   }

//   Future<void> _recuperarToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       tokenLogado = prefs.getString('token') ?? '';
//     });
//   }

//   Future<void> _getCurrentVotes(int idProjeto) async {
//     final String url = GlobalPageState.Url +
//         '/appfeteps/pages/Project/getById.php?id=$idProjeto';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> projectData = jsonDecode(response.body);
//         setState(() {
//           _currentFiveStars = projectData['five_stars'] ?? 0;
//         });
//       } else {
//         print('Erro ao buscar votos: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Erro ao buscar votos: $e');
//     }
//   }

//   Future<void> enviarVoto() async {
//     final String apiUrl =
//         GlobalPageState.Url + '/appfeteps/pages/Project/update.php';
//     String idProjeto;

//     if (_selectedCardIndex == 0) {
//       idProjeto = '3000';
//     } else if (_selectedCardIndex == 1) {
//       idProjeto = '3001';
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Por favor, selecione um mascote')),
//       );
//       return;
//     }

//     Map<String, String> headers = {
//       'Authorization': 'Bearer $tokenLogado',
//       'Content-Type': 'multipart/form-data',
//     };

//     var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
//       ..headers.addAll(headers)
//       ..fields['id'] = idProjeto
//       ..fields['five_stars'] = (_currentFiveStars + 1).toString();

//     try {
//       final response = await request.send();

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voto realizado com sucesso')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Erro ao realizar voto: ${response.reasonPhrase}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erro ao realizar voto: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar:
//           AppBar1_page(screenWidth: screenWidth, destinationPage: SobrePage()),
//       endDrawer: MenuPage(),
//       body: ListView(
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(
//                               color: themeProvider.getSpecialColor(), width: 2),
//                           bottom: BorderSide(
//                               color: themeProvider.getSpecialColor(), width: 2),
//                         ),
//                       ),
//                       child: Image.asset(
//                         'lib/assets/banner4.png',
//                         width: MediaQuery.of(context).size.width * 1.0,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Vote no seu mascote favorito!',
//                     style: GoogleFonts.poppins(
//                       color: themeProvider.getSpecialColor(),
//                       fontWeight: FontWeight.bold,
//                       fontSize: screenWidth * 0.05,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedCardIndex = 0;
//                             });
//                             _getCurrentVotes(3000);
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(8.0),
//                             padding: EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF1A5B97),
//                               borderRadius: BorderRadius.circular(10.0),
//                               border: Border.all(
//                                 color: _selectedCardIndex == 0
//                                     ? Color.fromARGB(255, 247, 186, 65)
//                                     : Colors.transparent,
//                                 width: 4,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 3), // Sombra para baixo
//                                 ),
//                               ],
//                             ),
//                             width: screenWidth * 0.4,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     'lib/assets/Fet.png',
//                                     height: screenHeight * 0.18,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Fet',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: screenWidth * 0.045,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // Ação ao clicar no botão "História"
//                           },
//                           child: Text(
//                             'História',
//                             style: GoogleFonts.poppins(
//                               color: themeProvider.getSpecialColor3(),
//                               fontWeight: FontWeight.bold,
//                               fontSize: screenWidth * 0.045,
//                               decoration: TextDecoration.underline,
//                               decorationColor: themeProvider.getBorderColor(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedCardIndex = 1;
//                             });
//                             _getCurrentVotes(3001);
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(8.0),
//                             padding: EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF830000),
//                               borderRadius: BorderRadius.circular(10.0),
//                               border: Border.all(
//                                 color: _selectedCardIndex == 1
//                                     ? Color.fromARGB(255, 247, 186, 65)
//                                     : Colors.transparent,
//                                 width: 4,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 3), // Sombra para baixo
//                                 ),
//                               ],
//                             ),
//                             width: screenWidth * 0.4,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     'lib/assets/Teps.png',
//                                     height: screenHeight * 0.18,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Teps',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: screenWidth * 0.045,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // Ação ao clicar no botão "História"
//                           },
//                           child: Text(
//                             'História',
//                             style: GoogleFonts.poppins(
//                               color: themeProvider.getSpecialColor3(),
//                               fontWeight: FontWeight.bold,
//                               fontSize: screenWidth * 0.045,
//                               decoration: TextDecoration.underline,
//                               decorationColor: themeProvider.getBorderColor(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: enviarVoto,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: themeProvider.getSpecialColor2(),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Text(
//                         'Enviar',
//                         style: GoogleFonts.oswald(
//                           color: themeProvider.getSpecialColor21(),
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
