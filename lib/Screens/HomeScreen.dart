import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/widgets/ios_status_bar.dart';
import 'package:ios_simulator_flutter_web/widgets/app_card.dart';
import 'package:ios_simulator_flutter_web/widgets/app_switcher_overlay.dart';
import 'package:ios_simulator_flutter_web/widgets/current_screen_builder.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';
import 'package:ios_simulator_flutter_web/main.dart';

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
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: isDesktop ? Colors.white : Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black),
          ),
          Center(
            child: Container(
              width: 390,
              height: 844,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white, width: 6),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Column(
                children: [
                  if (_currentScreen != SimulatorScreen.testApp) ...[
                    const SizedBox(height: 12),
                    const IOSStatusBar(),
                    const SizedBox(height: 2),
                  ],
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 36),
                          child: AnimatedSwitcher(
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
                              key: ValueKey(_currentScreen),
                              currentScreen: _currentScreen,
                              openScreen: _openScreen,
                              selectedProject: _selectedProject,
                              onProjectSelected: (project) {
                                _selectedProject = project;
                                _openScreen(SimulatorScreen.projectDetails);
                              },
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
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 75,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(34),
                                bottomRight: Radius.circular(34),
                              ),
                            ),
                            child: Center(
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
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.7),
                                    border: Border.all(
                                        color: Colors.white54, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
