import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';
// import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;
  final VoidCallback onTestApp;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
    required this.onTestApp,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            project.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            project.description,
            style: const TextStyle(color: Colors.white70),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onTestApp,
            child: const Text('Test App'),
          ),
        ],
      ),
    );
  }
}
