import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAboutMeCard(),
              const SizedBox(height: 24),
              _buildPhilosophyCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutMeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.person_outline, color: Colors.white70),
              SizedBox(width: 8),
              Text(
                'About Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "I'm a passionate Flutter developer with over 1 years of experience creating stunning mobile applications. My journey began with a fascination for how technology can solve real-world problems and improve people's lives.\n\n"
            "I specialize in building cross-platform mobile apps that not only look beautiful but also perform exceptionally well. My approach combines technical expertise with creative design thinking to deliver solutions that exceed expectations.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                'Delhi, IN',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.email_outlined, color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                'tanmaykumar1202@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined,
                  color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                'Available for new projects',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophyCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.white70),
              SizedBox(width: 8),
              Text(
                'My Philosophy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '"Great apps aren\'t just about code — they\'re about understanding people, solving problems, and creating experiences that users genuinely love. Every line of code should serve a purpose, every animation should enhance the experience, and every design decision should make the user\'s life a little bit better."',
            style: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
