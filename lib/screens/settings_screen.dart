import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showClock = true;
  bool _showDate = true;
  bool _autoLock = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final a = await StorageService.getShowClock();
    final b = await StorageService.getShowDate();
    final c = await StorageService.getAutoLock();
    if (mounted) {
      setState(() {
        _showClock = a;
        _showDate = b;
        _autoLock = c;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parametrlər')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Saatı göstər'),
            subtitle: const Text('Kilid ekranında vaxt görünsün'),
            value: _showClock,
            activeColor: AppTheme.primaryGold,
            secondary: const Icon(Icons.access_time),
            onChanged: (v) async {
              await StorageService.setShowClock(v);
              setState(() => _showClock = v);
            },
          ),
          SwitchListTile(
            title: const Text('Tarixi göstər'),
            subtitle: const Text('Kilid ekranında tarix görünsün'),
            value: _showDate,
            activeColor: AppTheme.primaryGold,
            secondary: const Icon(Icons.calendar_today),
            onChanged: (v) async {
              await StorageService.setShowDate(v);
              setState(() => _showDate = v);
            },
          ),
          SwitchListTile(
            title: const Text('Avtomatik kilid'),
            subtitle: const Text('5 saniyə hərəkətsizlikdən sonra kilidlən'),
            value: _autoLock,
            activeColor: AppTheme.primaryGold,
            secondary: const Icon(Icons.timer),
            onChanged: (v) async {
              await StorageService.setAutoLock(v);
              setState(() => _autoLock = v);
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Statistikanı sıfırla?'),
                  content: const Text('Bütün statistika silinəcək.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Ləğv et'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Sıfırla'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await StorageService.resetStats();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Statistika sıfırlandı')),
                  );
                }
              }
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Statistikanı sıfırla'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
