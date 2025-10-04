import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/neo_entity.dart';
import 'neo_detail_bottom_sheet.dart';

class NeoCard extends StatelessWidget {
  final NeoEntity neo;

  const NeoCard({super.key, required this.neo});

  @override
  Widget build(BuildContext context) {
    final diameter = neo.estimatedDiameter.meters.max;
    final closeApproach = neo.closeApproachData.isNotEmpty
        ? neo.closeApproachData.first
        : null;
    final velocity = closeApproach != null
        ? double.parse(closeApproach.relativeVelocity.kilometersPerHour)
        : 0.0;
    final missDistance = closeApproach != null
        ? double.parse(closeApproach.missDistance.kilometers)
        : 0.0;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => NeoDetailBottomSheet(neo: neo),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: neo.isPotentiallyHazardous
                ? [
                    Colors.red.shade900.withValues(alpha: 0.3),
                    Colors.red.shade800.withValues(alpha: 0.2),
                  ]
                : [const Color(0xFF1A1F3A), const Color(0xFF0F1628)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: neo.isPotentiallyHazardous
                ? Colors.red.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: neo.isPotentiallyHazardous
                        ? Colors.red.withValues(alpha: 0.2)
                        : Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    neo.isPotentiallyHazardous
                        ? Icons.warning_amber_rounded
                        : Icons.public,
                    color: neo.isPotentiallyHazardous
                        ? Colors.red.shade300
                        : Colors.blue.shade300,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        neo.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (neo.isPotentiallyHazardous)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'POTENTIALLY HAZARDOUS',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white38),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _InfoChip(
                    icon: Icons.straighten,
                    label: 'Size',
                    value: '${diameter.toStringAsFixed(0)}m',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoChip(
                    icon: Icons.speed,
                    label: 'Velocity',
                    value: '${velocity.toStringAsFixed(0)} km/h',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _InfoChip(
              icon: Icons.social_distance,
              label: 'Miss Distance',
              value: '${NumberFormat.compact().format(missDistance)} km',
            ),
            if (closeApproach != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.white54),
                  const SizedBox(width: 6),
                  Text(
                    'Close Approach: ${closeApproach.closeApproachDateFull}',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.cyanAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
