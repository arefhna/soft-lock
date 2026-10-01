import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haqqında')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Logo
          Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.goldGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGold.withOpacity(0.4),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock,
                size: 70,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Soft Lock',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(child: Text('Versiya 1.0.0')),
          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bu tətbiq haqqında',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Soft Lock — toxunuşu müvəqqəti bloklayan tətbiqdir. '
                    'Ekranı kilidləyir, amma əsl kilid deyil. '
                    'Lazım olanda yuxarı sürüşdürərək açırsınız. '
                    'Arxa planda işləyən tətbiqlər dayanmır.',
                    style: TextStyle(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Xüsusiyyətlər',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _feature(Icons.lock, 'Toxunuşu blokla'),
                  _feature(Icons.swipe_up, 'Yuxarı sürüşdürərək aç'),
                  _feature(Icons.access_time, 'Saat və tarix'),
                  _feature(Icons.dark_mode, 'Dark mode'),
                  _feature(Icons.bar_chart, 'Statistika'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Center(
            child: Column(
              children: [
                Text(
                  '© 2026 Arif Qocayev',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'codestack.az studio',
                  style: TextStyle(
                    color: AppTheme.primaryGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryGold, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
