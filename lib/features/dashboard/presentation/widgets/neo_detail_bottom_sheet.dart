import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/neo_entity.dart';

class NeoDetailBottomSheet extends StatelessWidget {
  final NeoEntity neo;

  const NeoDetailBottomSheet({super.key, required this.neo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1F3A), Color(0xFF0A0E27)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: neo.isPotentiallyHazardous
                                ? [Colors.red.shade700, Colors.red.shade900]
                                : [Colors.blue.shade700, Colors.blue.shade900],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          neo.isPotentiallyHazardous
                              ? Icons.warning_amber_rounded
                              : Icons.public,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              neo.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ID: ${neo.id}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (neo.isPotentiallyHazardous) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.red.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'This asteroid is classified as potentially hazardous',
                              style: TextStyle(
                                color: Colors.red.shade200,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                  _SectionTitle(title: 'Physical Properties'),
                  const SizedBox(height: 12),
                  _PropertyCard(
                    icon: Icons.straighten,
                    label: 'Estimated Diameter',
                    children: [
                      _PropertyRow(
                        'Minimum',
                        '${neo.estimatedDiameter.meters.min.toStringAsFixed(2)} meters',
                      ),
                      _PropertyRow(
                        'Maximum',
                        '${neo.estimatedDiameter.meters.max.toStringAsFixed(2)} meters',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _PropertyCard(
                    icon: Icons.brightness_5,
                    label: 'Absolute Magnitude',
                    children: [
                      _PropertyRow(
                        'H',
                        neo.absoluteMagnitude.toStringAsFixed(2),
                      ),
                    ],
                  ),

                  if (neo.closeApproachData.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _SectionTitle(title: 'Close Approach Data'),
                    const SizedBox(height: 12),
                    ...neo.closeApproachData.map((approach) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ApproachCard(approach: approach),
                      );
                    }),
                  ],

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl(neo.nasaJplUrl),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('View on NASA JPL'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Widget> children;

  const _PropertyCard({
    required this.icon,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.cyanAccent, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _PropertyRow extends StatelessWidget {
  final String label;
  final String value;

  const _PropertyRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApproachCard extends StatelessWidget {
  final CloseApproachData approach;

  const _ApproachCard({required this.approach});

  @override
  Widget build(BuildContext context) {
    final distance = double.parse(approach.missDistance.kilometers);
    final velocity = double.parse(approach.relativeVelocity.kilometersPerHour);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade900.withValues(alpha: 0.3),
            Colors.purple.shade800.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.purpleAccent,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                approach.closeApproachDateFull,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _PropertyRow(
            'Relative Velocity',
            '${velocity.toStringAsFixed(0)} km/h',
          ),
          _PropertyRow(
            'Miss Distance',
            '${NumberFormat.compact().format(distance)} km',
          ),
          _PropertyRow('Orbiting Body', approach.orbitingBody),
        ],
      ),
    );
  }
}
