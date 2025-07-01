import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  ServiceCard(
                    icon: Icons.phone_iphone,
                    title: 'Mobile App Development',
                    description:
                        'Cross-platform mobile apps for iOS and Android using Flutter',
                  ),
                  SizedBox(height: 20),
                  ServiceCard(
                    icon: Icons.design_services,
                    title: 'UI/UX Implementation',
                    description:
                        'Pixel-perfect designs with smooth animations and interactions',
                  ),
                  SizedBox(height: 20),
                  ServiceCard(
                    icon: Icons.speed,
                    title: 'Performance Optimization',
                    description:
                        'High-performance apps with optimized code and best practices',
                  ),
                  SizedBox(height: 20),
                  ServiceCard(
                    icon: Icons.widgets,
                    title: 'Custom Widget Development',
                    description:
                        'Reusable custom widgets tailored to your specific needs',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  "Let's Work Together",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Ready to bring your mobile app idea to life? Let's discuss your project!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                              'mailto:tanmaykumar1202@gmail.com?subject=Let\'s Work Together&body=Hi Tanmay,'),
                        );
                      },
                      icon: const Icon(Icons.mail),
                      label: const Text("Get in Touch"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                              'https://www.linkedin.com/in/tanmay-kumar-669b1a232/'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      icon: const Icon(Icons.business),
                      label: const Text("LinkedIn"),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
