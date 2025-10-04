import 'package:flutter/material.dart';
import '../../domain/entities/neo_feed_entity.dart';
import 'neo_card.dart';

class NeoListView extends StatelessWidget {
  final NeoFeedEntity neoFeed;

  const NeoListView({super.key, required this.neoFeed});

  @override
  Widget build(BuildContext context) {
    final neos = neoFeed.allNeos;

    if (neos.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Icon(
                  Icons.sentiment_satisfied,
                  size: 64,
                  color: Colors.white38,
                ),
                const SizedBox(height: 16),
                Text(
                  'No asteroids found for this date range',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Near Earth Objects',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.cyanAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '${neos.length} Objects',
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final neo = neos[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: NeoCard(neo: neo),
        );
      }, childCount: neos.length + 1),
    );
  }
}
