import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  final void Function(Project) onProjectTap;

  ProjectsScreen({super.key, required this.onProjectTap});

  final List<Project> projects = [
    Project(
      title: 'My Portfolio App',
      description: 'A personal portfolio app built with Flutter.',
      url: 'https://catalog-d7351.web.app',
      techStack: [
        'Flutter',
        'Firebase',
        'Stripe API',
        'Provider',
        'Cloud Firestore'
      ],
      githubUrl: 'https://github.com/tanmay029/catalog',
    ),
    Project(
      title: 'Weather App',
      description: 'A dummy weather app.',
      url: 'https://example.com/weather',
      techStack: [],
      githubUrl: '',
    ),
    Project(
      title: 'Todo Manager',
      description: 'A dummy todo app.',
      url: 'https://example.com/todo',
      techStack: [],
      githubUrl: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Projects',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            itemCount: projects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              return GestureDetector(
                onTap: () => onProjectTap(project),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      project.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String url;

  Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    required this.url,
  });
}
