import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/custome_bottom_nav.dart';

class AccountReviewScreen extends StatelessWidget {
  const AccountReviewScreen({super.key});

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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Clock Icon Circle Badge
                      Container(
                        width: 66.w,
                        height: 66.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF3C7),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.access_time_rounded,
                          size: 32.sp,
                          color: const Color(0xFFB45309),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        'Your account is under review',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Description
                      Text(
                        'Our team is checking your details. You can place orders once your account is approved — usually within 1 working day.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Verification Timeline Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.w,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 18.h,
                        ),
                        child: Column(
                          children: [
                            // 1. Details submitted (Completed)
                            _buildTimelineItem(
                              icon: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF15803D),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  size: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                              title: 'Details submitted',
                              subtitle: 'Today, 11:42 AM',
                              isCompleted: true,
                              lineColor: const Color(0xFF15803D),
                            ),

                            // 2. Accounts team check (In Progress)
                            _buildTimelineItem(
                              icon: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFD97706),
                                    width: 2.w,
                                  ),
                                ),
                              ),
                              title: 'Accounts team check',
                              subtitle: 'KYC, price list and credit limit',
                              badge: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 4.5.w,
                                      height: 4.5.w,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD97706),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'In progress',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFB45309),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              lineColor: const Color(0xFFE2E8F0),
                            ),

                            // 3. Owner approval (Pending)
                            _buildTimelineItem(
                              icon: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 2.w,
                                  ),
                                ),
                              ),
                              title: 'Owner approval',
                              subtitle: 'Final approval',
                              isPending: true,
                              lineColor: const Color(0xFFE2E8F0),
                            ),

                            // 4. Account active (Pending)
                            _buildTimelineItem(
                              icon: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 2.w,
                                  ),
                                ),
                              ),
                              title: 'Account active',
                              subtitle: 'Start ordering',
                              isPending: true,
                              isLast: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Locked Notice Banner
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline_rounded,
                              size: 16.sp,
                              color: const Color(0xFF475569),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Ordering stays locked until approval',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Button: Call my salesperson
              Padding(
                padding: EdgeInsets.fromLTRB(18.w, 4.h, 18.w, 14.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CustomeBottomNavBar(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: BorderSide(
                        color: const Color(0xFFE2E8F0),
                        width: 1.5.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Call my salesperson',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
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

  Widget _buildTimelineItem({
    required Widget icon,
    required String title,
    required String subtitle,
    Widget? badge,
    bool isCompleted = false,
    bool isPending = false,
    bool isLast = false,
    Color lineColor = const Color(0xFFE2E8F0),
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and connecting vertical line
          Column(
            children: [
              icon,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: lineColor,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5.sp,
                          fontWeight: isPending
                              ? FontWeight.w600
                              : FontWeight.w700,
                          color: isPending
                              ? const Color(0xFF94A3B8)
                              : AppColors.textPrimary,
                        ),
                      ),
                      if (badge != null) badge,
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5.sp,
                      color: isPending
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
