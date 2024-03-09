import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, Key? key})
      : super(key: key);

  final WebViewController controller;
  navegateBack() {
    if (controller.canGoBack() == true) {
      controller.goBack();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: IconButton(
                      onPressed: () async {
                        if (await controller.canGoBack()) {
                          await controller.goBack();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No hay historial de retroceso!')),
                          );
                          return;
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: IconButton(
                      onPressed: () async {
                        if (await controller.canGoForward()) {
                          await controller.goForward();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No hay historial de progreso!')),
                          );
                          return;
                        }
                      },
                      /* backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
                  foregroundColor: Colors.white, */
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: IconButton(
                      onPressed: () async {
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Cargando...")
                          ],
                        );
                        await controller.reload();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Actualizando...')),
                        );
                      },
                      /* backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
                  foregroundColor: Colors.white, */
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  )
                ],
              )),
          /* IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              alignment: Alignment.topLeft,
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No hay historial de retroceso!')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              alignment: Alignment.topRight,
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No hay historial de progreso!')),
                  );
                  return;
                }
              },
            ),
            IconButton( 
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Actualizando...')),
                  );
              },
            ),*/
        )
      ],
    );
  }
}
