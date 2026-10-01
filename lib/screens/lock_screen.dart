import 'dart:async';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  DateTime _now = DateTime.now();
  bool _showClock = true;
  bool _showDate = true;
  double _dragOffset = 0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) setState(() => _now = DateTime.now());
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  Future<void> _loadSettings() async {
    final showClock = await StorageService.getShowClock();
    final showDate = await StorageService.getShowDate();
    if (mounted) {
      setState(() {
        _showClock = showClock;
        _showDate = showDate;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _unlock() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Bütün toxunuşları udur
        onTap: () {},
        onDoubleTap: () {},
        onLongPress: () {},
        // Yuxarı swipe → aç
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragOffset += details.delta.dy;
            if (_dragOffset > 0) _dragOffset = 0;
          });
        },
        onVerticalDragEnd: (details) {
          if (_dragOffset < -100 ||
              (details.primaryVelocity != null &&
                  details.primaryVelocity! < -500)) {
            _unlock();
          } else {
            setState(() => _dragOffset = 0);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Transform.translate(
            offset: Offset(0, _dragOffset),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Saat
                if (_showClock)
                  Text(
                    _formatTime(_now),
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),

                // Tarix
                if (_showDate) ...[
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(_now),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],

                const Spacer(),

                // Swipe göstəricisi
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        -10 * _pulseController.value,
                      ),
                      child: Opacity(
                        opacity: 0.5 + 0.5 * _pulseController.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_up,
                        color: AppTheme.primaryGold,
                        size: 60,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Yuxarı sürüşdürün',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatDate(DateTime t) {
    const months = [
      'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'İyun',
      'İyul', 'Avqust', 'Sentyabr', 'Oktyabr', 'Noyabr', 'Dekabr',
    ];
    return '${t.day} ${months[t.month - 1]} ${t.year}';
  }
}
