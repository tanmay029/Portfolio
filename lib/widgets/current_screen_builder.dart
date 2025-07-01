import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/AboutMe.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectDetailsScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/ServicesScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/SkillScreen.dart';
import 'package:ios_simulator_flutter_web/widgets/home_screen_content.dart';
import '../main.dart';

class CurrentScreenBuilder extends StatelessWidget {
  final SimulatorScreen currentScreen;
  final Function(SimulatorScreen) openScreen;
  final dynamic selectedProject;
  final Function(dynamic) onProjectSelected;

  const CurrentScreenBuilder({
    Key? key,
    required this.currentScreen,
    required this.openScreen,
    required this.selectedProject,
    required this.onProjectSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case SimulatorScreen.home:
  return KeyedSubtree(
    key: const ValueKey('Home'),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: HomeScreenContent(
        onSelectScreen: openScreen,
      ),
    ),
  );
      case SimulatorScreen.projects:
        return KeyedSubtree(
          key: const ValueKey('Projects'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ProjectsScreen(
              onProjectTap: (project) => onProjectSelected(project),
            ),
          ),
        );
      case SimulatorScreen.projectDetails:
        return KeyedSubtree(
          key: const ValueKey('ProjectDetails'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ProjectDetailsScreen(
              project: selectedProject!,
              onTestApp: () => openScreen(SimulatorScreen.testApp),
            ),
          ),
        );
      case SimulatorScreen.skills:
        return const KeyedSubtree(
          key: ValueKey('Skills'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: SkillsScreen(),
          ),
        );
      case SimulatorScreen.services:
        return const KeyedSubtree(
          key: ValueKey('Services'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: ServicesScreen(),
          ),
        );
      case SimulatorScreen.testApp:
        return const KeyedSubtree(
          key: ValueKey('TestApp'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: FlutterPortfolioAppView(),
          ),
        );
      case SimulatorScreen.about:
        return const KeyedSubtree(
          key: ValueKey('About'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: AboutMeScreen(),
          ),
        );
    }
  }
}
