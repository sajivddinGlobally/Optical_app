import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';

class MahalaxmiOpticsScreen extends StatefulWidget {
  const MahalaxmiOpticsScreen({super.key});

  @override
  State<MahalaxmiOpticsScreen> createState() => _MahalaxmiOpticsScreenState();
}

class _MahalaxmiOpticsScreenState extends State<MahalaxmiOpticsScreen> {
  // Toggle switches states matching the image
  bool _addItemsToCart = true;
  bool _placeOrders = true;
  bool _seeLiveStock = false;
  bool _hideMyBuyingPrice = true;

  void _onSaveChanges() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Settings saved for Mahalaxmi Optics',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // 1. Top Header Bar
              _buildTopHeader(),

              // 2. Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      // Shop Name & Details Card
                      _buildShopInfoCard(),

                      SizedBox(height: 20.h),

                      // Section Title
                      Text(
                        'What can this shop do?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.1,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Card with 4 Switch Options
                      _buildPermissionsCard(),

                      SizedBox(height: 16.h),

                      // Info Text at bottom
                      _buildInfoNote(),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom "Save changes" Button
        bottomNavigationBar: _buildBottomSaveButton(),
      ),
    );
  }

  // --- TOP HEADER ---
  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          // Back Button Box
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
                  border: Border.all(color: AppColors.cardBorder, width: 1.w),
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

          // Title
          Text(
            'Mahalaxmi Optics',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  // --- SHOP INFO CARD ---
  Widget _buildShopInfoCard() {
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
          Text(
            'Mahalaxmi Optics',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Owner: Sunil Patil · Kothrud, Pune',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // --- PERMISSIONS / SWITCHES CARD ---
  Widget _buildPermissionsCard() {
    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          children: [
            // 1. Add items to cart
            _buildSwitchRow(
              title: 'Add items to cart',
              subtitle: 'They can pick lenses and save a cart',
              value: _addItemsToCart,
              onChanged: (val) {
                setState(() => _addItemsToCart = val);
              },
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

            // 2. Place orders
            _buildSwitchRow(
              title: 'Place orders',
              subtitle: 'Orders are billed to you and come in your list',
              value: _placeOrders,
              onChanged: (val) {
                setState(() => _placeOrders = val);
              },
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

            // 3. See live stock
            _buildSwitchRow(
              title: 'See live stock',
              subtitle: 'Shows how many pieces are in stock',
              value: _seeLiveStock,
              onChanged: (val) {
                setState(() => _seeLiveStock = val);
              },
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

            // 4. Hide my buying price
            _buildSwitchRow(
              title: 'Hide my buying price',
              subtitle: 'They will not see your rates',
              value: _hideMyBuyingPrice,
              onChanged: (val) {
                setState(() => _hideMyBuyingPrice = val);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Single Switch Row Helper
  Widget _buildSwitchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Custom styled CupertinoSwitch
          Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
              value: value,
              activeTrackColor: const Color(0xFF1E293B),
              inactiveTrackColor: const Color(0xFFE2E8F0),
              thumbColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            Icons.info_outline_rounded,
            size: 16.sp,
            color: const Color(0xFF64748B),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Changes apply right away. The shop sees the new settings the next time they open the app.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475569),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSaveButton() {
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
            child: ElevatedButton(
              onPressed: _onSaveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Save changes',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
