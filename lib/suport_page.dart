import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:trivia/custom_icon_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPage();
}

//TODO get input text and sendto email
//TODO change button to send size
class _SupportPage extends State<SupportPage> {
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
        title: const Text("Soporte"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const TextTitleSection(
                title: "¿Cómo crees que podemos mejorar Trivia?"),
            const TextSection(
                description:
                    "El servicio está destinado a todos los usuarios sin restricciones, y por eso nos gustaría saber su opinión. "
                    "Déjanos tus comentarios a continuación."),
            InputLabeled(controller: _inputController),
            ButtonForInput(label: "Enviar", controller: _inputController),
            const TextTitleSection(
                title: "¿Tuvo un problema usando la aplicacion?"),
            const TextSection(
                description:
                    "Contacta con el servicio de atencion al cliente para solucionar su problema. Usa uno de los botones de abajo para contactar."),
            const Align(
              alignment: Alignment.bottomCenter,
              child: ButtonSection(),
            )
          ],
        ),
      ),
    );
  }
}

class InputLabeled extends StatelessWidget {
  const InputLabeled({super.key, required this.controller});
  final controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: Alignment.bottomCenter,
      children: [
        Card(
          color: const Color.fromARGB(255, 236, 236, 236),
          elevation: 0,
          margin: const EdgeInsets.only(left: 8, right: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 6,
              decoration: const InputDecoration.collapsed(
                  hintText: "Escriba aqui sus comentarios..."),
              autocorrect: true,
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonForInput extends StatelessWidget {
  const ButtonForInput(
      {super.key, required this.label, required this.controller});

  final String label;
  final controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        _sendEmail(
            "trivi4customerservice@gmail.com", "INCIDENTE", controller.text)
      },
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
          elevation: 0,
          // fixedSize: Size(MediaQuery.of(context).size.width - 16, 40),
          foregroundColor: Colors.white),
      child: Text(label),
    );
  }

//send email
  Future<void> _sendEmail(String path, subject, body) async {
    //params
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri launchUri = Uri(
        scheme: 'mailto',
        path: path,
        query: encodeQueryParameters(<String, String>{
          "subject": subject,
          "body": body,
        }));
    await launchUrl(launchUri);
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});
  final String _phone = "+240555508692";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () => {_makePhoneCall(_phone)},
          icon: const Icon(Icons.call, color: Colors.blue),
          label: const Text("Llamar"),
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.grey)),
        ),
        TextButton.icon(
          onPressed: () => {
            _sendSms(_phone)
            // _sendEmail("trivi4customerservice@gmail.com", "INCIDENTE")
          },
          icon: const Icon(Icons.sms),
          label: const Text("Enviar sms", softWrap: true),
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.grey)),
        ),
        TextButton.icon(
          onPressed: () => {_sendWhatsapp(_phone)},
          icon: const Icon(
            CustomIcon.whatsapp,
            color: Colors.green,
          ),
          label: const Text("WhatsApp", softWrap: true),
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.grey)),
        )
      ],
    );
  }

  //dial us
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //send sms
  Future<void> _sendSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //send sms
  Future<void> _sendWhatsapp(String phoneNumber) async {
    String url = "whatsapp://send?" + phoneNumber;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Fluttertoast.showToast(msg: "No se pudo conectar con WhatsApp");
    }
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
          fontStyle: FontStyle.italic,
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
      padding: const EdgeInsets.all(8),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
