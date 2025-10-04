import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:neo_guard/core/theme/app_colors.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        VideoCard(
          assetPath: 'assets/videos/WhatsApp Video 2025-10-02 at 17.14.38_3c9cce0c.mp4',
          title: 'Asteroid Impact Simulation',
          description: 'A simulation of a large asteroid hitting Earth.',
        ),
        VideoCard(
          assetPath: 'assets/videos/WhatsApp Video 2025-10-02 at 17.16.25_7bcfb972.mp4',
          title: 'How We Find Near-Earth Asteroids',
          description: 'Learn about the methods used to detect and track NEOs.',
        ),
        VideoCard(
          assetPath: 'assets/videos/WhatsApp Video 2025-10-02 at 17.17.30_dc9e2e62.mp4',
          title: 'Planetary Defense: The DART Mission',
          description: 'An overview of NASA\'s successful DART mission.',
        ),
      ],
    );
  }
}

class VideoCard extends StatefulWidget {
  final String assetPath;
  final String title;
  final String description;

  const VideoCard({
    super.key,
    required this.assetPath,
    required this.title,
    required this.description,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        setState(() {}); // Refresh UI when video is ready
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: VideoPlayer(_controller),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 60,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
              ],
            ),
          )
              : Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              widget.description,
              style: TextStyle(color: AppColors.purple200, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
