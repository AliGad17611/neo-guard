import 'package:flutter/material.dart';
import '../../domain/entities/neo_feed_entity.dart';

class NeoStatsCards extends StatelessWidget {
  final NeoFeedEntity neoFeed;

  const NeoStatsCards({super.key, required this.neoFeed});

  @override
  Widget build(BuildContext context) {
    final allNeos = neoFeed.allNeos;
    final hazardousCount = neoFeed.hazardousNeos.length;
    final largestNeo = neoFeed.neosSortedBySize.isNotEmpty
        ? neoFeed.neosSortedBySize.first
        : null;
    final fastestNeo = neoFeed.neosSortedByVelocity.isNotEmpty
        ? neoFeed.neosSortedByVelocity.first
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.public,
                  title: 'Total NEOs',
                  value: '${allNeos.length}',
                  color: Colors.blue,
                  gradient: [Colors.blue.shade700, Colors.blue.shade900],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.warning_amber_rounded,
                  title: 'Hazardous',
                  value: '$hazardousCount',
                  color: Colors.red,
                  gradient: [Colors.red.shade700, Colors.red.shade900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.straighten,
                  title: 'Largest',
                  value: largestNeo != null
                      ? '${largestNeo.estimatedDiameter.meters.max.toStringAsFixed(0)}m'
                      : 'N/A',
                  color: Colors.purple,
                  gradient: [Colors.purple.shade700, Colors.purple.shade900],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.speed,
                  title: 'Fastest',
                  value:
                      fastestNeo != null &&
                          fastestNeo.closeApproachData.isNotEmpty
                      ? '${double.parse(fastestNeo.closeApproachData.first.relativeVelocity.kilometersPerHour).toStringAsFixed(0)} km/h'
                      : 'N/A',
                  color: Colors.orange,
                  gradient: [Colors.orange.shade700, Colors.orange.shade900],
                  smallText: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final List<Color> gradient;
  final bool smallText;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.gradient,
    this.smallText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: smallText ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
