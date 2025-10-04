import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/core/router/routes.dart';
import '../cubit/impact_calculator_cubit.dart';
import '../cubit/impact_calculator_state.dart';
import '../widgets/animated_starfield.dart';
import '../widgets/impact_visualization.dart';
import '../widgets/input_panel.dart';
import '../widgets/severity_badge.dart';
import '../widgets/stats_display.dart';
import '../widgets/tsunami_warning.dart';

class AsteroidImpactPage extends StatelessWidget {
  const AsteroidImpactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            tooltip: 'NASA Eyes on Asteroids',
            onPressed: () {
              Navigator.pushNamed(context, Routes.nasaEyes);
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Animated starfield background
            const Positioned.fill(child: AnimatedStarfield()),

            // Main content
            SafeArea(
              child: BlocBuilder<ImpactCalculatorCubit, ImpactCalculatorState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildHeader(context, state),
                        const SizedBox(height: 32),
                        _buildContent(context, state),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ImpactCalculatorState state) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.purple400,
              Colors.pink.shade400,
              AppColors.blue400,
            ],
          ).createShader(bounds),
          child: const Text(
            'NASA ASTEROID IMPACT',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'PLANETARY DEFENSE SYSTEM',
          style: TextStyle(
            color: AppColors.purple300,
            fontSize: 16,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.radio_button_checked,
              color: AppColors.green400,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'SYSTEM ONLINE',
              style: TextStyle(
                color: AppColors.green400,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ImpactCalculatorState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return _buildDesktopLayout(context, state);
        } else {
          return _buildMobileLayout(context, state);
        }
      },
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ImpactCalculatorState state,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: InputPanel(
            onParametersChanged: (parameters) {
              context.read<ImpactCalculatorCubit>().updateParameters(
                parameters,
              );
            },
            onLaunchImpact: () {
              context.read<ImpactCalculatorCubit>().launchImpact();
            },
            isCalculating: state is ImpactCalculatorCalculating,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: _buildVisualizationPanel(context, state)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, ImpactCalculatorState state) {
    return Column(
      children: [
        InputPanel(
          onParametersChanged: (parameters) {
            context.read<ImpactCalculatorCubit>().updateParameters(parameters);
          },
          onLaunchImpact: () {
            context.read<ImpactCalculatorCubit>().launchImpact();
          },
          isCalculating: state is ImpactCalculatorCalculating,
        ),
        const SizedBox(height: 24),
        _buildVisualizationPanel(context, state),
      ],
    );
  }

  Widget _buildVisualizationPanel(
    BuildContext context,
    ImpactCalculatorState state,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blue900.withValues(alpha: 0.4),
            AppColors.purple900.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.blue500.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVisualizationHeader(state),
                const SizedBox(height: 16),
                _buildVisualization(state),
                const SizedBox(height: 16),
                _buildResults(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisualizationHeader(ImpactCalculatorState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.gps_fixed, color: AppColors.blue200, size: 24),
            const SizedBox(width: 8),
            Text(
              'IMPACT ZONE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.blue200,
              ),
            ),
          ],
        ),
        if (state is ImpactCalculatorSuccess)
          SeverityBadge(level: state.result.severityLevel),
      ],
    );
  }

  Widget _buildVisualization(ImpactCalculatorState state) {
    if (state is ImpactCalculatorCalculating) {
      return ImpactVisualization(
        impactPosition: state.impactPosition,
        isCalculating: true,
      );
    } else if (state is ImpactCalculatorSuccess) {
      return ImpactVisualization(
        impactPosition: state.impactPosition,
        result: state.result,
        showExplosion: true,
      );
    } else if (state is ImpactCalculatorPreview) {
      return ImpactVisualization(result: state.result);
    }

    return const ImpactVisualization();
  }

  Widget _buildResults(ImpactCalculatorState state) {
    if (state is ImpactCalculatorSuccess) {
      return Column(
        children: [
          if (state.result.showTsunami) ...[
            const TsunamiWarning(),
            const SizedBox(height: 16),
          ],
          StatsDisplay(result: state.result),
        ],
      );
    } else if (state is ImpactCalculatorPreview) {
      return StatsDisplay(result: state.result, isPreview: true);
    }

    return const SizedBox.shrink();
  }
}
