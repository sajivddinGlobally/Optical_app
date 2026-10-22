import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';

// Typedef to handle any spelling variations
typedef NotifiactionScreen = NotificationScreen;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Selected category filter index: 0 = All, 1 = Orders, 2 = Payments, 3 = Stock
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Orders', 'Payments', 'Stock'];

  bool _isItem1Unread = true;
  bool _isItem2Unread = true;

  void _markAllAsRead() {
    setState(() {
      _isItem1Unread = false;
      _isItem2Unread = false;
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'All notifications marked as read',
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

  void _onChooseNowTap() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening Order #VO-24577 options...',
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
    final showOrders = _selectedFilterIndex == 0 || _selectedFilterIndex == 1;
    final showPayments = _selectedFilterIndex == 0 || _selectedFilterIndex == 2;
    final showStock = _selectedFilterIndex == 0 || _selectedFilterIndex == 3;

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

              // 2. Filter Tabs ("All", "Orders", "Payments", "Stock")
              _buildFilterChips(),

              SizedBox(height: 6.h),

              // 3. Scrollable Notifications Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showOrders || showPayments) ...[
                        SizedBox(height: 12.h),
                        Text(
                          'Today',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildTodayCard(showOrders, showPayments),
                      ],

                      // --- EARLIER SECTION ---
                      if (showStock || showPayments || showOrders) ...[
                        SizedBox(height: 18.h),
                        Text(
                          'Earlier',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildEarlierCard(showStock, showPayments, showOrders),
                      ],

                      SizedBox(height: 16.h),

                      // --- FOOTER NOTE ---
                      _buildFooterNote(),

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

  // --- TOP HEADER BAR ---
  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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

              // Title "Notifications"
              Text(
                'Notifications',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          // "Mark all read" Action
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _markAllAsRead,
              borderRadius: BorderRadius.circular(6.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Text(
                  'Mark all read',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- FILTER CHIPS ROW ---
  Widget _buildFilterChips() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() => _selectedFilterIndex = index);
                },
                borderRadius: BorderRadius.circular(20.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF161F2E) : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF161F2E)
                          : AppColors.cardBorder,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    _filters[index],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- TODAY CARD ---
  Widget _buildTodayCard(bool showOrders, bool showPayments) {
    final List<Widget> items = [];

    if (showOrders) {
      // 1. Your answer is needed
      items.add(
        _buildNotificationRow(
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFFD97706),
          iconBgColor: const Color(0xFFFEF3C7),
          title: 'Your answer is needed',
          time: '12:40 PM',
          isUnread: _isItem1Unread,
          description:
              'Order #VO-24577: only 8 of 10 pairs are available. Send now or wait?',
          actionButton: Material(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: _onChooseNowTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 0.8.w,
                  ),
                ),
                child: Text(
                  'Choose now',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // 2. Order dispatched
      items.add(
        _buildNotificationRow(
          icon: Icons.local_shipping_outlined,
          iconColor: const Color(0xFF0284C7),
          iconBgColor: const Color(0xFFE0F2FE),
          title: 'Order dispatched',
          time: '11:05 AM',
          isUnread: _isItem2Unread,
          description: 'Order #VO-24581 left with Delhivery. AWB 1489 2201.',
        ),
      );
    }

    if (showPayments) {
      // 3. Payment received
      items.add(
        _buildNotificationRow(
          icon: Icons.account_balance_wallet_outlined,
          iconColor: const Color(0xFF16A34A),
          iconBgColor: const Color(0xFFDCFCE7),
          title: 'Payment received',
          time: '10:20 AM',
          isUnread: false,
          description:
              '₹ 10,000 by UPI added to your ledger. Outstanding is now ₹ 31,550.',
        ),
      );
    }

    return _buildCardWrapper(items);
  }

  // --- EARLIER CARD ---
  Widget _buildEarlierCard(bool showStock, bool showPayments, bool showOrders) {
    final List<Widget> items = [];

    if (showStock) {
      // 1. Back in stock
      items.add(
        _buildNotificationRow(
          icon: Icons.inventory_2_outlined,
          iconColor: const Color(0xFF334155),
          iconBgColor: const Color(0xFFF1F5F9),
          title: 'Back in stock',
          time: 'Yesterday',
          isUnread: false,
          description:
              'Lords 1.56 HC PG is back. Your waiting order #VO-24560 is moving ahead.',
        ),
      );
    }

    if (showPayments) {
      // 2. Credit limit increased
      items.add(
        _buildNotificationRow(
          icon: Icons.verified_user_outlined,
          iconColor: const Color(0xFF16A34A),
          iconBgColor: const Color(0xFFDCFCE7),
          title: 'Credit limit increased',
          time: '3 Oct',
          isUnread: false,
          description: 'Our accounts team approved your new limit of ₹ 75,000.',
        ),
      );
    }

    if (showOrders) {
      // 3. New price list
      items.add(
        _buildNotificationRow(
          icon: Icons.local_offer_outlined,
          iconColor: const Color(0xFF9333EA),
          iconBgColor: const Color(0xFFF3E8FF),
          title: 'New price list',
          time: '1 Oct',
          isUnread: false,
          description:
              'Prices for Blue Cut lenses are updated. Check before you order.',
        ),
      );

      // 4. Account approved
      items.add(
        _buildNotificationRow(
          icon: Icons.check_rounded,
          iconColor: const Color(0xFF16A34A),
          iconBgColor: const Color(0xFFDCFCE7),
          title: 'Account approved',
          time: '28 Sep',
          isUnread: false,
          description:
              'Welcome to Vishal Optical Co. You can now place orders.',
        ),
      );
    }

    return _buildCardWrapper(items);
  }

  // Card Wrapper helper
  Widget _buildCardWrapper(List<Widget> items) {
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
          children: List.generate(items.length, (index) {
            final isLast = index == items.length - 1;
            return Column(
              children: [
                items[index],
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF1F5F9),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Single Notification Row Widget
  Widget _buildNotificationRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String time,
    required bool isUnread,
    required String description,
    Widget? actionButton,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Icon Container
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 20.sp, color: iconColor),
          ),

          SizedBox(width: 12.w),

          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Time Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      time,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                    if (isUnread) ...[
                      SizedBox(width: 5.w),
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDC2626),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 3.h),

                // Description text
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF475569),
                    height: 1.35,
                  ),
                ),

                // Optional Action Button (e.g. "Choose now")
                if (actionButton != null) ...[
                  SizedBox(height: 10.h),
                  actionButton,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- FOOTER NOTE ---
  Widget _buildFooterNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 17.sp,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'You get only the updates for your own shop. Turn types on or off in Account > Notifications.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF475569),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
