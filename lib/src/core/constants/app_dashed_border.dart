import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  const DashedBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashedBorderPainter(), child: child);
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const radius = 16.0;
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(radius),
    );

    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()..addRRect(rect);

    final metrics = path.computeMetrics().first;

    double distance = 0;
    while (distance < metrics.length) {
      final length = dashWidth;
      canvas.drawPath(metrics.extractPath(distance, distance + length), paint);
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
