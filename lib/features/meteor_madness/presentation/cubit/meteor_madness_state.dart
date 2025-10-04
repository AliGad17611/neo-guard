import 'package:equatable/equatable.dart';

abstract class MeteorMadnessState extends Equatable {
  const MeteorMadnessState();

  @override
  List<Object?> get props => [];
}

class MeteorMadnessInitial extends MeteorMadnessState {}

class MeteorMadnessPlaying extends MeteorMadnessState {
  final int currentWave;
  final int score;
  final int planetHealth;
  final int combo;

  const MeteorMadnessPlaying({
    required this.currentWave,
    required this.score,
    required this.planetHealth,
    required this.combo,
  });

  @override
  List<Object?> get props => [currentWave, score, planetHealth, combo];

  MeteorMadnessPlaying copyWith({
    int? currentWave,
    int? score,
    int? planetHealth,
    int? combo,
  }) {
    return MeteorMadnessPlaying(
      currentWave: currentWave ?? this.currentWave,
      score: score ?? this.score,
      planetHealth: planetHealth ?? this.planetHealth,
      combo: combo ?? this.combo,
    );
  }
}

class MeteorMadnessWaveComplete extends MeteorMadnessState {
  final int wave;
  final int baseScore;
  final int timeBonus;
  final int perfectBonus;
  final int totalScore;

  const MeteorMadnessWaveComplete({
    required this.wave,
    required this.baseScore,
    required this.timeBonus,
    required this.perfectBonus,
    required this.totalScore,
  });

  @override
  List<Object?> get props => [
    wave,
    baseScore,
    timeBonus,
    perfectBonus,
    totalScore,
  ];
}

class MeteorMadnessPaused extends MeteorMadnessState {
  final MeteorMadnessPlaying gameState;

  const MeteorMadnessPaused({required this.gameState});

  @override
  List<Object?> get props => [gameState];
}

class MeteorMadnessGameOver extends MeteorMadnessState {
  final int finalScore;
  final int waveReached;
  final int meteorsDestroyed;
  final double accuracy;

  const MeteorMadnessGameOver({
    required this.finalScore,
    required this.waveReached,
    required this.meteorsDestroyed,
    required this.accuracy,
  });

  @override
  List<Object?> get props => [
    finalScore,
    waveReached,
    meteorsDestroyed,
    accuracy,
  ];
}

class MeteorMadnessBossIntro extends MeteorMadnessState {
  final int bossNumber;
  final String bossName;
  final int bossHealth;

  const MeteorMadnessBossIntro({
    required this.bossNumber,
    required this.bossName,
    required this.bossHealth,
  });

  @override
  List<Object?> get props => [bossNumber, bossName, bossHealth];
}
