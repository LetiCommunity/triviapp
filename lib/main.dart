import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:trivia/about_page.dart';
import 'package:trivia/suport_page.dart';
import 'package:trivia/webview_container.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WebviewContainer(),
        '/support': (context) => const SupportPage(),
        '/about': (context) => const AboutPage(),
      },
  ));
  FlutterNativeSplash.remove();
  // whenever your initialization is completed, remove the splash screen:
} 
