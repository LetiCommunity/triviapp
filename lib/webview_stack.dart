import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:trivia/expandable_buton.dart';
import 'package:trivia/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  //vars
  /* late final AppLifecycleListener _listener;
  final ScrollController _scrollController = ScrollController();
  late AppLifecycleState? _state; */
  late final WebViewController _controller;
  int loadingPercentage = 0;
  final WebViewController controller = WebViewController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPage();
    /* SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => {},
      onResume: () => {},
      onHide: () => {},
      onInactive: () => {},
      onPause: () => {},
      onDetach: () => {},
      onRestart: () => {},
      // onExitRequested: () => Navigator.pop(context, true),
      onStateChange: _handleStateChanged,
    ); */
  }

  @override
  void dispose() {
    // _listener.dispose();
    super.dispose();
  }

  //

  @override
  Widget build(BuildContext context) {
    // final controllerActions = Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        // title: const Text(""),
        backgroundColor: const Color.fromRGBO(13, 202, 240, 1),
        foregroundColor: Colors.black,
        /* actions: <Widget>[
          NavigationControls(controller: _controller),
        ], */
        toolbarHeight: 1,
      ),
      // drawer: drawerMenu(),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          NavigationControls(controller: _controller),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const ExpandableBtnContainer(),
    );
  }

  void _loadPage() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
          // LoadingInProgress();
          isLoading = true;
        });
      }, onProgress: (int progress) {
        setState(() {
          loadingPercentage = progress;
          // LoadingInProgress();
          isLoading = true;
          print('WebView is loading (progress : $loadingPercentage%)');
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
          isLoading = false;
        });
      }, onWebResourceError: (WebResourceError error) {
        /* ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Se produjo un error al cargar."))
        ); */
        print(error.description);
      }))
      ..addJavaScriptChannel("Toaster",
          onMessageReceived: (JavaScriptMessage message) {
        /* ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(content: Text(message.message)),
          ); */
        print(message.toString());
      })
      ..loadRequest(Uri.parse("https://app.trivi4.com"));
    //
    /* isLoading ?  new Stack(
            alignment: Alignment.center,
            children: [
              new CircularProgressIndicator(),
              new Text("Cargando...")
            ],
          ) : const Stack(); */
    _controller = controller;
  }

//state
  /* void _handleStateChanged(AppLifecycleState state) {
    setState(() {
      _state = state;
    });
  } */

  //exit
  /* Future<Widget> _handleExitRequest() {
    AlertDialog(
      content: const Text("Esta seguro que desea salir?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Si")),
        TextButton(
            onPressed: () => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pulsaste No")),
                  )
                },
            child: const Text("No")),
      ],
    );
  } */
}
