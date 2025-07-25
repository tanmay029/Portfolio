import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:ios_simulator_flutter_web/Screens/ProjectScreen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;
  final VoidCallback onTestApp;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
    required this.onTestApp,
  });

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int? _expandedIndex;

  void _launchGitHub(String url) {
    html.window.open(url, '_blank');
  }

  void _expand(int index) {
    setState(() {
      _expandedIndex = index;
    });
  }

  void _closeExpanded() {
    setState(() {
      _expandedIndex = null;
    });
  }

  void _swipeLeft() {
    if (_expandedIndex != null) {
      setState(() {
        _expandedIndex =
            (_expandedIndex! + 1) % widget.project.screenshots.length;
      });
    }
  }

  void _swipeRight() {
    if (_expandedIndex != null) {
      setState(() {
        _expandedIndex =
            (_expandedIndex! - 1 + widget.project.screenshots.length) %
                widget.project.screenshots.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSimulatorProject =
        widget.project.title.toLowerCase().contains('simulator');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.project.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.project.techStack
                        .map(
                          (tech) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tech,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.project.screenshots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _expand(index),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            widget.project.screenshots[index],
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Row of Buttons
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              _launchGitHub(widget.project.githubUrl),
                          icon: const Icon(Icons.code),
                          label: const Text('GitHub'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed:
                              isSimulatorProject ? null : widget.onTestApp,
                          icon: const Icon(Icons.play_arrow),
                          label: Text(
                            isSimulatorProject
                                ? 'Try Simulator'
                                : 'Try Simulator',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSimulatorProject
                                ? Colors.grey
                                : const Color(0xFF2196F3),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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

          // Fullscreen Screenshot View
          if (_expandedIndex != null)
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  _swipeLeft();
                } else if (details.primaryVelocity! > 0) {
                  _swipeRight();
                }
              },
              child: Container(
                color: Colors.black.withOpacity(0.9),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        widget.project.screenshots[_expandedIndex!],
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 280,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 32),
                        onPressed: _closeExpanded,
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
