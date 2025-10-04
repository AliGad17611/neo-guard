import 'package:flutter/material.dart';

class WebViewActions extends StatelessWidget {
  final VoidCallback onRefresh;

  const WebViewActions({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: onRefresh,
      tooltip: 'Refresh',
    );
  }
}
