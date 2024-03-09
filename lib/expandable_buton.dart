import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:share_plus/share_plus.dart';

class ExpandableBtnContainer extends StatefulWidget { 
  const ExpandableBtnContainer({Key? key}) : super(key: key);

  @override
  State<ExpandableBtnContainer> createState() => _ExpandableBtnContainer();

}

class _ExpandableBtnContainer extends State<ExpandableBtnContainer> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return btnFloatingMenu();
  }

  Widget btnFloatingMenu() {
    return ExpandableFab(
      key: _key,
      duration: const Duration(milliseconds: 500),
        distance: 80.0,
        type: ExpandableFabType.up,
        pos: ExpandableFabPos.right,
        childrenOffset: const Offset(0, 10),
        // fanAngle: 40,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(
            Icons.menu_rounded,
            size: 30,
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
          // shape: const CircleBorder(),
          // angle: 3.14 / 2,
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 50,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) {
            return IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.close_sharp,
                size: 40,
              ),
              // splashColor: Colors.grey,
            );
          },
        ),
      overlayStyle: ExpandableFabOverlayStyle(
        blur: 3
      ),
      onOpen: () {
        debugPrint("onOpen");
      },
      afterOpen: () {
        debugPrint("afterOpen");
      },
      onClose: () {
        debugPrint("onClose");
      },
      afterClose: () {
        debugPrint("afterClose");
      },
      children: [
        /* FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            tooltip: "Salir",
            label: const Text("Salir"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showExitPopup();
            },
          ), */
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            tooltip: "Soporte",
            label: const Text("Soporte"),
            icon: const Icon(Icons.contact_support_outlined),
            onPressed: () {
              _onSupport();
            },
          ),
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            tooltip: "Acerca de",
            label: const Text("Acerca de"),
            icon: const Icon(Icons.info_outlined),
            onPressed: () {
              _onAbout();
            },
          ),
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            tooltip: "Compartir",
            label: const Text("Compartir"),
            icon: const Icon(Icons.share),
            onPressed: () {
              _onShare();
            },
          ),
        ],
    );
  }
  //buton's actions
  Future<void> _onShare() async {
  String text = 'Hola, descarga la aplicación Trivia con el siguiente enlace. https://app.trivi4.com';
  String subject = 'Descargar la aplicacion Trivia';
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
  //navegate to about page
  void _onSupport() {
    Navigator.pushNamed(context, "/support");
  }
  //about us dialog
  Future<void> _onAbout() async {
    // Navigator.pushNamed(context, "/about");
    return await showDialog(
      context: context,
      builder: (context) => const AboutDialog(
        /* applicationIcon: Image.asset(
          "img/trivia.png",
          fit: BoxFit.cover,
        ), */
        applicationName: "Trivia",
        applicationVersion: "v1.0.0",
        children: [
          Text(
            "Trivia es un servicio desarrollado por Leti Comunity, "
          "+una comunidad de desarrollo de aplicaciones webs, "
          +"moviles y de escritorio localizada en Guinea Ecuatorial.\n",
          softWrap: true,
          ),
        ],
        applicationLegalese: "© Copyright Leti Comunity 2024",
      )
    );
  }
  //on exit
  Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Salir de la aplicacion'),
          content: const Text('Desea salir de la aplicacion?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
               //return false when click on "NO"
              child: const Text('No'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true), 
              //return true when click on "Yes"
              child: const Text('Si'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
}