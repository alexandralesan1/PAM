import 'package:flutter/material.dart';
import '../../main.dart';

/// Inel subtire de progres, folosit in lista "Learning Plan".
class ProgressRing extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double size;

  const ProgressRing({super.key, required this.progress, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 5,
        backgroundColor: const Color(0xFFE9EBF5),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gray),
      ),
    );
  }
}
