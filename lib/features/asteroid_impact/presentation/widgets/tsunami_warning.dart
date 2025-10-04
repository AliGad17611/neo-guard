import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';

class TsunamiWarning extends StatefulWidget {
  const TsunamiWarning({super.key});

  @override
  State<TsunamiWarning> createState() => _TsunamiWarningState();
}

class _TsunamiWarningState extends State<TsunamiWarning>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.red600.withValues(alpha:0.3),
                AppColors.red800.withValues(alpha:0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.red500,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.red500.withValues(alpha:_controller.value * 0.5),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.0 + (_controller.value * 0.2),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.red400,
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⚠️ TSUNAMI ALERT',
                      style: TextStyle(
                        color: AppColors.red200,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Catastrophic wave generation detected',
                      style: TextStyle(
                        color: AppColors.red300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}