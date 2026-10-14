import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/optical_logo.dart';
import 'package:optical_app/screens/home/widgets/lens_sphere_graphic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          bottom: false,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38.w,
                                height: 38.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: const OpticalLogoWidget(
                                  width: 22,
                                  height: 12,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vishal Optical Co.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    'Lens ordering',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Notification Bell Icon with Red Dot
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.w,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_none_rounded,
                                  size: 20.sp,
                                  color: const Color(0xFF1E293B),
                                ),
                                Positioned(
                                  top: 7.h,
                                  right: 8.w,
                                  child: Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFEF4444),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // ---------------------------------------------------------------------------
                      // Greeting (Namaste, Shree Optical)
                      // ---------------------------------------------------------------------------
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Namaste, Shree Optical',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 19.5.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Pune · Customer ID VOC-1042',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row with "Available credit" and "Pay in 1 month" pill
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Available credit',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2B364C),
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Text(
                                    'Pay in 1 month',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 6.h),

                            // Available balance
                            Text(
                              '₹ 18,450',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            // Progress indicator bar
                            Container(
                              width: double.infinity,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF384459),
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 0.58,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            // Outstanding and Limit
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Outstanding ₹ 31,550',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFCBD5E1),
                                  ),
                                ),
                                Text(
                                  'Limit ₹ 50,000',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFCBD5E1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2F7),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            // Lens 3D image graphic
                            Container(
                              width: 58.w,
                              height: 58.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              alignment: Alignment.center,
                              child: const LensSphereGraphic(
                                style: LensTypeStyle.blueCut,
                                size: 48,
                                badgeText: 'BLUE CUT',
                              ),
                            ),

                            SizedBox(width: 14.w),

                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // New stock tag
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 4.5.w,
                                        height: 4.5.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1E293B),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'New stock',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF334155),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 3.h),

                                  // Title
                                  Text(
                                    'AirSmart 1.61 Blue Cut is back in all powers',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                      height: 1.3,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  // View lenses link
                                  Text(
                                    'View lenses ›',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      findLensCard(),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order by lens type',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Browse all',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildLensCard(
                              title: 'Single Vision',
                              subtitle: 'SPH + CYL',
                              lensStyle: LensTypeStyle.singleVision,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildLensCard(
                              title: 'KT (Bifocal)',
                              subtitle: 'SPH, CYL, AXIS, ADD',
                              lensStyle: LensTypeStyle.bifocal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildLensCard(
                              title: 'Progressive',
                              subtitle: 'SPH, CYL, AXIS, ADD',
                              lensStyle: LensTypeStyle.progressive,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildLensCard(
                              title: 'RX',
                              subtitle: 'Made to order · ~1 day',
                              lensStyle: LensTypeStyle.rx,
                              isRxCard: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular with you',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'See all',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildProductCard(
                              title: 'AirSmart 1.61 B.CUT SV',
                              price: '₹ 129',
                              lensStyle: LensTypeStyle.blueCut,
                              badgeText: 'BLUE CUT',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildProductCard(
                              title: 'VeriWide 1.56 B.CUT PG',
                              price: '₹ 350',
                              lensStyle: LensTypeStyle.progressive,
                              badgeText: 'PROGRESSIVE',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent orders',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'See all',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      // Orders Card List
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.w,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        child: Column(
                          children: [
                            _buildOrderRow(
                              orderId: '#VO-24581',
                              subtitle: '4 items · Delhivery',
                              badgeText: 'Dispatched',
                              badgeBg: const Color(0xFFE0F2FE),
                              dotColor: const Color(0xFF0284C7),
                              textColor: const Color(0xFF0369A1),
                            ),
                            Divider(
                              height: 1.h,
                              thickness: 1.h,
                              color: const Color(0xFFF1F5F9),
                            ),
                            _buildOrderRow(
                              orderId: '#VO-24577',
                              subtitle: '8 of 10 pairs available',
                              badgeText: 'Needs your OK',
                              badgeBg: const Color(0xFFFEF3C7),
                              dotColor: const Color(0xFFD97706),
                              textColor: const Color(0xFFB45309),
                            ),
                            Divider(
                              height: 1.h,
                              thickness: 1.h,
                              color: const Color(0xFFF1F5F9),
                            ),
                            _buildOrderRow(
                              orderId: '#VO-24560',
                              subtitle: 'Awaiting new stock',
                              badgeText: 'Awaiting stock',
                              badgeBg: const Color(0xFFF1F5F9),
                              dotColor: const Color(0xFF64748B),
                              textColor: const Color(0xFF475569),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget findLensCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
      ),
      padding: EdgeInsets.all(14.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Lens Icon Box
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.search_rounded,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),

              SizedBox(width: 12.w),

              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find My Lens',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Enter the power — we show every matching lens with your price.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Enter power button
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Enter power',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLensCard({
    required String title,
    required String subtitle,
    required LensTypeStyle lensStyle,
    bool isRxCard = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isRxCard ? const Color(0xFFFAF5FF) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isRxCard ? const Color(0xFFA855F7) : const Color(0xFFE2E8F0),
          width: isRxCard ? 1.5.w : 1.w,
        ),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lens Preview Graphic Container
          Container(
            width: double.infinity,
            height: 72.h,
            decoration: BoxDecoration(
              color: isRxCard
                  ? const Color(0xFFF3E8FF)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: LensSphereGraphic(style: lensStyle, size: 54),
          ),

          SizedBox(height: 10.h),

          // Title
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 2.h),

          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5.sp,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String price,
    required LensTypeStyle lensStyle,
    required String badgeText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lens Preview Box
          Container(
            width: double.infinity,
            height: 90.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: LensSphereGraphic(
              style: lensStyle,
              size: 60,
              badgeText: badgeText,
            ),
          ),

          SizedBox(height: 10.h),

          // Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 4.h),

          // Price row
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$price ',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: '/ pair',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // In stock badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4.5.w,
                  height: 4.5.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16A34A),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'In stock',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderRow({
    required String orderId,
    required String subtitle,
    required String badgeText,
    required Color badgeBg,
    required Color dotColor,
    required Color textColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Order ID and Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4.5.w,
                  height: 4.5.w,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  badgeText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
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
