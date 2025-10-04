import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import '../../domain/entities/impact_result.dart';

class StatsDisplay extends StatelessWidget {
  final ImpactResult result;
  final bool isPreview;

  const StatsDisplay({super.key, required this.result, this.isPreview = false});

  String _formatNumber(double value, int decimals) {
    final formatted = value.toStringAsFixed(decimals);
    final parts = formatted.split('.');

    // Add comma separators to integer part
    final intPart = parts[0];
    final withCommas = intPart.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return decimals > 0 && parts.length > 1
        ? '$withCommas.${parts[1]}'
        : withCommas;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatCard(
          icon: Icons.flash_on,
          label: 'Impact Energy',
          value: _formatNumber(result.impactEnergy, 2),
          unit: 'MEGATONS TNT',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.purple600.withValues(alpha:0.2),
              AppColors.purple800.withValues(alpha:0.4),
            ],
          ),
          borderColor: AppColors.purple400.withValues(alpha:0.6),
          iconColor: AppColors.purple400,
          accentColor: AppColors.purple300,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.gps_fixed,
          label: 'Crater Diameter',
          value: _formatNumber(result.craterSize, 0),
          unit: 'METERS',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.blue600.withValues(alpha:0.2),
              AppColors.blue800.withValues(alpha:0.4),
            ],
          ),
          borderColor: AppColors.blue400.withValues(alpha:0.6),
          iconColor: AppColors.blue400,
          accentColor: AppColors.blue300,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.radio_button_checked,
          label: 'Damage Radius',
          value: _formatNumber(result.damageRadius, 1),
          unit: 'KILOMETERS',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.indigo600.withValues(alpha:0.2),
              AppColors.indigo800.withValues(alpha:0.4),
            ],
          ),
          borderColor: AppColors.indigo400.withValues(alpha:0.6),
          iconColor: AppColors.indigo400,
          accentColor: AppColors.purple300,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Gradient gradient,
    required Color borderColor,
    required Color iconColor,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha:0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            // Icon section with circular background
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha:0.15),
                shape: BoxShape.circle,
                border: Border.all(color: iconColor.withValues(alpha:0.3), width: 2),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),

            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: TextStyle(
                      color: accentColor.withValues(alpha:0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                      color: isPreview
                          ? Colors.white.withValues(alpha:0.7)
                          : Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    unit,
                    style: TextStyle(
                      color: iconColor.withValues(alpha:0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
