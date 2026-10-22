import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/Account_Profile_Screen/MahalaxmiOpticsScreen.dart';

class MySubCostomersScreen extends StatefulWidget {
  const MySubCostomersScreen({super.key});

  @override
  State<MySubCostomersScreen> createState() => _MySubCostomersScreenState();
}

class _MySubCostomersScreenState extends State<MySubCostomersScreen> {
  // 3 Sub-customers matching the design
  final List<SubCustomerItem> _customers = const [
    SubCustomerItem(
      name: 'Mahalaxmi Optics',
      location: 'Kothrud, Pune',
      badges: [SubCustomerBadge.canOrder, SubCustomerBadge.priceHidden],
    ),
    SubCustomerItem(
      name: 'Vision Point',
      location: 'Hadapsar, Pune',
      badges: [SubCustomerBadge.cartOnly],
    ),
    SubCustomerItem(
      name: 'Clear Eyes',
      location: 'Wakad, Pune',
      badges: [SubCustomerBadge.canOrder, SubCustomerBadge.seesStock],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        // backgroundColor: const Color(0xFFF6F8FC),
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // 1. Top Header Bar
              _buildTopHeader(),

              // 2. Scrollable Body Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Description Text
                      Text(
                        'Shops that order through you. Their orders come to you, and you decide what they can see.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF475569),
                          height: 1.35,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // List of Sub-Customers using ListView.builder
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _customers.length,
                        itemBuilder: (context, index) {
                          final customer = _customers[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MahalaxmiOpticsScreen(),
                                  ),
                                );
                              },
                              child: _buildCustomerCard(customer),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 14.h),

                      // Info Notice Banner
                      _buildInfoBanner(),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bottom Navigation Bar with White Background
        bottomNavigationBar: _buildBottomButton(),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                child: InkWell(
                  onTap: () => Navigator.maybePop(context),
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.cardBorder,
                        width: 1.w,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 24.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              // Title "My sub-customers"
              Text(
                'My sub-customers',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(6.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Text(
                  'Help',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0284C7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(SubCustomerItem customer) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cardBorder, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Store Icon Box
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.storefront_outlined,
                  size: 21.sp,
                  color: const Color(0xFF334155),
                ),
              ),

              SizedBox(width: 12.w),

              // Name & Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      customer.location,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Arrow Chevron
              Icon(
                Icons.chevron_right_rounded,
                size: 20.sp,
                color: const Color(0xFF94A3B8),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Badges Row
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: customer.badges.map((b) => _buildBadge(b)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(SubCustomerBadge badge) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.5.h),
      decoration: BoxDecoration(
        color: badge.bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: badge.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            badge.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: badge.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F3FD),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD6E9FB), width: 0.8.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(
              Icons.info_outline_rounded,
              size: 19.sp,
              color: const Color(0xFF0284C7),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'New sub-customers are added by our team after a quick check. Tap "Request" and share their details.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1E3A8A),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SizedBox(
            width: double.infinity,
            height: 48.h,
            child: Material(
              color: AppColors.buttonLightBg,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.cardBorder, width: 1.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Request a new sub-customer',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.buttonLightText,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubCustomerBadge {
  final String label;
  final Color bgColor;
  final Color dotColor;
  final Color textColor;

  const SubCustomerBadge({
    required this.label,
    required this.bgColor,
    required this.dotColor,
    required this.textColor,
  });

  static const canOrder = SubCustomerBadge(
    label: 'Can order',
    bgColor: AppColors.badgeGreenBg,
    dotColor: AppColors.badgeGreenDot,
    textColor: AppColors.badgeGreenText,
  );

  static const priceHidden = SubCustomerBadge(
    label: 'Price hidden',
    bgColor: Color(0xFFF1F5F9),
    dotColor: Color(0xFF475569),
    textColor: Color(0xFF334155),
  );

  static const cartOnly = SubCustomerBadge(
    label: 'Cart only',
    bgColor: AppColors.badgeYellowBg,
    dotColor: AppColors.badgeYellowDot,
    textColor: AppColors.badgeYellowText,
  );

  static const seesStock = SubCustomerBadge(
    label: 'Sees stock',
    bgColor: AppColors.badgeBlueBg,
    dotColor: AppColors.badgeBlueDot,
    textColor: AppColors.badgeBlueText,
  );
}

class SubCustomerItem {
  final String name;
  final String location;
  final List<SubCustomerBadge> badges;

  const SubCustomerItem({
    required this.name,
    required this.location,
    required this.badges,
  });
}
