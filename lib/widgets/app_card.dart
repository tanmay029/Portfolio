import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/AboutMe.dart';
import 'package:ios_simulator_flutter_web/main.dart';

class AppCard extends StatelessWidget {
  final SimulatorScreen screen;

  const AppCard({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label;

    switch (screen) {
      case SimulatorScreen.home:
        label = 'Home';
        break;
      case SimulatorScreen.projects:
        label = 'Projects';
        break;
      case SimulatorScreen.projectDetails:
        label = 'Project Details';
        break;
      case SimulatorScreen.skills:
        label = 'Skills';
        break;
      case SimulatorScreen.services:
        label = 'Services';
        break;
      case SimulatorScreen.testApp:
        label = 'Test App';
        break;
      case SimulatorScreen.about:
        return const KeyedSubtree(
          key: ValueKey('About'),
          child: AboutMeScreen(),
        );
      // ✅ Removed SimulatorScreen.resume — you won’t need it!
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
