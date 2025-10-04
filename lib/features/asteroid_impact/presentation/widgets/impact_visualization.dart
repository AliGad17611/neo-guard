import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import '../../domain/entities/impact_result.dart';

class ImpactVisualization extends StatefulWidget {
  final Offset? impactPosition;
  final ImpactResult? result;
  final bool isCalculating;
  final bool showExplosion;

  const ImpactVisualization({
    super.key,
    this.impactPosition,
    this.result,
    this.isCalculating = false,
    this.showExplosion = false,
  });

  @override
  State<ImpactVisualization> createState() => _ImpactVisualizationState();
}

class _ImpactVisualizationState extends State<ImpactVisualization>
    with TickerProviderStateMixin {
  late AnimationController _radarController;
  late AnimationController _explosionController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _explosionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didUpdateWidget(ImpactVisualization oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showExplosion && !oldWidget.showExplosion) {
      _explosionController.forward(from: 0);
      if (widget.result?.showTsunami ?? false) {
        _waveController.repeat();
      }
    }
  }

  @override
  void dispose() {
    _radarController.dispose();
    _explosionController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blue950.withValues(alpha:0.5),
            AppColors.green950.withValues(alpha:0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.blue500.withValues(alpha:0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Grid background
            CustomPaint(
              size: Size.infinite,
              painter: GridPainter(),
            ),

            // Radar sweep
            AnimatedBuilder(
              animation: _radarController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: RadarPainter(
                    progress: _radarController.value,
                  ),
                );
              },
            ),

            // Falling asteroid
            if (widget.isCalculating && widget.impactPosition != null)
              FallingAsteroid(
                position: widget.impactPosition!,
              ),

            // Explosion effect
            if (widget.showExplosion &&
                widget.result != null &&
                widget.impactPosition != null)
              AnimatedBuilder(
                animation: _explosionController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: ExplosionPainter(
                      position: widget.impactPosition!,
                      progress: _explosionController.value,
                      damageRadius: widget.result!.damageRadius,
                    ),
                  );
                },
              ),

            // Tsunami waves
            if (widget.showExplosion && (widget.result?.showTsunami ?? false))
              AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: TsunamiPainter(
                      progress: _waveController.value,
                    ),
                  );
                },
              ),

            // Empty state
            if (!widget.isCalculating &&
                !widget.showExplosion &&
                widget.result == null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.public,
                      size: 80,
                      color: AppColors.blue300.withValues(alpha:0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AWAITING TARGET PARAMETERS',
                      style: TextStyle(
                        color: AppColors.blue300,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Configure asteroid data to initiate simulation',
                      style: TextStyle(
                        color: AppColors.blue300.withValues(alpha:0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Grid Painter
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blue500.withValues(alpha:0.2)
      ..strokeWidth = 2;

    const gridSize = 30.0;

    // Vertical lines
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => false;
}

// Radar Painter
class RadarPainter extends CustomPainter {
  final double progress;

  RadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.blue400.withValues(alpha:0.3),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ))
      ..strokeWidth = 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(progress * 2 * pi);
    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) => true;
}

// Falling Asteroid Widget
class FallingAsteroid extends StatefulWidget {
  final Offset position;

  const FallingAsteroid({
    super.key,
    required this.position,
  });

  @override
  State<FallingAsteroid> createState() => _FallingAsteroidState();
}

class _FallingAsteroidState extends State<FallingAsteroid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fallAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fallAnimation = Tween<double>(begin: -100, end: 400).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      _controller,
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.position.dx * MediaQuery.of(context).size.width,
          top: _fallAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.orange500,
                      AppColors.red500,
                      AppColors.purple600,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange500.withValues(alpha:0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Explosion Painter
class ExplosionPainter extends CustomPainter {
  final Offset position;
  final double progress;
  final double damageRadius;

  ExplosionPainter({
    required this.position,
    required this.progress,
    required this.damageRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      position.dx * size.width,
      position.dy * size.height,
    );

    // Draw shockwaves
    for (int i = 0; i < 4; i++) {
      final radius = min(damageRadius * (10 - i * 2) * progress, 200.0);
      final opacity = (1 - progress) * 0.6;

      final paint = Paint()
        ..color = (i % 2 == 0 ? AppColors.purple400 : AppColors.blue400)
            .withValues(alpha:opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawCircle(center, radius, paint);
    }

    // Draw core explosion
    final coreRadius = min(damageRadius * 3, 60.0);
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.yellow200,
          AppColors.orange500,
          AppColors.purple600,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));

    canvas.drawCircle(center, coreRadius, corePaint);

    // Draw particles
    // final random = Random(42);
    for (int i = 0; i < 20; i++) {
      final angle = (2 * pi * i) / 20;
      final distance = 150 * progress;
      final particlePos = Offset(
        center.dx + cos(angle) * distance,
        center.dy + sin(angle) * distance,
      );

      final particlePaint = Paint()
        ..color = AppColors.orange500.withValues(alpha:1 - progress)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particlePos, 3, particlePaint);
    }
  }

  @override
  bool shouldRepaint(ExplosionPainter oldDelegate) => true;
}

// Tsunami Painter
class TsunamiPainter extends CustomPainter {
  final double progress;

  TsunamiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 8; i++) {
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.blue500.withValues(alpha:0.4),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, 24));

      final yPos = size.height - (i * 12) - (progress * 50);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, yPos, size.width, 24),
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(TsunamiPainter oldDelegate) => true;
}