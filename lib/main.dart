import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/HomeScreen.dart';

enum SimulatorScreen {
  home,
  projects,
  projectDetails,
  skills,
  services,
  testApp,
  about
}

void main() {
  FlutterAppSimulator.registerIframe();
  runApp(const PortfolioSimulatorApp());
}

class FlutterPortfolioAppView extends StatelessWidget {
  const FlutterPortfolioAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(viewType: 'iframe-simulator');
  }
}

class FlutterAppSimulator {
  static void registerIframe() {
    ui.platformViewRegistry.registerViewFactory(
      'iframe-simulator',
      (int viewId) => html.IFrameElement()
        ..src = 'https://catalog-d7351.web.app'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }
}

class PortfolioSimulatorApp extends StatelessWidget {
  const PortfolioSimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dev Portfolio',
      theme: ThemeData.dark(),
      home: const IPhoneHomeScreen(),
    );
  }
}