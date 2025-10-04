import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Icon - Animated Glow
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.2),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: 1 + (0.05 * scale),
              child: child,
            );
          },
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.purple400, AppColors.blue400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purple400.withValues(alpha:0.6),
                  blurRadius: 25,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.rocket_launch,
                size: 56,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        // App Title - Gradient Text
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.purple400,
              Colors.pinkAccent.shade200,
              AppColors.blue400,
            ],
          ).createShader(bounds),
          child: const Text(
            'NEOGUARD',
            style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 5,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Subtitle
        Text(
          'PLANETARY DEFENSE SYSTEM',
          style: TextStyle(
            color: AppColors.purple300,
            fontSize: 15,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 22),

        // Status Row with Glow Dot
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.green400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.green400.withValues(alpha:0.8),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'ALL SYSTEMS OPERATIONAL',
              style: TextStyle(
                color: AppColors.green400,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
