import 'package:feteps/avaliar_page.dart';
import 'package:feteps/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:feteps/Temas/theme_provider.dart';
// Importe a página de avaliação

class VotarPage extends StatefulWidget {
  final Map<String, dynamic> project;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStar;

  const VotarPage({
    super.key,
    required this.project,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStar,
  });

  @override
  _VotarPageState createState() => _VotarPageState();
}

class _VotarPageState extends State<VotarPage> {
  int _currentRating = 0;
  String tokenLogado = '';

  @override
  void initState() {
    super.initState();
    _recuperarToken();
  }

  Future<void> _recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenLogado = prefs.getString('token') ?? '';
    });
  }

  static Color cor(int ods) {
    switch (ods) {
      case 1:
        return const Color.fromARGB(255, 179, 0, 0);
      case 2:
        return const Color.fromARGB(255, 201, 177, 0);
      case 3:
        return const Color.fromARGB(255, 60, 131, 66);
      case 4:
        return const Color.fromARGB(255, 127, 13, 13);
      case 5:
        return const Color.fromARGB(255, 201, 59, 7);
      case 6:
        return const Color.fromARGB(255, 22, 149, 199);
      case 7:
        return const Color.fromARGB(255, 255, 234, 71);
      case 8:
        return const Color.fromARGB(255, 88, 3, 27);
      case 9:
        return const Color.fromARGB(255, 225, 107, 16);
      case 10:
        return const Color.fromARGB(255, 222, 79, 48);
      case 11:
        return const Color.fromARGB(255, 241, 150, 1);
      case 12:
        return const Color.fromARGB(255, 229, 194, 1);
      case 13:
        return const Color.fromARGB(255, 51, 128, 56);
      case 14:
        return const Color.fromARGB(255, 36, 119, 198);
      case 15:
        return const Color.fromARGB(255, 94, 147, 48);
      case 16:
        return const Color.fromARGB(255, 14, 101, 184);
      case 17:
        return const Color.fromARGB(255, 22, 71, 141);
      default:
        return const Color.fromARGB(255, 0, 0, 0);
    }
  }

  Future<void> enviarVoto(int rating) async {
    final String apiUrl =
        GlobalPageState.Url + '/appfeteps/pages/Project/update.php';
    final String idProjeto = widget.project['id']?.toString() ?? 'Não tem id';

    Map<String, String> headers = {
      'Authorization': 'Bearer $tokenLogado',
      'Content-Type': 'multipart/form-data',
    };

    String starKey;
    int updatedValue;

    switch (rating) {
      case 5:
        starKey = 'five_stars';
        updatedValue = widget.fiveStars + 1;
        break;
      case 4:
        starKey = 'four_stars';
        updatedValue = widget.fourStars + 1;
        break;
      case 3:
        starKey = 'three_stars';
        updatedValue = widget.threeStars + 1;
        break;
      case 2:
        starKey = 'two_stars';
        updatedValue = widget.twoStars + 1;
        break;
      case 1:
      default:
        starKey = 'one_star';
        updatedValue = widget.oneStar + 1;
        break;
    }

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers.addAll(headers)
      ..fields['id'] = idProjeto
      ..fields[starKey] = updatedValue.toString();

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Voto enviado com sucesso');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voto enviado com sucesso')),
        );
        // Redirecionar para AvaliacaoPage após o sucesso e 3 segundos
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AvaliacaoPage()),
          );
        });
      } else {
        print('Falha ao enviar voto: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Falha ao enviar voto: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('Erro ao enviar voto: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar voto: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String logoAsset = themeProvider.getLogoAsset();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String? bannerUrl = widget.project['banner'];
    String odsId =
        widget.project['ods']['id_ods']?.toString() ?? 'ID ODS Não Disponível';
    String nameOds = widget.project['ods']['name_ods']?.toString() ??
        'Nome ODS Não Disponível';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: 400,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              'ODS $odsId: $nameOds',
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
                color: cor(widget.project["ods"]["id_ods"]),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          if (bannerUrl != null && bannerUrl.isNotEmpty)
            Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                  border: Border.all(
                color: themeProvider.getBorderColor(),
                width: 2.5,
              )),
              child: Image.network(
                bannerUrl,
                width: screenWidth * 0.42,
                height: screenHeight * 0.19,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/assets/Rectangle.png',
                    width: screenWidth * 0.42,
                  );
                },
              ),
            )
          else
            Image.asset(
              'lib/assets/Rectangle.png',
              width: screenWidth * 0.42,
            ),
          const SizedBox(height: 20),
          Text(
            widget.project['name_project'] ?? 'Nome do Projeto',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor3(),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Resumo',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: themeProvider.getSpecialColor(),
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Text(
            widget.project['project_abstract'] ?? 'Descrição do Projeto',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.042,
              color: themeProvider.getSpecialColor3(),
            ),
            textAlign: TextAlign.justify,
          ),
          Divider(
            color: themeProvider.getSpecialColor3(),
            height: 40,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Avalie o projeto:',
                style: GoogleFonts.poppins(
                  fontSize: 17.0,
                  color: themeProvider.getSpecialColor(),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: StarRating(
                  maximumRating: 5,
                  onChanged: (rating) {
                    setState(() {
                      _currentRating = rating;
                    });
                    print('Avaliação atual: $rating');
                  },
                  size: 35,
                  color: themeProvider.getSpecialColor(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_currentRating > 0) {
                    enviarVoto(_currentRating);
                  } else {
                    print('Selecione uma avaliação');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Enviar',
                    style: GoogleFonts.oswald(
                      color: themeProvider.getSpecialColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onChanged;
  final double size;
  final Color color;

  const StarRating({
    Key? key,
    required this.maximumRating,
    required this.onChanged,
    this.size = 35,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maximumRating, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _currentRating = index + 1;
            });
            widget.onChanged(_currentRating);
          },
          icon: Icon(
            index < _currentRating
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            size: widget.size,
            color: index < _currentRating ? widget.color : null,
          ),
        );
      }),
    );
  }
}
