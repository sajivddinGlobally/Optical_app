import 'package:flutter/material.dart';

class OpticalLogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const OpticalLogoWidget({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: OpticalLogoPainter(color: color),
    );
  }
}

class OpticalLogoPainter extends CustomPainter {
  final Color color;

  const OpticalLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.height * 0.22;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final double centerY = size.height / 2;
    final double radius = (size.height - strokeWidth) / 2;

    final double leftCenterX = radius + strokeWidth / 2;
    final double rightCenterX = size.width - radius - strokeWidth / 2;

    // Draw left circular lens
    canvas.drawCircle(Offset(leftCenterX, centerY), radius, paint);

    // Draw right circular lens
    canvas.drawCircle(Offset(rightCenterX, centerY), radius, paint);

    // Draw nose bridge connecting both lenses
    final bridgePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.95
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawLine(
      Offset(leftCenterX + radius, centerY),
      Offset(rightCenterX - radius, centerY),
      bridgePaint,
    );
  }

  @override
  bool shouldRepaint(covariant OpticalLogoPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
