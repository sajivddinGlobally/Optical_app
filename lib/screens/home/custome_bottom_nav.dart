
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/home_screen.dart';

class CustomeBottomNavBar extends StatefulWidget {
  const CustomeBottomNavBar({super.key});

  @override
  State<CustomeBottomNavBar> createState() => _CustomeBottomNavBarState();
}

class _CustomeBottomNavBarState extends State<CustomeBottomNavBar> {
  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: const Color(0xFFF1F5F9), width: 1.w),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
              _buildNavItem(
                index: 1,
                icon: Icons.search_rounded,
                label: 'Find Lens',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.shopping_cart_outlined,
                label: 'Cart',
                badgeCount: 2,
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.receipt_long_outlined,
                label: 'Orders',
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline_rounded,
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    int? badgeCount,
  }) {
    final isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with optional badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                if (isSelected)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      icon,
                      size: 20.sp,
                      color: AppColors.primaryDark,
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 3.h,
                    ),
                    child: Icon(
                      icon,
                      size: 20.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),

                if (badgeCount != null)
                  Positioned(
                    top: -1,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14.w,
                        minHeight: 14.w,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$badgeCount',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 3.h),

            // Label
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.5.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primaryDark
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
