import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';
import 'package:neo_guard/features/education/presentation/widgets/videos_tab.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text('Education Videos',
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
              child: VideosTab(),
            ),
          ],
        ),
      ),
    );
  }
}
