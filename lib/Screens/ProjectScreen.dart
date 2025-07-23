import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  final void Function(Project) onProjectTap;

  const ProjectsScreen({super.key, required this.onProjectTap});

  final List<Project> projects = const [
    Project(
      title: 'My Catalog App',
      description: 'A Catalog app built with Flutter.',
      url: 'https://catalog-d7351.web.app',
      techStack: [
        'Flutter',
        'Firebase',
        'Stripe API',
        'Provider',
        'Cloud Firestore'
      ],
      githubUrl: 'https://github.com/tanmay029/catalog',
      screenshots: [
        'assets/screenshots/catalog_1.png',
        'assets/screenshots/catalog_2.png',
        'assets/screenshots/catalog_3.png',
        'assets/screenshots/catalog_4.png',
      ],
    ),
    Project(
      title: 'D-Day',
      description: 'A simple task reminder.',
      url: 'https://dday-ecaf3.web.app',
      techStack: [
        'Flutter',
        'Firebase',
        'Stripe API',
        'Provider',
        'Cloud Firestore'
      ],
      githubUrl: 'https://github.com/tanmay029/D-Day',
      screenshots: [
        'assets/screenshots/dday_1.png',
        'assets/screenshots/dday_2.png',
        'assets/screenshots/dday_3.png',
        'assets/screenshots/dday_4.png',
      ],
    ),
    Project(
      title: 'This Simulator',
      description: 'This iPhone simulator is a project itself.',
      url: 'https://myportfolio-65f8e.web.app',
      techStack: ['Flutter', 'Firebase', 'Dart'],
      githubUrl: '',
      screenshots: [
        'assets/screenshots/sim_1.png',
        'assets/screenshots/sim_2.png',
        'assets/screenshots/sim_3.png',
        'assets/screenshots/sim_4.png',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Projects',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: projects.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2, 
                ),
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return GestureDetector(
                    onTap: () => onProjectTap(project),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Center(
                        child: Text(
                          project.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String url;
  final List<String> screenshots;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    required this.url,
    required this.screenshots,
  });
}
