import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/widgets/lens_sphere_graphic.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ['Single Vision', 'KT', 'Progressive', 'RX'];
  final List<Map<String, dynamic>> lensList = [
    {
      "title": "AirSmart",
      "sub": "Index 1.56 · 1.61 · 1.67",
      "price": "95",
      "img": "assets/images/products/lens_airsmart.jpg",
    },
    {
      "title": "Blu Safe",
      "sub": "Index 1.56 · 1.61",
      "price": "110",
      "img": "assets/images/products/lens_blusafe.jpg",
    },
    {
      "title": "VeriWide",
      "sub": "Index 1.56 · 1.61 · 1.67",
      "price": "129",
      "img": "assets/images/products/lens_veriwide.jpg",
    },
    {
      "title": "Lords",
      "sub": "Index 1.56",
      "price": "98",
      "img": "assets/images/products/lens_photochromic.jpg",
    },
    {
      "title": "SLX",
      "sub": "Index 1.56 · 1.61",
      "price": "105",
      "img": "assets/images/products/lens_aerolite.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f6fa),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lens type",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Container(
                      height: 50.h,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FA),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: const Color(0xFFE0E7EF),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: List.generate(tabs.length, (index) {
                          final bool isSelected = selectedIndex == index;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              behavior: HitTestBehavior.opaque,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  tabs[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFF17212D)
                                        : const Color(0xFF40556F),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Base / material",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLensCard(
                            title: 'Single Vision',
                            subtitle: 'SPH + CYL',
                            lensStyle: LensTypeStyle.singleVision,
                            imagePath:
                                'assets/images/categories/cat_singlevision.jpg',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildLensCard(
                            title: 'KT (Bifocal)',
                            subtitle: 'SPH, CYL, AXIS, ADD',
                            lensStyle: LensTypeStyle.bifocal,
                            imagePath:
                                'assets/images/categories/cat_bifocal.jpg',
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
                            imagePath:
                                'assets/images/categories/cat_progressive.jpg',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildLensCard(
                            title: 'RX',
                            subtitle: 'Made to order · ~1 day',
                            lensStyle: LensTypeStyle.rx,
                            isRxCard: true,
                            imagePath: 'assets/images/categories/cat_rx.jpg',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Blue Cut · Single Vision",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "9 brands",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFE0E7EF),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lensList.length,
                        itemBuilder: (context, index) {
                          final item = lensList[index];
                          final bool isSelected = selectedIndex == index;

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 48.h,
                                        width: 48.w,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEBF4FF),
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          child: Image.asset(
                                            item["img"]!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Container(
                                              color: const Color(0xFFEBF4FF),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.visibility_outlined,
                                                color: AppColors.primaryDark,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 14.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["title"]!,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(
                                                      0xFF17212D,
                                                    ),
                                                  ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              item["sub"]!,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                      0xFF6B7280,
                                                    ),
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "from ₹ ${item["price"]}",
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF17212D),
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            "per pair",
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10.5.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF9CA3AF),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),

                                      // Arrow Icon
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 13,
                                        color: Color(0xFF9CA3AF),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Divider sirf tabhi aayega jab yeh aakhri item na ho
                              if (index != lensList.length - 1)
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFE0E7EF),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Browse lenses',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Search',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLensCard({
    required String title,
    required String subtitle,
    required LensTypeStyle lensStyle,
    bool isRxCard = false,
    String? imagePath,
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
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 72.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          LensSphereGraphic(style: lensStyle, size: 54),
                    ),
                  )
                : LensSphereGraphic(style: lensStyle, size: 54),
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

  Widget buildLensListItem({
    required String title,
    required String subtitle,
    required String price,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF17212D)
                : const Color(0xFFE0E7EF),
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Lens Image Box
            Container(
              height: 56.h,
              width: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFEBF4FF),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.visibility_outlined,
                      color: AppColors.primaryDark,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),

            // Middle Title & Index Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF17212D),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Right Price & Arrow Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "from ₹$price",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF17212D),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "per pair",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),

            // Arrow Icon
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}
