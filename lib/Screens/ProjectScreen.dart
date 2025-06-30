import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  final void Function(Project) onProjectTap;

  const ProjectsScreen({super.key, required this.onProjectTap});

  final List<Project> projects = const [
    Project(
      title: 'My Portfolio App',
      description: 'A personal portfolio app built with Flutter.',
      url: 'https://catalog-d7351.web.app',
    ),
    Project(
      title: 'Weather App',
      description: 'A dummy weather app.',
      url: 'https://example.com/weather',
    ),
    Project(
      title: 'Todo Manager',
      description: 'A dummy todo app.',
      url: 'https://example.com/todo',
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
  final String url;

  const Project({
    required this.title,
    required this.description,
    required this.url,
  });
}
