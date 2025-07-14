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
  about,
}

void main() {
  runApp(const PortfolioSimulatorApp());
}

class FlutterPortfolioAppView extends StatelessWidget {
  final String projectUrl;

  const FlutterPortfolioAppView({
    super.key,
    required this.projectUrl,
  });

  @override
  Widget build(BuildContext context) {
    final String viewType = 'iframe-simulator-${projectUrl.hashCode}';

    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) {
        final iframe = html.IFrameElement()
          ..src = projectUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';

        return iframe;
      },
    );

    return HtmlElementView(viewType: viewType);
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
