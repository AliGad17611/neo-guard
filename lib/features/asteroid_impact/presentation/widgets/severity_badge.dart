import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import '../../domain/entities/impact_result.dart';

class SeverityBadge extends StatelessWidget {
  final SeverityLevel level;

  const SeverityBadge({
    super.key,
    required this.level,
  });

  LinearGradient _getGradient() {
    switch (level) {
      case SeverityLevel.extinction:
        return AppColors.extinctionGradient;
      case SeverityLevel.regional:
        return AppColors.regionalGradient;
      case SeverityLevel.major:
        return AppColors.majorGradient;
      case SeverityLevel.city:
        return AppColors.cityGradient;
      case SeverityLevel.local:
        return AppColors.localGradient;
    }
  }

  String _getText() {
    switch (level) {
      case SeverityLevel.extinction:
        return 'EXTINCTION LEVEL';
      case SeverityLevel.regional:
        return 'REGIONAL CATASTROPHE';
      case SeverityLevel.major:
        return 'MAJOR DISASTER';
      case SeverityLevel.city:
        return 'CITY DESTRUCTION';
      case SeverityLevel.local:
        return 'LOCAL DAMAGE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getGradient().colors.first.withValues(alpha:0.5),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        _getText(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}