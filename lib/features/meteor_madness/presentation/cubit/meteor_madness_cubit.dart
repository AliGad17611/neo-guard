import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'meteor_madness_state.dart';

@injectable
class MeteorMadnessCubit extends Cubit<MeteorMadnessState> {
  MeteorMadnessCubit() : super(MeteorMadnessInitial());

  void startGame() {
    emit(
      const MeteorMadnessPlaying(
        currentWave: 1,
        score: 0,
        planetHealth: 100,
        combo: 0,
      ),
    );
  }

  void updateGameState({
    int? currentWave,
    int? score,
    int? planetHealth,
    int? combo,
  }) {
    if (state is MeteorMadnessPlaying) {
      final currentState = state as MeteorMadnessPlaying;
      emit(
        currentState.copyWith(
          currentWave: currentWave,
          score: score,
          planetHealth: planetHealth,
          combo: combo,
        ),
      );
    }
  }

  void completeWave(int wave, int baseScore, int timeBonus, int perfectBonus) {
    final totalScore = baseScore + timeBonus + perfectBonus;
    emit(
      MeteorMadnessWaveComplete(
        wave: wave,
        baseScore: baseScore,
        timeBonus: timeBonus,
        perfectBonus: perfectBonus,
        totalScore: totalScore,
      ),
    );
  }

  void pauseGame() {
    if (state is MeteorMadnessPlaying) {
      emit(MeteorMadnessPaused(gameState: state as MeteorMadnessPlaying));
    }
  }

  void resumeGame() {
    if (state is MeteorMadnessPaused) {
      emit((state as MeteorMadnessPaused).gameState);
    }
  }

  void gameOver(
    int finalScore,
    int waveReached,
    int meteorsDestroyed,
    double accuracy,
  ) {
    emit(
      MeteorMadnessGameOver(
        finalScore: finalScore,
        waveReached: waveReached,
        meteorsDestroyed: meteorsDestroyed,
        accuracy: accuracy,
      ),
    );
  }

  void showBossIntro(int bossNumber, String bossName, int bossHealth) {
    emit(
      MeteorMadnessBossIntro(
        bossNumber: bossNumber,
        bossName: bossName,
        bossHealth: bossHealth,
      ),
    );
  }

  void nextWave() {
    if (state is MeteorMadnessWaveComplete) {
      final completeState = state as MeteorMadnessWaveComplete;
      emit(
        MeteorMadnessPlaying(
          currentWave: completeState.wave + 1,
          score: completeState.totalScore,
          planetHealth: 100,
          combo: 0,
        ),
      );
    }
  }

  void resetGame() {
    emit(MeteorMadnessInitial());
  }
}
