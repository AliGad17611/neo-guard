import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/meteor_madness_cubit.dart';
import '../cubit/meteor_madness_state.dart';
import '../game/meteor_madness_game.dart';
import '../widgets/game_hud.dart';
import '../widgets/game_over_overlay.dart';
import '../widgets/wave_complete_overlay.dart';
import '../widgets/weapon_selector.dart';
import 'level_selection_page.dart';

class MeteorMadnessPage extends StatefulWidget {
  final GameDifficulty difficulty;

  const MeteorMadnessPage({super.key, this.difficulty = GameDifficulty.normal});

  @override
  State<MeteorMadnessPage> createState() => _MeteorMadnessPageState();
}

class _MeteorMadnessPageState extends State<MeteorMadnessPage> {
  late MeteorMadnessGame game;
  late MeteorMadnessCubit cubit;
  int score = 0;
  int combo = 0;
  int health = 100;
  int wave = 1;
  bool showWeaponSelector = false;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MeteorMadnessCubit>();
    game = MeteorMadnessGame(difficulty: widget.difficulty)
      ..onGameStateUpdate = (s, c, h, w) {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                score = s;
                combo = c;
                health = h;
                wave = w;
              });
            }
          });
        }
      }
      ..onGameOver = () {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              cubit.gameOver(
                game.score,
                game.currentWave,
                game.meteorsDestroyed,
                0.75, // accuracy placeholder
              );
            }
          });
        }
      }
      ..onWaveComplete = (w) {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              cubit.completeWave(w, score, 100, 0);
            }
          });
        }
      };

    cubit.startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MeteorMadnessCubit, MeteorMadnessState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Game canvas
              GameWidget(game: game),

              // HUD overlay
              GameHUD(
                score: score,
                combo: combo,
                health: health,
                wave: wave,
                shieldActive: game.shieldActive,
                shieldCooldown: game.shieldCooldown,
                cannonUpgrades: game.cannonUpgrades,
                currentWeapon: game.currentWeapon,
                onWeaponSelect: () {
                  setState(() {
                    showWeaponSelector = !showWeaponSelector;
                  });
                },
                onPause: () {
                  game.pauseEngine();
                  cubit.pauseGame();
                  _showPauseDialog();
                },
                onShield: () {
                  game.activateShield();
                },
              ),

              // Weapon selector overlay
              if (showWeaponSelector)
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: WeaponSelector(
                    currentWave: wave,
                    selectedWeapon: game.currentWeapon,
                    onWeaponSelected: (weapon) {
                      game.changeWeapon(weapon);
                      setState(() {
                        showWeaponSelector = false;
                      });
                    },
                    onClose: () {
                      setState(() {
                        showWeaponSelector = false;
                      });
                    },
                  ),
                ),

              // Wave complete overlay
              if (state is MeteorMadnessWaveComplete)
                WaveCompleteOverlay(
                  state: state,
                  onContinue: () {
                    cubit.nextWave();
                    game.resumeEngine();
                  },
                ),

              // Game over overlay
              if (state is MeteorMadnessGameOver)
                GameOverOverlay(
                  state: state,
                  onRetry: () {
                    cubit.resetGame();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  onMainMenu: () {
                    Navigator.of(context).pop();
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void _showPauseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B2845),
        title: const Text('PAUSED', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(color: Colors.white70),
            ),
            Text('Wave: $wave', style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              game.resumeEngine();
              cubit.resumeGame();
            },
            child: const Text('RESUME'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('QUIT'),
          ),
        ],
      ),
    );
  }
}
