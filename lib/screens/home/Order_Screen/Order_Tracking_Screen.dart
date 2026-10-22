import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  final String reference;

  const OrderTrackingScreen({
    super.key,
    this.orderId = '#VO-24577',
    this.reference = 'Job 4498',
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  String? _selectedAction;

  void _handleAction(String action, String message) {
    setState(() {
      _selectedAction = action;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1B2333),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  void _showHelpBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 16.h),
              Text(
                'Need Help with this Order?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Our support team is available from 10 AM to 8 PM.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 18.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF1B2333),
                  ),
                ),
                title: Text(
                  'Call Dispatch Desk',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                subtitle: Text(
                  '+91 98220 12345',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F7EB),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Color(0xFF16A34A),
                  ),
                ),
                title: Text(
                  'WhatsApp Support',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                subtitle: Text(
                  'Get quick updates on WhatsApp',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 12.h),
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
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Top Navigation Header
              _buildTopHeader(),

              // Scrollable Body Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),

                      // Amber Alert / Action Banner ("Only 8 of 10 pairs available")
                      _buildAlertActionBanner(),

                      SizedBox(height: 20.h),

                      // "Order status" Section Heading
                      Text(
                        'Order status',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Order Status Timeline Stepper Card
                      _buildOrderStatusStepperCard(),

                      SizedBox(height: 16.h),

                      // "Items in this order" Card
                      _buildItemsInOrderCard(),

                      SizedBox(height: 14.h),

                      // Invoice Note at Bottom
                      _buildBottomInvoiceNote(),

                      SizedBox(height: 24.h),
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

  // ===========================================================================
  // 1. TOP HEADER ("< Order #VO-24577" & "Help")
  // ===========================================================================
  Widget _buildTopHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 14.w,
        right: 16.w,
        top: 10.h,
        bottom: 12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Back Button Container
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 22.sp,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Title: "Order #VO-24577"
              Text(
                'Order ${widget.orderId}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // Help Action Text
          GestureDetector(
            onTap: _showHelpBottomSheet,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Text(
                'Help',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. ALERT ACTION BANNER (Only 8 of 10 pairs available)
  // ===========================================================================
  Widget _buildAlertActionBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFCD34D),
          width: 1.2.w,
        ),
      ),
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20.sp,
                color: const Color(0xFFD97706),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Only 8 of 10 pairs available',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF78350F),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Subtitle / Description text
          Text(
            'LORDS 1.56 HC SV -6-2: 2 pairs are short. What should we do?',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF92400E),
              height: 1.35,
            ),
          ),

          SizedBox(height: 14.h),

          // Primary Button: "Send 8 now, rest when in stock"
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () {
                _handleAction(
                  'send8',
                  'Preference saved: Sending 8 pairs now, rest when in stock.',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedAction == 'send8'
                    ? const Color(0xFF0F766E)
                    : const Color(0xFF1B2333),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                _selectedAction == 'send8'
                    ? '✓ Preference recorded'
                    : 'Send 8 now, rest when in stock',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Secondary Action Buttons: "Wait for all 10" & "Cancel the 2"
          Row(
            children: [
              // Left: "Wait for all 10"
              Expanded(
                child: SizedBox(
                  height: 38.h,
                  child: OutlinedButton(
                    onPressed: () {
                      _handleAction(
                        'wait10',
                        'Preference saved: Holding order until all 10 pairs arrive.',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedAction == 'wait10'
                          ? const Color(0xFFFEF3C7)
                          : Colors.white,
                      foregroundColor: const Color(0xFF0F172A),
                      side: BorderSide(
                        color: _selectedAction == 'wait10'
                            ? const Color(0xFFD97706)
                            : const Color(0xFFE2E8F0),
                        width: 1.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Wait for all 10',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Right: "Cancel the 2"
              Expanded(
                child: SizedBox(
                  height: 38.h,
                  child: OutlinedButton(
                    onPressed: () {
                      _handleAction(
                        'cancel2',
                        'Preference saved: Cancelled 2 short pairs.',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedAction == 'cancel2'
                          ? const Color(0xFFFEE2E2)
                          : Colors.white,
                      foregroundColor: const Color(0xFF0F172A),
                      side: BorderSide(
                        color: _selectedAction == 'cancel2'
                            ? const Color(0xFFDC2626)
                            : const Color(0xFFE2E8F0),
                        width: 1.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Cancel the 2',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. ORDER STATUS TIMELINE STEPPER CARD
  // ===========================================================================
  Widget _buildOrderStatusStepperCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        children: [
          // Step 1: Order placed (Completed)
          _buildTimelineStep(
            indicator: _buildCompletedIndicator(),
            lineColor: const Color(0xFF16A34A),
            title: 'Order placed',
            subtitle: '5 Oct, 4:10 PM',
            isCompleted: true,
          ),

          // Step 2: Stock checked (Completed)
          _buildTimelineStep(
            indicator: _buildCompletedIndicator(),
            lineColor: const Color(0xFFD97706),
            title: 'Stock checked',
            subtitle: '5 Oct, 5:02 PM',
            isCompleted: true,
          ),

          // Step 3: Waiting for your answer (Active / Your turn)
          _buildTimelineStep(
            indicator: _buildActiveIndicator(),
            lineColor: const Color(0xFFE2E8F0),
            title: 'Waiting for your answer',
            subtitle: 'Partial stock — see above',
            trailingBadge: _buildYourTurnBadge(),
            isCompleted: false,
            isActive: true,
          ),

          // Step 4: Picking & packing (Pending)
          _buildTimelineStep(
            indicator: _buildPendingIndicator(),
            lineColor: const Color(0xFFE2E8F0),
            title: 'Picking & packing',
            subtitle: null,
            isCompleted: false,
          ),

          // Step 5: Dispatched (Pending)
          _buildTimelineStep(
            indicator: _buildPendingIndicator(),
            lineColor: const Color(0xFFE2E8F0),
            title: 'Dispatched',
            subtitle: 'Courier: Delhivery (Surface)',
            isCompleted: false,
          ),

          // Step 6: Delivered (Pending - Final)
          _buildTimelineStep(
            indicator: _buildPendingIndicator(),
            lineColor: Colors.transparent,
            title: 'Delivered',
            subtitle: null,
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required Widget indicator,
    required Color lineColor,
    required String title,
    required String? subtitle,
    Widget? trailingBadge,
    required bool isCompleted,
    bool isActive = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Indicator circle + connecting vertical line
          Column(
            children: [
              indicator,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: lineColor,
                  ),
                ),
            ],
          ),

          SizedBox(width: 14.w),

          // Right: Content details
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5.sp,
                          fontWeight: (isCompleted || isActive)
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: (isCompleted || isActive)
                              ? const Color(0xFF0F172A)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      if (trailingBadge != null) ...[
                        SizedBox(width: 8.w),
                        trailingBadge,
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedIndicator() {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: const BoxDecoration(
        color: Color(0xFF16A34A),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.check_rounded,
        size: 14.sp,
        color: Colors.white,
      ),
    );
  }

  Widget _buildActiveIndicator() {
    return Container(
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
    );
  }

  Widget _buildPendingIndicator() {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 2.w,
        ),
      ),
    );
  }

  Widget _buildYourTurnBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.5.h),
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
          SizedBox(width: 4.5.w),
          Text(
            'Your turn',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFB45309),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. "ITEMS IN THIS ORDER" CARD
  // ===========================================================================
  Widget _buildItemsInOrderCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: "Items in this order"
          Text(
            'Items in this order',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
          ),

          SizedBox(height: 14.h),

          // Item 1: LORDS 1.56 HC SV -6-2 (65MM)
          _buildItemRow(
            lensWidget: _buildLensThumbnail(
              bg: const Color(0xFFF1F5F9),
              border: const Color(0xFFE2E8F0),
              baseColor: const Color(0xFFCBD5E1),
              centerColor: const Color(0xFFF8FAFC),
            ),
            title: 'LORDS 1.56 HC SV -6-2 (65MM)',
            subtitle: '8 of 10 pairs',
            badgeBg: const Color(0xFFFEF3C7),
            badgeDot: const Color(0xFFD97706),
            badgeText: 'Short 2',
            badgeTextColor: const Color(0xFFB45309),
          ),

          SizedBox(height: 12.h),

          // Item 2: VeriWide 1.56 B.CUT PG (65MM)
          _buildItemRow(
            lensWidget: _buildLensThumbnail(
              bg: const Color(0xFFE3F7EB),
              border: const Color(0xFFC4EED3),
              baseColor: const Color(0xFF6EE7B7),
              centerColor: const Color(0xFFD1FAE5),
            ),
            title: 'VeriWide 1.56 B.CUT PG (65MM)',
            subtitle: '1 pair',
            badgeBg: const Color(0xFFDCFCE7),
            badgeDot: const Color(0xFF16A34A),
            badgeText: 'Ready',
            badgeTextColor: const Color(0xFF15803D),
          ),

          SizedBox(height: 16.h),

          // Bottom Reference Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your reference',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                widget.reference,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow({
    required Widget lensWidget,
    required String title,
    required String subtitle,
    required Color badgeBg,
    required Color badgeDot,
    required String badgeText,
    required Color badgeTextColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lensWidget,
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.8.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
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
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 3.h),
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
                  color: badgeDot,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.5.w),
              Text(
                badgeText,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w600,
                  color: badgeTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLensThumbnail({
    required Color bg,
    required Color border,
    required Color baseColor,
    required Color centerColor,
  }) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: border, width: 0.8.w),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.35, -0.4),
            radius: 0.85,
            colors: [
              Colors.white.withValues(alpha: 0.95),
              centerColor,
              baseColor,
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: baseColor.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 3.h,
              left: 6.w,
              child: Container(
                width: 11.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.all(Radius.elliptical(11.w, 5.h)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. INVOICE NOTE AT BOTTOM
  // ===========================================================================
  Widget _buildBottomInvoiceNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 16.sp,
            color: const Color(0xFF64748B),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Invoice will be available here after dispatch.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
