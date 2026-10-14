import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/optical_logo.dart';
import 'package:optical_app/screens/sign_in/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _progressAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward().then((_) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Logo & Branding Area
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Outer subtle glowing circle
                    Container(
                      width: 126.w,
                      height: 126.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkCard,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 90.w,
                        height: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 16.r,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: OpticalLogoWidget(
                          width: 44.w,
                          height: 24.w,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // App Title
                    Text(
                      'Vishal Optical Co.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle / Tagline
                    Text(
                      'Lenses ordered right, every time',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLightMuted,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Bottom Progress Bar & Version
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress indicator bar
                  Container(
                    width: 104.w,
                    height: 3.5.h,
                    decoration: BoxDecoration(
                      color: AppColors.progressTrack,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 104.w * _progressAnimation.value,
                          height: 3.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Version text
                  Text(
                    'Version 1.0',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 0.1,
                    ),
                  ),

                  SizedBox(height: 18.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
