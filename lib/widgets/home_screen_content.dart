import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/widgets/app_icon_button.dart';
import '../main.dart';
import 'dart:html' as html;
// import 'package:ios_simulator_flutter_web/widgets/ios_status_bar.dart'; // Import the new status bar

class HomeScreenContent extends StatelessWidget {
  final void Function(SimulatorScreen) onSelectScreen;

  const HomeScreenContent({
    Key? key,
    required this.onSelectScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF7F00FF), Color(0xFF3C00FF)],
                ),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Hello, I'm Tanmay",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Flutter Developer ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              AppIconButton(
                label: 'About Me',
                icon: Icons.person,
                onTap: () => onSelectScreen(SimulatorScreen.about),
              ),
              AppIconButton(
                label: 'Projects',
                icon: Icons.code,
                onTap: () => onSelectScreen(SimulatorScreen.projects),
              ),
              AppIconButton(
                label: 'Skills',
                icon: Icons.star,
                onTap: () => onSelectScreen(SimulatorScreen.skills),
              ),
              AppIconButton(
                label: 'Services',
                icon: Icons.work,
                onTap: () => onSelectScreen(SimulatorScreen.services),
              ),
              // AppIconButton(
              //   label: 'Resume',
              //   icon: Icons.file_download,
              //   onTap: () {
              //     final url = 'resume/Tanmay_Resume.pdf';
              //     html.AnchorElement(href: url)
              //       ..setAttribute('download', 'Tanmay_Resume.pdf')
              //       ..click();
              //   },
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Kindly use it on desktop, else the demo for some project might have some issues",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
