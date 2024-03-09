import 'package:flutter/material.dart';
import 'package:trivia/webview_stack.dart';

class WebviewContainer extends StatefulWidget {
  const WebviewContainer({super.key});

  @override
  State<WebviewContainer> createState() => _WebviewContainerState();
}

class _WebviewContainerState extends State<WebviewContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: const WebViewStack(),
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