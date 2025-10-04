import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';

class DefinitionsScreen extends StatelessWidget {
  const DefinitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text('Definitions',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,

        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: const Stack(
          children: [
            Positioned.fill(child: AnimatedStarfield()),
            SafeArea(
              child: DefinitionsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class DefinitionsList extends StatelessWidget {
  const DefinitionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        DefinitionCard(
          title: 'What is a Near-Earth Object (NEO)?',
          content:
              'A Near-Earth Object (NEO) is an asteroid or comet that passes close to Earth\'s orbit. They are monitored by space agencies to assess any potential impact risk.',
        ),
        DefinitionCard(
          title: 'What is the Torino Scale?',
          content:
              'The Torino Scale is a method for categorizing the impact hazard associated with NEOs. It uses a scale from 0 to 10, where 0 means no hazard and 10 means a certain collision with global climatic catastrophe.',
        ),
        DefinitionCard(
          title: 'What is a Potentially Hazardous Asteroid (PHA)?',
          content:
              'A Potentially Hazardous Asteroid (PHA) is an asteroid that is large enough and comes close enough to Earth to pose a potential threat. Specifically, it must have a minimum orbit intersection distance of 0.05 AU or less and an absolute magnitude of 22.0 or brighter.',
        ),
        DefinitionCard(
          title: 'What is the Asteroid Belt?',
          content:
              'The Asteroid Belt is a torus-shaped region in the Solar System, located roughly between the orbits of the planets Jupiter and Mars. It contains a great many solid, irregularly shaped bodies, of many sizes but much smaller than planets, called asteroids or minor planets.',
        ),
        DefinitionCard(
          title: 'What is a Near-Earth Object (NEO)?',
          content:
          'A Near-Earth Object (NEO) is an asteroid or comet that passes close to Earth\'s orbit. They are monitored by space agencies to assess any potential impact risk.',
        ),
        DefinitionCard(
          title: 'What is the Torino Scale?',
          content:
          'The Torino Scale is a system used to classify the impact hazard of Near-Earth Objects. It ranges from 0 (no hazard) to 10 (certain collision causing global disaster).',
        ),
        DefinitionCard(
          title: 'What is a Potentially Hazardous Asteroid (PHA)?',
          content:
          'A Potentially Hazardous Asteroid (PHA) is a large asteroid that passes within 0.05 AU of Earth\'s orbit and is bright enough (magnitude 22.0 or less) to pose a possible threat.',
        ),
        DefinitionCard(
          title: 'What is an Asteroid?',
          content:
          'An asteroid is a rocky object orbiting the Sun, mostly found in the asteroid belt between Mars and Jupiter. Some cross Earth’s orbit and are called Near-Earth Asteroids.',
        ),
        DefinitionCard(
          title: 'What is a Comet?',
          content:
          'A comet is a small icy body that releases gas and dust when it nears the Sun, forming a glowing coma and tail that always points away from the Sun.',
        ),
        DefinitionCard(
          title: 'What is a Meteoroid?',
          content:
          'A meteoroid is a small piece of rock or metal from space, usually smaller than an asteroid. When it enters Earth\'s atmosphere, it becomes a meteor.',
        ),
        DefinitionCard(
          title: 'What is a Meteor?',
          content:
          'A meteor, often called a "shooting star," is the bright streak of light produced when a meteoroid burns up in Earth\'s atmosphere.',
        ),
        DefinitionCard(
          title: 'What is a Meteorite?',
          content:
          'A meteorite is a fragment of a meteoroid that survives its fiery entry through the atmosphere and lands on Earth\'s surface.',
        ),
        DefinitionCard(
          title: 'What is a Meteor Shower?',
          content:
          'A meteor shower happens when Earth passes through the trail of debris left by a comet, causing many meteors to appear in the night sky from a specific direction.',
        ),
        DefinitionCard(
          title: 'What is an Impact Event?',
          content:
          'An impact event occurs when an asteroid, comet, or meteorite collides with Earth, releasing huge amounts of energy that can cause craters or, in rare cases, global effects.',
        ),
      ],
    );
  }
}

class DefinitionCard extends StatelessWidget {
  final String title;
  final String content;

  const DefinitionCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.purple900.withValues(alpha:0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColors.purple500.withValues(alpha:0.5)),
      ),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        childrenPadding: const EdgeInsets.all(16.0),
        expandedAlignment: Alignment.centerLeft,
        iconColor: AppColors.purple200,
        collapsedIconColor: AppColors.purple300,
        children: [
          Text(
            content,
            style: TextStyle(color: AppColors.purple200, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
