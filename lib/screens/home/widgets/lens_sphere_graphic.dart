import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum LensTypeStyle {
  singleVision,
  bifocal,
  progressive,
  rx,
  blueCut,
}

class LensSphereGraphic extends StatelessWidget {
  final LensTypeStyle style;
  final double size;
  final String? badgeText;

  const LensSphereGraphic({
    super.key,
    required this.style,
    this.size = 64,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    Color centerColor;
    Color glowColor;

    switch (style) {
      case LensTypeStyle.singleVision:
        baseColor = const Color(0xFFE2E8F0);
        centerColor = const Color(0xFFF8FAFC);
        glowColor = const Color(0xFF60A5FA).withValues(alpha: 0.2);
        break;
      case LensTypeStyle.bifocal:
        baseColor = const Color(0xFFC084FC);
        centerColor = const Color(0xFFF3E8FF);
        glowColor = const Color(0xFFA855F7).withValues(alpha: 0.25);
        break;
      case LensTypeStyle.progressive:
        baseColor = const Color(0xFF5EEAD4);
        centerColor = const Color(0xFFCCFBF1);
        glowColor = const Color(0xFF14B8A6).withValues(alpha: 0.25);
        break;
      case LensTypeStyle.rx:
        baseColor = const Color(0xFFA855F7);
        centerColor = const Color(0xFFF3E8FF);
        glowColor = const Color(0xFF9333EA).withValues(alpha: 0.25);
        break;
      case LensTypeStyle.blueCut:
        baseColor = const Color(0xFF60A5FA);
        centerColor = const Color(0xFFDBEAFE);
        glowColor = const Color(0xFF3B82F6).withValues(alpha: 0.35);
        break;
    }

    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer subtle aura
          Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: glowColor,
            ),
          ),

          // Main 3D Spherical Lens
          Container(
            width: size.w * 0.88,
            height: size.w * 0.88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.4),
                radius: 0.9,
                colors: [
                  Colors.white.withValues(alpha: 0.95),
                  centerColor,
                  baseColor,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: baseColor.withValues(alpha: 0.3),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Glass reflection highlight
                Positioned(
                  top: size.w * 0.12,
                  left: size.w * 0.18,
                  child: Container(
                    width: size.w * 0.38,
                    height: size.w * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(size.w * 0.38, size.w * 0.2),
                      ),
                    ),
                  ),
                ),

                // Special lens overlays (e.g., RX crosshair or Progressive corridor)
                if (style == LensTypeStyle.rx)
                  Center(
                    child: CustomPaint(
                      size: Size(size.w * 0.5, size.w * 0.5),
                      painter: _RxCrosshairPainter(color: baseColor),
                    ),
                  ),

                if (style == LensTypeStyle.progressive)
                  Center(
                    child: CustomPaint(
                      size: Size(size.w * 0.5, size.w * 0.5),
                      painter: _ProgressiveCorridorPainter(color: baseColor),
                    ),
                  ),

                if (style == LensTypeStyle.bifocal)
                  Positioned(
                    bottom: size.w * 0.08,
                    left: size.w * 0.2,
                    right: size.w * 0.2,
                    child: Container(
                      height: size.w * 0.28,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(size.w * 0.2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Pill badge if provided (e.g. "BLUE CUT", "PROGRESSIVE")
          if (badgeText != null)
            Positioned(
              bottom: 2.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  badgeText!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 7.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2563EB),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RxCrosshairPainter extends CustomPainter {
  final Color color;
  _RxCrosshairPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width * 0.35, paint);
    canvas.drawCircle(center, size.width * 0.18, paint);
    canvas.drawLine(
      Offset(0, center.dy),
      Offset(size.width, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProgressiveCorridorPainter extends CustomPainter {
  final Color color;
  _ProgressiveCorridorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(center.dx, center.dy - 6), 3, paint);
    // corridor lines
    canvas.drawLine(
      Offset(center.dx, center.dy - 2),
      Offset(center.dx, center.dy + 8),
      paint,
    );
    canvas.drawCircle(Offset(center.dx, center.dy + 12), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
