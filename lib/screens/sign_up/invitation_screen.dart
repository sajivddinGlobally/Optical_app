import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/sign_up/signup_screen.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldLight,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Invitation Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.inviteCardBg,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 22.h,
                        ),
                        child: Column(
                          children: [
                            // Dark Circle with Link Icon
                            Container(
                              width: 56.w,
                              height: 56.w,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryDark,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle:
                                    -0.785, // 45 degree tilt for realistic link icon
                                child: Icon(
                                  Icons.link_rounded,
                                  size: 27.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(height: 14.h),

                            // Invitation Title
                            Text(
                              'You are invited to order from\nVishal Optical Co.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 17.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.35,
                                letterSpacing: -0.2,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            // Salesperson info
                            Text(
                              'Invited by Amit Verma (Salesperson)',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),

                            SizedBox(height: 14.h),

                            // Badges Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Valid for 44 hours badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.badgeYellowBg,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 5.w,
                                        height: 5.w,
                                        decoration: const BoxDecoration(
                                          color: AppColors.badgeYellowDot,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Valid for 44 hours',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.badgeYellowText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8.w),

                                // One-time link badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.badgeGrayBg,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 5.w,
                                        height: 5.w,
                                        decoration: const BoxDecoration(
                                          color: AppColors.badgeGrayDot,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'One-time link',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.badgeGrayText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 18.h),

                      // Section Title
                      Text(
                        'Keep these ready (about 5 minutes)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Multi-step Details Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.cardBorder,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildStepRow(
                              stepNumber: '1',
                              title: 'Your details',
                              subtitle:
                                  'Name, contact person, mobile, WhatsApp, email',
                            ),
                            Divider(
                              height: 1.h,
                              thickness: 1.h,
                              color: AppColors.dividerColor,
                            ),
                            _buildStepRow(
                              stepNumber: '2',
                              title: 'Shop details',
                              subtitle:
                                  'Company name, state, city, address, pin code',
                            ),
                            Divider(
                              height: 1.h,
                              thickness: 1.h,
                              color: AppColors.dividerColor,
                            ),
                            _buildStepRow(
                              stepNumber: '3',
                              title: 'Documents',
                              subtitle:
                                  'PAN, Aadhaar and visiting card photos (max 200 KB)',
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Green Security Banner
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.securityBannerBg,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 11.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Icon(
                                Icons.verified_user_outlined,
                                size: 18.sp,
                                color: AppColors.securityIcon,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Your shop is linked to your salesperson automatically. Your documents are stored securely in India and used only to verify your account.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.securityText,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),

              // Bottom Fixed Button
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 14.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Start registration',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow({
    required String stepNumber,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number badge
          Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
              color: AppColors.numberBadgeBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              stepNumber,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
