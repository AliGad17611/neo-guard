import 'package:flutter/material.dart';
import '../../../../core/router/routes.dart';

enum GameDifficulty {
  easy(
    name: 'EASY',
    color: Color(0xFF4ADE80),
    description: 'Slower meteors, more time to react',
    speedMultiplier: 0.7,
    meteorHealthMultiplier: 0.8,
    damageMultiplier: 0.7,
  ),
  normal(
    name: 'NORMAL',
    color: Color(0xFFFF8C00),
    description: 'Balanced gameplay experience',
    speedMultiplier: 1.0,
    meteorHealthMultiplier: 1.0,
    damageMultiplier: 1.0,
  ),
  hard(
    name: 'HARD',
    color: Color(0xFFFF006E),
    description: 'Faster meteors, more challenging',
    speedMultiplier: 1.3,
    meteorHealthMultiplier: 1.2,
    damageMultiplier: 1.5,
  ),
  extreme(
    name: 'EXTREME',
    color: Color(0xFF9333EA),
    description: 'Only for expert players',
    speedMultiplier: 1.6,
    meteorHealthMultiplier: 1.5,
    damageMultiplier: 2.0,
  );

  final String name;
  final Color color;
  final String description;
  final double speedMultiplier;
  final double meteorHealthMultiplier;
  final double damageMultiplier;

  const GameDifficulty({
    required this.name,
    required this.color,
    required this.description,
    required this.speedMultiplier,
    required this.meteorHealthMultiplier,
    required this.damageMultiplier,
  });
}

class LevelSelectionPage extends StatefulWidget {
  const LevelSelectionPage({super.key});

  @override
  State<LevelSelectionPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage>
    with TickerProviderStateMixin {
  GameDifficulty selectedDifficulty = GameDifficulty.normal;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'SELECT DIFFICULTY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Difficulty Cards
              Expanded(
                child: FadeTransition(
                  opacity: _animationController,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: GameDifficulty.values.length,
                    itemBuilder: (context, index) {
                      final difficulty = GameDifficulty.values[index];
                      final isSelected = selectedDifficulty == difficulty;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDifficulty = difficulty;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? difficulty.color
                                    : Colors.white24,
                                width: isSelected ? 3 : 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              gradient: isSelected
                                  ? LinearGradient(
                                      colors: [
                                        difficulty.color.withValues(alpha: 0.3),
                                        difficulty.color.withValues(alpha: 0.1),
                                      ],
                                    )
                                  : null,
                              color: isSelected
                                  ? null
                                  : const Color(
                                      0xFF1E293B,
                                    ).withValues(alpha: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        difficulty.name,
                                        style: TextStyle(
                                          color: isSelected
                                              ? difficulty.color
                                              : Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle,
                                          color: difficulty.color,
                                          size: 32,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    difficulty.description,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Stats
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _buildStatChip(
                                        'Speed',
                                        '${(difficulty.speedMultiplier * 100).toInt()}%',
                                        difficulty.color,
                                      ),
                                      _buildStatChip(
                                        'Meteor HP',
                                        '${(difficulty.meteorHealthMultiplier * 100).toInt()}%',
                                        difficulty.color,
                                      ),
                                      _buildStatChip(
                                        'Damage',
                                        '${(difficulty.damageMultiplier * 100).toInt()}%',
                                        difficulty.color,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Start Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.meteorMadnessPlay,
                        arguments: selectedDifficulty,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDifficulty.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'START GAME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
