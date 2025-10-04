import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: AppColors.purple300.withValues(alpha: 0.3),
          thickness: 1,
        ),
        const SizedBox(height: 16),
        Text(
          'POWERED BY NASA DATA',
          style: TextStyle(
            color: AppColors.purple300.withValues(alpha: 0.6),
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 12,
              color: AppColors.purple300.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 6),
            Text(
              'PROTECTING EARTH SINCE 2025',
              style: TextStyle(
                color: AppColors.purple300.withValues(alpha: 0.6),
                fontSize: 9,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
