import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/screens/home/Order_Screen/Order_Tracking_Screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Needs my OK (1)',
    'Active',
    'Delivered',
  ];

  final List<Map<String, dynamic>> _allOrders = [
    // 1. Placed
    {
      'id': '#VO-24592',
      'status': 'Placed',
      'statusType': 'placed',
      'isNeedsOk': false,
      'lenses': ['progressive', 'singleVision', 'blueCut'],
      'extraLensesCount': 0,
      'primaryDetail': '3 products · ₹ 1,329',
      'secondaryDetail': 'Ref: Job 4521',
      'reference': 'Job 4521',
      'time': 'Today, 12:10 PM',
      'filterCategory': 'Active',
    },

    // 2. Needs your OK (Highlighted card with orange border)
    {
      'id': '#VO-24577',
      'status': 'Needs your OK',
      'statusType': 'needsOk',
      'isNeedsOk': true,
      'lenses': ['singleVision', 'progressive'],
      'extraLensesCount': 0,
      'primaryDetail': '8 of 10 pairs available',
      'secondaryDetail': 'Choose: send now or wait',
      'reference': '',
      'time': 'Yesterday',
      'filterCategory': 'Needs my OK (1)',
    },

    // 3. Dispatched
    {
      'id': '#VO-24581',
      'status': 'Dispatched',
      'statusType': 'dispatched',
      'isNeedsOk': false,
      'lenses': ['blueCut', 'singleVision', 'purple'],
      'extraLensesCount': 1,
      'primaryDetail': '4 products · ₹ 4,721',
      'secondaryDetail': 'Delhivery · AWB 1489 2201',
      'reference': 'AWB 1489 2201',
      'time': '4 Oct',
      'filterCategory': 'Active',
    },

    // 4. Awaiting stock
    {
      'id': '#VO-24560',
      'status': 'Awaiting stock',
      'statusType': 'awaitingStock',
      'isNeedsOk': false,
      'lenses': ['blueCut'],
      'extraLensesCount': 0,
      'primaryDetail': '1 product · ₹ 420',
      'secondaryDetail': 'Expected 14 Oct',
      'reference': '',
      'time': '1 Oct',
      'filterCategory': 'Active',
    },

    // 5. Delivered
    {
      'id': '#VO-24533',
      'status': 'Delivered',
      'statusType': 'delivered',
      'isNeedsOk': false,
      'lenses': ['singleVision', 'blueCut', 'progressive'],
      'extraLensesCount': 3,
      'primaryDetail': '6 products · ₹ 2,965',
      'secondaryDetail': 'Invoice ready',
      'reference': '',
      'time': '28 Sep',
      'filterCategory': 'Delivered',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredOrders {
    return _allOrders.where((order) {
      final isNeedsOk = order['isNeedsOk'] as bool? ?? false;
      final statusType = order['statusType'] as String? ?? '';

      // Filter tab check
      if (_selectedFilter == 'Needs my OK (1)') {
        if (!isNeedsOk) return false;
      } else if (_selectedFilter == 'Active') {
        if (statusType == 'delivered') return false;
      } else if (_selectedFilter == 'Delivered') {
        if (statusType != 'delivered') return false;
      }

      // Search query check
      if (_searchQuery.trim().isNotEmpty) {
        final query = _searchQuery.toLowerCase().trim();
        final id = (order['id'] as String? ?? '').toLowerCase();
        final ref = (order['reference'] as String? ?? '').toLowerCase();
        final sec = (order['secondaryDetail'] as String? ?? '').toLowerCase();
        final status = (order['status'] as String? ?? '').toLowerCase();
        if (!id.contains(query) &&
            !ref.contains(query) &&
            !sec.contains(query) &&
            !status.contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Filter Orders',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: const Color(0xFF1B2333),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1B2333)
                          : const Color(0xFFE2E8F0),
                    ),
                    labelStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF334155),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilter = filter);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Bar Area: "My orders" & "Filter"
              _buildTopHeader(),

              // Search Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Search',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildSearchInputField(),
                  ],
                ),
              ),

              SizedBox(height: 14.h),

              // Filter Chips Row: "All", "Needs my OK (1)", "Active", "Delivered"
              _buildFilterChipsRow(),

              SizedBox(height: 14.h),

              // Orders List (ListView.builder)
              Expanded(
                child: _filteredOrders.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 2.h,
                          bottom: 24.h,
                        ),
                        itemCount: _filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = _filteredOrders[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => OrderTrackingScreen(
                                      orderId: order['id'] as String? ?? '#VO-24577',
                                      reference: (order['reference'] as String? ?? '').isNotEmpty
                                          ? order['reference'] as String
                                          : 'Job 4498',
                                    ),
                                  ),
                                );
                              },
                              child: _buildOrderCard(order),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HEADER ("My orders" & "Filter")
  // ===========================================================================
  Widget _buildTopHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 10.h,
        bottom: 12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'My orders',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Text(
                'Filter',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. SEARCH INPUT FIELD
  // ===========================================================================
  Widget _buildSearchInputField() {
    return Container(
      height: 46.h,
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val;
          });
        },
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          hintText: 'Order number or your reference',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          // Normal Border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: const Color(0xFFE2E8F0), width: 1.w),
          ),
          // Focused Border (Jo ab properly dikhega)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primaryDark, width: 1.5.w),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints(
            minWidth: 24.w,
            minHeight: 24.w,
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. FILTER PILL CHIPS ROW
  // ===========================================================================
  Widget _buildFilterChipsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1B2333) : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF1B2333,
                            ).withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // 4. ORDER CARD WIDGET
  // ===========================================================================
  Widget _buildOrderCard(Map<String, dynamic> order) {
    final isNeedsOk = order['isNeedsOk'] as bool? ?? false;
    final orderId = order['id'] as String? ?? '';
    final primaryDetail = order['primaryDetail'] as String? ?? '';
    final secondaryDetail = order['secondaryDetail'] as String? ?? '';
    final time = order['time'] as String? ?? '';

    final borderColor = isNeedsOk
        ? const Color(
            0xFFD97706,
          ) // Orange highlighted border for "Needs your OK"
        : const Color(0xFFE2E8F0);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor,
            width: isNeedsOk ? 1.5.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Order ID & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  orderId,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                ),
                _buildStatusBadge(order),
              ],
            ),

            SizedBox(height: 10.h),

            // Lens Sphere Thumbnails Row
            _buildLensThumbnailsRow(order),

            SizedBox(height: 10.h),

            // Primary Detail (e.g., "3 products · ₹ 1,329" or "8 of 10 pairs available")
            Text(
              primaryDetail,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: isNeedsOk ? FontWeight.w700 : FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),

            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    secondaryDetail,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  time,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }

  // ===========================================================================
  // 5. STATUS BADGE
  // ===========================================================================
  Widget _buildStatusBadge(Map<String, dynamic> order) {
    final statusType = order['statusType'] as String? ?? '';
    final statusText = order['status'] as String? ?? '';

    Color bg;
    Color dot;
    Color text;

    switch (statusType) {
      case 'placed':
        bg = const Color(0xFFF1F5F9);
        dot = const Color(0xFF64748B);
        text = const Color(0xFF475569);
        break;
      case 'needsOk':
        bg = const Color(0xFFFEF3C7);
        dot = const Color(0xFFD97706);
        text = const Color(0xFFB45309);
        break;
      case 'dispatched':
        bg = const Color(0xFFE0F2FE);
        dot = const Color(0xFF0284C7);
        text = const Color(0xFF0369A1);
        break;
      case 'awaitingStock':
        bg = const Color(0xFFF1F5F9);
        dot = const Color(0xFF64748B);
        text = const Color(0xFF475569);
        break;
      case 'delivered':
        bg = const Color(0xFFDCFCE7);
        dot = const Color(0xFF16A34A);
        text = const Color(0xFF15803D);
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        dot = const Color(0xFF64748B);
        text = const Color(0xFF475569);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.w),
          Text(
            statusText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. LENS THUMBNAILS ROW (Spheres + "+N" tag)
  // ===========================================================================
  Widget _buildLensThumbnailsRow(Map<String, dynamic> order) {
    final lenses = (order['lenses'] as List<dynamic>? ?? []).cast<String>();
    final extraLensesCount = order['extraLensesCount'] as int? ?? 0;

    return Row(
      children: [
        ...lenses.map((lens) {
          return Padding(
            padding: EdgeInsets.only(right: 6.w),
            child: _buildSmallLensCard(lens),
          );
        }),

        // Extra lenses count container (e.g. "+1", "+3")
        if (extraLensesCount > 0)
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              '+$extraLensesCount',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSmallLensCard(String kind) {
    Color cardBg;
    Color cardBorder;
    Color baseColor;
    Color centerColor;

    switch (kind) {
      case 'progressive':
        cardBg = const Color(0xFFE3F7EB);
        cardBorder = const Color(0xFFC4EED3);
        baseColor = const Color(0xFF6EE7B7);
        centerColor = const Color(0xFFD1FAE5);
        break;
      case 'singleVision':
        cardBg = const Color(0xFFF1F5F9);
        cardBorder = const Color(0xFFE2E8F0);
        baseColor = const Color(0xFFCBD5E1);
        centerColor = const Color(0xFFF8FAFC);
        break;
      case 'blueCut':
        cardBg = const Color(0xFFEFF6FF);
        cardBorder = const Color(0xFFDBEAFE);
        baseColor = const Color(0xFF60A5FA);
        centerColor = const Color(0xFFDBEAFE);
        break;
      case 'purple':
        cardBg = const Color(0xFFF5F3FF);
        cardBorder = const Color(0xFFE9D5FF);
        baseColor = const Color(0xFFC084FC);
        centerColor = const Color(0xFFF3E8FF);
        break;
      default:
        cardBg = const Color(0xFFF1F5F9);
        cardBorder = const Color(0xFFE2E8F0);
        baseColor = const Color(0xFFCBD5E1);
        centerColor = const Color(0xFFF8FAFC);
    }

    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: cardBorder, width: 0.8.w),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 25.w,
        height: 25.w,
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
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Glass sheen reflection
            Positioned(
              top: 3.h,
              left: 5.w,
              child: Container(
                width: 9.w,
                height: 4.5.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.all(Radius.elliptical(9.w, 4.5.h)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 7. EMPTY SEARCH STATE
  // ===========================================================================
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.sp,
            color: const Color(0xFF94A3B8),
          ),
          SizedBox(height: 12.h),
          Text(
            'No orders found',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Try searching for another order or reference',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5.sp,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
