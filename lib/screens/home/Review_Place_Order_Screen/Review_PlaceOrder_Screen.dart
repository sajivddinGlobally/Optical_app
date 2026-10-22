import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/Review_Place_Order_Screen/Order_Place_Screen.dart';
import 'package:optical_app/screens/home/widgets/lens_sphere_graphic.dart';

class ReviewPlaceorderScreen extends StatefulWidget {
  const ReviewPlaceorderScreen({super.key});

  @override
  State<ReviewPlaceorderScreen> createState() => _ReviewPlaceorderScreenState();
}

class _ReviewPlaceorderScreenState extends State<ReviewPlaceorderScreen> {
  // Delivery speed selection: 'normal' or 'urgent'
  String _selectedSpeed = 'normal';

  // Courier selection
  String _selectedCourier = 'Delhivery - Surface';
  final List<String> _courierOptions = [
    'Delhivery - Surface',
    'BlueDart Express',
    'DTDC Courier',
    'Local Pune Van Dispatch',
  ];

  // Reference text controller
  final TextEditingController _refController = TextEditingController(
    text: 'Job 4521 – Mr. Kulkarni',
  );

  // Address
  String _storeName = 'Shree Optical';
  String _address = '12, MG Road, Near City Mall, Pune 411001,\nMaharashtra';

  // Base pricing
  final double _itemsTotal = 1266.00;
  final double _gst = 63.30;
  double get _deliveryFee => _selectedSpeed == 'urgent' ? 100.00 : 0.00;
  double get _grandTotal => _itemsTotal + _gst + _deliveryFee;

  @override
  void dispose() {
    _refController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // BOTTOM SHEET POPUP: "Credit limit reached" (Exact Image Design)
  // ===========================================================================
  void _showCreditLimitReachedSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top drag handle
              Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              // Lock Icon inside light-pink circular badge
              Container(
                width: 58.w,
                height: 58.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE4E2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 26.sp,
                  color: const Color(0xFFDC2626),
                ),
              ),

              SizedBox(height: 16.h),

              // Title: Credit limit reached
              Text(
                'Credit limit reached',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'This order takes your total above your credit limit,\nso it cannot be placed right now.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
              ),

              SizedBox(height: 18.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.w,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Outstanding (old balance)',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          '₹ 31,550',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 9.h),

                    // This order
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'This order',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          '₹ 38,200',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: const Color(0xFFE2E8F0),
                    ),
                    SizedBox(height: 10.h),

                    // Total after order (Red highlight)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total after order',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          '₹ 69,750',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 9.h),

                    // Your credit limit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your credit limit',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          '₹ 50,000',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              // Primary Button: "Request higher limit"
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => OrderPlaceScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17212D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Request higher limit',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Secondary Button: "How to pay outstanding"
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Payment instructions sent to your registered mobile number',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color(0xFF17212D),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0F172A),
                    side: BorderSide(
                      color: const Color(0xFFE2E8F0),
                      width: 1.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'How to pay outstanding',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              // Helper footer text
              Text(
                'Your request goes to our accounts team. We will notify you as soon\nas it is approved — your cart stays saved.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                  height: 1.35,
                ),
              ),

              SizedBox(height: 4.h),
            ],
          ),
        );
      },
    );
  }

  void _showChangeAddressSheet() {
    final TextEditingController storeCtrl = TextEditingController(
      text: _storeName,
    );
    final TextEditingController addrCtrl = TextEditingController(
      text: _address,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
            top: 20.h,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Delivery Address',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: storeCtrl,
                decoration: InputDecoration(
                  labelText: 'Store / Recipient Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: addrCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _storeName = storeCtrl.text.trim();
                      _address = addrCtrl.text.trim();
                    });
                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17212D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Save Address',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
        backgroundColor: const Color(0xFFF4F6FA),
        body: SafeArea(
          child: Column(
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),

                      // 1. App Bar Row (Back button + Title)
                      _buildTopBar(),

                      SizedBox(height: 16.h),

                      // 2. Step 2 of 2 Progress Bar & Labels
                      _buildStepProgress(),

                      SizedBox(height: 16.h),

                      // 3. Deliver to Card
                      _buildDeliverToCard(),

                      SizedBox(height: 18.h),

                      // 4. Delivery speed Section
                      _buildDeliverySpeedSection(),

                      SizedBox(height: 18.h),

                      // 5. Courier / transport Section
                      _buildCourierSection(),

                      SizedBox(height: 16.h),

                      // 6. Your reference (optional) Section
                      _buildReferenceSection(),

                      SizedBox(height: 18.h),

                      // 7. Order Summary Card (with 3 lens graphics)
                      _buildOrderSummaryCard(),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Fixed Bottom CTA Bar ("Place order · ₹ 1,329")
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP BAR
  // ===========================================================================
  Widget _buildTopBar() {
    return Row(
      children: [
        // Rounded back button
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 24.sp,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Title
        Text(
          'Review & place order',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. STEP PROGRESS (Step 2 of 2)
  // ===========================================================================
  Widget _buildStepProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Two filled progress indicators
        Row(
          children: [
            Expanded(
              child: Container(
                height: 3.5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF17212D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Container(
                height: 3.5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF17212D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 2 of 2',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              'Review & place order',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. DELIVER TO CARD
  // ===========================================================================
  Widget _buildDeliverToCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with "Deliver to" and "Change"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deliver to',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              GestureDetector(
                onTap: _showChangeAddressSheet,
                child: Text(
                  'Change',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF17212D),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          // Store Name
          Text(
            _storeName,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 3.h),
          // Address
          Text(
            _address,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. DELIVERY SPEED SECTION
  // ===========================================================================
  Widget _buildDeliverySpeedSection() {
    final bool isNormal = _selectedSpeed == 'normal';
    final bool isUrgent = _selectedSpeed == 'urgent';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery speed',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 10.h),

        // Option 1: Normal delivery
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSpeed = 'normal';
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isNormal
                    ? const Color(0xFF17212D)
                    : const Color(0xFFE2E8F0),
                width: isNormal ? 1.5.w : 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                // Radio button
                _buildRadioButton(isSelected: isNormal),
                SizedBox(width: 10.w),

                // Truck Icon Box
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.local_shipping_outlined,
                    size: 19.sp,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(width: 10.w),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Normal delivery',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Delivered between 9 AM and 7 PM',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Price
                Text(
                  'Free',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10.h),

        // Option 2: Urgent delivery
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSpeed = 'urgent';
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isUrgent
                    ? const Color(0xFF17212D)
                    : const Color(0xFFE2E8F0),
                width: isUrgent ? 1.5.w : 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                // Radio button
                _buildRadioButton(isSelected: isUrgent),
                SizedBox(width: 10.w),

                // Bolt Icon Box
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.bolt_rounded,
                    size: 20.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                SizedBox(width: 10.w),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Urgent delivery',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'For late orders that are needed\ntoday',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),

                // Price
                Text(
                  '+ ₹ 100',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton({required bool isSelected}) {
    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFF17212D) : const Color(0xFF94A3B8),
          width: 1.8.w,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: 8.5.w,
              height: 8.5.w,
              decoration: const BoxDecoration(
                color: Color(0xFF17212D),
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }

  // ===========================================================================
  // 5. COURIER / TRANSPORT SECTION
  // ===========================================================================
  Widget _buildCourierSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Courier / transport',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCourier,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20.sp,
                color: const Color(0xFF64748B),
              ),
              items: _courierOptions.map((courier) {
                return DropdownMenuItem<String>(
                  value: courier,
                  child: Text(
                    courier,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedCourier = val;
                  });
                }
              },
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Your parcel is sent only through this company',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.sp,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. YOUR REFERENCE SECTION
  // ===========================================================================
  Widget _buildReferenceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your reference (optional)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _refController,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: 'e.g. Job 4521 – Mr. Kulkarni',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12.5.sp,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Shown on your bill so you can match it',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.sp,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 7. ORDER SUMMARY CARD (with 3 product thumbnails)
  // ===========================================================================
  Widget _buildOrderSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row of 3 product thumbnails matching image
          Row(
            children: [
              // 1. Green / Mint Lens (Progressive)
              _buildLensThumbnail(
                bgColor: const Color(0xFFE6F7F2),
                borderColor: const Color(0xFFBBEFDF),
                lensStyle: LensTypeStyle.progressive,
              ),
              SizedBox(width: 8.w),

              // 2. Grey / Silver Lens (Single Vision)
              _buildLensThumbnail(
                bgColor: const Color(0xFFF1F5F9),
                borderColor: const Color(0xFFE2E8F0),
                lensStyle: LensTypeStyle.singleVision,
              ),
              SizedBox(width: 8.w),

              // 3. Light Blue Lens (Blue Cut)
              _buildLensThumbnail(
                bgColor: const Color(0xFFEBF3FE),
                borderColor: const Color(0xFFCFE2FE),
                lensStyle: LensTypeStyle.blueCut,
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Row 1: 3 products · 15 pairs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 products · 15 pairs',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                '₹ ${_itemsTotal.toStringAsFixed(2)}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Row 2: GST (5%)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GST (5%)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                '₹ ${_gst.toStringAsFixed(2)}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Row 3: Delivery
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                _selectedSpeed == 'normal' ? 'Free' : '+ ₹ 100.00',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: _selectedSpeed == 'normal'
                      ? const Color(0xFF16A34A)
                      : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Divider(height: 1.h, thickness: 1.h, color: const Color(0xFFF1F5F9)),

          SizedBox(height: 12.h),

          // Row 4: Estimated total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated total',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              ),
              Text(
                '₹ ${_grandTotal.toStringAsFixed(2)}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLensThumbnail({
    required Color bgColor,
    required Color borderColor,
    required LensTypeStyle lensStyle,
  }) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(color: borderColor, width: 0.8),
      ),
      alignment: Alignment.center,
      child: LensSphereGraphic(style: lensStyle, size: 32),
    );
  }

  // ===========================================================================
  // 8. FIXED BOTTOM CTA BUTTON ("Place order · ₹ 1,329")
  // ===========================================================================
  Widget _buildBottomButton() {
    final int roundedTotal = _grandTotal.round();

    return Container(
      width: double.infinity,
      color: const Color(0xFFF4F6FA),
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 12.h),
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: _showCreditLimitReachedSheet,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF17212D),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Place order · ₹ $roundedTotal',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
