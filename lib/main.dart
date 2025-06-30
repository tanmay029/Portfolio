import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectDetailsScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/ServicesScreen.dart';
import 'package:ios_simulator_flutter_web/Screens/SkillScreen.dart';

enum SimulatorScreen {
  home,
  projects,
  projectDetails,
  skills,
  services,
  testApp,
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
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF2E0059),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white24, width: 6),
          ),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1), // slide up slightly
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: _buildCurrentScreen(),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
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
                      width: 140,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showSwitcher) _buildAppSwitcherOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppSwitcherOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: _openedApps.map((screen) {
          return Draggable(
            feedback: _appCard(screen),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              if (details.offset.dy < -100) {
                _closeScreen(screen);
              }
            },
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
              child: _appCard(screen),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _appCard(SimulatorScreen screen) {
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
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case SimulatorScreen.home:
        return KeyedSubtree(
          key: const ValueKey('Home'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: _buildHomeScreen(),
          ),
        );
      case SimulatorScreen.projects:
        return KeyedSubtree(
          key: const ValueKey('Projects'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ProjectsScreen(
              onProjectTap: (project) {
                _selectedProject = project;
                _openScreen(SimulatorScreen.projectDetails);
              },
            ),
          ),
        );
      case SimulatorScreen.projectDetails:
        return KeyedSubtree(
          key: const ValueKey('ProjectDetails'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ProjectDetailsScreen(
              project: _selectedProject!,
              onTestApp: () {
                _openScreen(SimulatorScreen.testApp);
              },
            ),
          ),
        );
      case SimulatorScreen.skills:
        return const KeyedSubtree(
          key: ValueKey('Skills'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: SkillsScreen(),
          ),
        );
      case SimulatorScreen.services:
        return const KeyedSubtree(
          key: ValueKey('Services'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ServicesScreen(),
          ),
        );
      case SimulatorScreen.testApp:
        return const KeyedSubtree(
          key: ValueKey('TestApp'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: FlutterPortfolioAppView(),
          ),
        );
    }
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        const Text(
          "iOS Simulator - Portfolio",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildAppIcon('About Me', Icons.person, () {
                setState(() {
                  _currentScreen = SimulatorScreen.testApp;
                });
              }),
              _buildAppIcon('Projects', Icons.code, () {
                setState(() {
                  _currentScreen = SimulatorScreen.projects;
                });
              }),
              _buildAppIcon('Skills', Icons.star, () {
                setState(() {
                  _currentScreen = SimulatorScreen.skills;
                });
              }),
              _buildAppIcon('Services', Icons.work, () {
                setState(() {
                  _currentScreen = SimulatorScreen.services;
                });
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppIcon(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
