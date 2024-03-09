import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
        title: const Text("Acerca de nosotros"),
      ),
      body: const SingleChildScrollView(
        child: Column(children: [
          ImageSection(image: "img/logo3.png"),
          TextTitleSection(title: "Trivia v1.0.0"),
          TextSection(description: "Trivia es un servicio desarrollado por Leti Comunity, una comunidad de desarrollo de aplicaciones ""webs, moviles y de escritorio localizada en Guinea Ecuatorial.")
        ],)
      ),
    );
  }
}

//image widget
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        ),
    );
  }
}

//text widget
class TextTitleSection extends StatelessWidget {
  const TextTitleSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        title,
        softWrap: true,
        textWidthBasis: TextWidthBasis.longestLine,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
        ),
        textAlign: TextAlign.left,
        
      ),
    );
  }
}

//text widget
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32,top: 0, right: 32, bottom: 8),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}