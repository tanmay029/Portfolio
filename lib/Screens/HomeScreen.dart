import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';
import 'package:ios_simulator_flutter_web/main.dart';
import 'package:ios_simulator_flutter_web/widgets/app_card.dart';
import 'package:ios_simulator_flutter_web/widgets/app_switcher_overlay.dart';
import 'package:ios_simulator_flutter_web/widgets/current_screen_builder.dart';

class IPhoneHomeScreen extends StatefulWidget {
  const IPhoneHomeScreen({super.key});

  @override
  State<IPhoneHomeScreen> createState() => _IPhoneHomeScreenState();
}

class _IPhoneHomeScreenState extends State<IPhoneHomeScreen> {
  SimulatorScreen _currentScreen = SimulatorScreen.home;
  bool _showSwitcher = false;
  Project? _selectedProject;

  final List<SimulatorScreen> _openedApps = [SimulatorScreen.home];

  void _openScreen(SimulatorScreen screen) {
    setState(() {
      _currentScreen = screen;
      if (!_openedApps.contains(screen)) {
        _openedApps.add(screen);
      }
    });
  }

  void _closeScreen(SimulatorScreen screen) {
    setState(() {
      _openedApps.remove(screen);
      if (_openedApps.isEmpty) {
        _openedApps.add(SimulatorScreen.home);
      }
      _currentScreen = _openedApps.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full page background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Centered iPhone simulator
          Center(
            child: Container(
              width: 390,
              height: 844,
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white24, width: 6),
                color: Colors.black
                    .withOpacity(0.5), // Optional overlay for contrast
              ),
              child: Stack(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: CurrentScreenBuilder(
                      currentScreen: _currentScreen,
                      openScreen: _openScreen,
                      selectedProject: _selectedProject,
                      onProjectSelected: (project) {
                        _selectedProject = project;
                        _openScreen(SimulatorScreen.projectDetails);
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentScreen = SimulatorScreen.home;
                          _showSwitcher = false;
                          _selectedProject = null;
                          _openedApps.clear();
                          _openedApps.add(SimulatorScreen.home);
                        });
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            width: 140,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_showSwitcher)
                    AppSwitcherOverlay(
                      openedApps: _openedApps,
                      onCloseScreen: _closeScreen,
                      onTapScreen: (screen) {
                        setState(() {
                          _currentScreen = SimulatorScreen.home;
                          _showSwitcher = false;
                          _selectedProject = null;
                          _openedApps.clear();
                          _openedApps.add(SimulatorScreen.home);
                        });
                      },
                      appCardBuilder: (screen) => AppCard(screen: screen),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
