import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/screens/home/custome_bottom_nav.dart';

class OrderPlaceScreen extends StatefulWidget {
  final String orderId;
  final int productCount;
  final int pairCount;
  final String courierName;

  const OrderPlaceScreen({
    super.key,
    this.orderId = '#VO-24592',
    this.productCount = 3,
    this.pairCount = 15,
    this.courierName = 'Delhivery',
  });

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onBackToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => CustomeBottomNavBar()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Main scrollable content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 28.h),

                        // Success checkmark badge with smooth pop animation
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 82.w,
                            height: 82.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD6F5E4),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check_rounded,
                              size: 42.sp,
                              color: const Color(0xFF16A34A),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Title: "Order placed!"
                        Text(
                          'Order placed!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                            letterSpacing: -0.4,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Subtitle: "Order #VO-24592 · 3 products · 15 pairs"
                        Text(
                          'Order ${widget.orderId} · ${widget.productCount} products · ${widget.pairCount} pairs',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF475569),
                            letterSpacing: -0.1,
                          ),
                        ),

                        SizedBox(height: 22.h),

                        // Product Thumbnails Row (3 Spheres)
                        _buildProductThumbnailsRow(),

                        SizedBox(height: 22.h),

                        // "What happens next" Card
                        _buildWhatHappensNextCard(),

                        SizedBox(height: 14.h),

                        // Informational Note Box (Light Blue Banner)
                        _buildInfoNoticeBanner(),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Action Buttons ("Back to home" & "Track order")
              _buildBottomActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. PRODUCT PREVIEW THUMBNAILS (3 Lens Spheres)
  // ===========================================================================
  Widget _buildProductThumbnailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Lens 1: Mint Green Progressive Lens
        _buildLensPreviewCard(
          bgColor: const Color(0xFFE3F7EB),
          borderColor: const Color(0xFFC4EED3),
          lensType: _OrderLensType.progressive,
          badgeLabel: 'PROGRESSIVE',
          badgeColor: const Color(0xFF059669),
        ),

        SizedBox(width: 12.w),

        // Lens 2: Slate/Clear Single Vision Lens
        _buildLensPreviewCard(
          bgColor: const Color(0xFFF1F5F9),
          borderColor: const Color(0xFFE2E8F0),
          lensType: _OrderLensType.singleVision,
          badgeLabel: 'SINGLE VISION',
          badgeColor: const Color(0xFF64748B),
        ),

        SizedBox(width: 12.w),

        // Lens 3: Sky Blue Cut Lens
        _buildLensPreviewCard(
          bgColor: const Color(0xFFEFF6FF),
          borderColor: const Color(0xFFDBEAFE),
          lensType: _OrderLensType.blueCut,
          badgeLabel: 'BLUE CUT',
          badgeColor: const Color(0xFF2563EB),
        ),
      ],
    );
  }

  Widget _buildLensPreviewCard({
    required Color bgColor,
    required Color borderColor,
    required _OrderLensType lensType,
    required String badgeLabel,
    required Color badgeColor,
  }) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 3D Spherical Graphic
          _build3DLensSphere(lensType),

          // Tiny pill label at bottom
          Positioned(
            bottom: 3.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                badgeLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 6.2.sp,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _build3DLensSphere(_OrderLensType type) {
    Color baseColor;
    Color centerColor;

    switch (type) {
      case _OrderLensType.progressive:
        baseColor = const Color(0xFF6EE7B7);
        centerColor = const Color(0xFFD1FAE5);
        break;
      case _OrderLensType.singleVision:
        baseColor = const Color(0xFFCBD5E1);
        centerColor = const Color(0xFFF8FAFC);
        break;
      case _OrderLensType.blueCut:
        baseColor = const Color(0xFF60A5FA);
        centerColor = const Color(0xFFDBEAFE);
        break;
    }

    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 0.85,
          colors: [
            Colors.white.withValues(alpha: 0.98),
            centerColor,
            baseColor,
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.35),
            blurRadius: 5.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Curved Glass Highlight Reflection
          Positioned(
            top: 4.h,
            left: 7.w,
            child: Container(
              width: 14.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.all(Radius.elliptical(14.w, 7.h)),
              ),
            ),
          ),

          // Progressive corridor markings
          if (type == _OrderLensType.progressive)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 2.w,
                    height: 2.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    width: 1.w,
                    height: 5.h,
                    color: const Color(0xFF059669).withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. "WHAT HAPPENS NEXT" CARD
  // ===========================================================================
  Widget _buildWhatHappensNextCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'What happens next',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
          ),

          SizedBox(height: 16.h),

          // Step 1: Stock confirmation
          _buildStepRow(
            icon: Icons.check_rounded,
            title: 'We check stock and confirm your order',
          ),

          SizedBox(height: 14.h),

          // Step 2: Picking and packing
          _buildStepRow(
            icon: Icons.inventory_2_outlined,
            title: 'Your lenses are picked and packed',
          ),

          SizedBox(height: 14.h),

          // Step 3: Courier dispatch
          _buildStepRow(
            icon: Icons.local_shipping_outlined,
            title:
                'Sent by ${widget.courierName} — you get the tracking number',
          ),

          SizedBox(height: 14.h),

          // Step 4: Final bill & freight
          _buildStepRow(
            icon: Icons.description_outlined,
            title: 'Final bill (with carton & freight) comes with dispatch',
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow({required IconData icon, required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Grey rounded icon tile
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 19.sp, color: const Color(0xFF334155)),
        ),

        SizedBox(width: 13.w),

        // Step text
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF334155),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. INFORMATIONAL NOTICE BANNER (Light Blue)
  // ===========================================================================
  Widget _buildInfoNoticeBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18.sp,
            color: const Color(0xFF0284C7),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'If any power is short we will ask you before sending a part order.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0369A1),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. BOTTOM ACTION BUTTONS ("Back to home" & "Track order")
  // ===========================================================================
  Widget _buildBottomActionButtons() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFF1F5F9), width: 1.w),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      child: Row(
        children: [
          // "Back to home" Button (Outlined)
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton(
                onPressed: _onBackToHome,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F172A),
                  elevation: 0,
                  side: BorderSide(
                    color: const Color(0xFFE2E8F0),
                    width: 1.2.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Back to home',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => const CustomeBottomNavBar(initialIndex: 3),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B2333),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Track order',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _OrderLensType { progressive, singleVision, blueCut }
