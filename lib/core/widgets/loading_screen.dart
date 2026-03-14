import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
