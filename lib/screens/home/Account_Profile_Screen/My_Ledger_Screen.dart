import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLedgerScreen extends StatefulWidget {
  const MyLedgerScreen({super.key});

  @override
  State<MyLedgerScreen> createState() => _MyLedgerScreenState();
}

class _MyLedgerScreenState extends State<MyLedgerScreen> {
  // 0 = This month, 1 = Last 3 months, 2 = Pick dates
  int _selectedFilterIndex = 0;
  // String _pickDatesLabel = 'Pick dates';

  // 1. Data for "This month" (exact transactions from image)
  final List<LedgerItem> _thisMonthList = const [
    LedgerItem(
      day: '05',
      month: 'Oct',
      title: 'Invoice INV-8812',
      subtitle: 'Order #VO-24581',
      amount: '+ ₹ 4,721',
      balance: 'Bal ₹ 31,550',
      isCredit: false,
    ),
    LedgerItem(
      day: '02',
      month: 'Oct',
      title: 'Payment received',
      subtitle: 'UPI · UTR 4521 8890',
      amount: '- ₹ 10,000',
      balance: 'Bal ₹ 26,829',
      isCredit: true,
    ),
    LedgerItem(
      day: '28',
      month: 'Sep',
      title: 'Invoice INV-8790',
      subtitle: 'Order #VO-24533',
      amount: '+ ₹ 2,965',
      balance: 'Bal ₹ 36,829',
      isCredit: false,
    ),
    LedgerItem(
      day: '25',
      month: 'Sep',
      title: 'Credit note CN-112',
      subtitle: 'Return of 2 pairs',
      amount: '- ₹ 380',
      balance: 'Bal ₹ 33,864',
      isCredit: true,
    ),
    LedgerItem(
      day: '20',
      month: 'Sep',
      title: 'Payment received',
      subtitle: 'Cheque 004512',
      amount: '- ₹ 15,000',
      balance: 'Bal ₹ 34,244',
      isCredit: true,
    ),
  ];

  // 2. Data for "Last 3 months"
  final List<LedgerItem> _last3MonthsList = const [
    LedgerItem(
      day: '05',
      month: 'Oct',
      title: 'Invoice INV-8812',
      subtitle: 'Order #VO-24581',
      amount: '+ ₹ 4,721',
      balance: 'Bal ₹ 31,550',
      isCredit: false,
    ),
    LedgerItem(
      day: '02',
      month: 'Oct',
      title: 'Payment received',
      subtitle: 'UPI · UTR 4521 8890',
      amount: '- ₹ 10,000',
      balance: 'Bal ₹ 26,829',
      isCredit: true,
    ),
    LedgerItem(
      day: '28',
      month: 'Sep',
      title: 'Invoice INV-8790',
      subtitle: 'Order #VO-24533',
      amount: '+ ₹ 2,965',
      balance: 'Bal ₹ 36,829',
      isCredit: false,
    ),
    LedgerItem(
      day: '25',
      month: 'Sep',
      title: 'Credit note CN-112',
      subtitle: 'Return of 2 pairs',
      amount: '- ₹ 380',
      balance: 'Bal ₹ 33,864',
      isCredit: true,
    ),
    LedgerItem(
      day: '20',
      month: 'Sep',
      title: 'Payment received',
      subtitle: 'Cheque 004512',
      amount: '- ₹ 15,000',
      balance: 'Bal ₹ 34,244',
      isCredit: true,
    ),
    LedgerItem(
      day: '12',
      month: 'Aug',
      title: 'Invoice INV-8640',
      subtitle: 'Order #VO-24210',
      amount: '+ ₹ 8,400',
      balance: 'Bal ₹ 49,244',
      isCredit: false,
    ),
    LedgerItem(
      day: '05',
      month: 'Aug',
      title: 'Payment received',
      subtitle: 'NEFT · UTR 9012 3411',
      amount: '- ₹ 20,000',
      balance: 'Bal ₹ 40,844',
      isCredit: true,
    ),
  ];

  // 3. Data for "Pick dates"
  final List<LedgerItem> _pickedDatesList = const [
    LedgerItem(
      day: '05',
      month: 'Oct',
      title: 'Invoice INV-8812',
      subtitle: 'Order #VO-24581',
      amount: '+ ₹ 4,721',
      balance: 'Bal ₹ 31,550',
      isCredit: false,
    ),
    LedgerItem(
      day: '02',
      month: 'Oct',
      title: 'Payment received',
      subtitle: 'UPI · UTR 4521 8890',
      amount: '- ₹ 10,000',
      balance: 'Bal ₹ 26,829',
      isCredit: true,
    ),
  ];

  // Current active list based on selected filter
  List<LedgerItem> get _currentTransactions {
    if (_selectedFilterIndex == 0) {
      return _thisMonthList;
    } else if (_selectedFilterIndex == 1) {
      return _last3MonthsList;
    } else {
      return _pickedDatesList;
    }
  }

  // Handle Filter Selection
  Future<void> _onFilterTap(int index) async {
    if (index == 2) {
      // Open Date Picker for "Pick dates"
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF1B2333),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Color(0xFF0F172A),
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          _selectedFilterIndex = 2;
          // _pickDatesLabel =
          //     '${picked.start.day}/${picked.start.month} - ${picked.end.day}/${picked.end.month}';
        });
      }
    } else {
      setState(() {
        _selectedFilterIndex = index;
      });
    }
  }

  void _onDownloadTap() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Downloading ledger statement...',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1B2333),
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
        backgroundColor: const Color(0xFFF6F8FC),
        body: SafeArea(
          child: Column(
            children: [
              // 1. Top Bar
              _buildTopBar(),

              // 2. Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      // Outstanding Balance Card
                      _buildBalanceCard(),

                      SizedBox(height: 14.h),

                      // Info Banner
                      _buildPaymentNoticeBanner(),

                      SizedBox(height: 16.h),

                      // Filters ("This month", "Last 3 months", "Pick dates")
                      _buildFilterChips(),

                      SizedBox(height: 14.h),

                      // Transactions List using ListView.builder
                      _buildTransactionsListView(),

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

  // --- TOP BAR ---
  Widget _buildTopBar() {
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
                        color: const Color(0xFFE2E8F0),
                        width: 1.w,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 24.sp,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Text(
                'My ledger',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          // Download button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _onDownloadTap,
              borderRadius: BorderRadius.circular(6.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Text(
                  'Download',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
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

  // --- OUTSTANDING BALANCE CARD ---
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
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
            'Outstanding balance',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '₹ 31,550',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 27.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(child: _buildSubStat('Credit limit', '₹ 50,000')),
              SizedBox(width: 8.w),
              Expanded(child: _buildSubStat('Available', '₹ 18,450')),
              SizedBox(width: 8.w),
              Expanded(child: _buildSubStat('Pay in', '1 month')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubStat(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- PAYMENT NOTICE BANNER ---
  Widget _buildPaymentNoticeBanner() {
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
              Icons.account_balance_wallet_outlined,
              size: 19.sp,
              color: const Color(0xFF0284C7),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Pay by bank transfer, UPI, cheque or cash. Our accounts team adds your payment here — usually the same day.',
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

  // --- FILTER CHIPS ---
  Widget _buildFilterChips() {
    final filterLabels = [
      'This month',
      'Last 3 months',
      // _pickDatesLabel,
    ];

    return Row(
      children: List.generate(filterLabels.length, (index) {
        final isSelected = _selectedFilterIndex == index;
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onFilterTap(index),
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF161F2E) : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF161F2E)
                        : const Color(0xFFE2E8F0),
                    width: 1.w,
                  ),
                ),
                child: Text(
                  filterLabels[index],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // --- TRANSACTIONS LIST USING ListView.builder ---
  Widget _buildTransactionsListView() {
    final list = _currentTransactions;

    if (list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        alignment: Alignment.center,
        child: Text(
          'No transactions found',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
      );
    }

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final isLast = index == list.length - 1;

            return Column(
              children: [
                _buildTransactionRow(item),
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF1F5F9),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Single transaction row
  Widget _buildTransactionRow(LedgerItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date badge box (Day / Month)
          Container(
            width: 44.w,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFF1F5F9), width: 1.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.day,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  item.month,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.1,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Amount & Running Balance
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.amount,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  // Credit/Payment is green, Invoice/Debit is dark
                  color: item.isCredit
                      ? const Color(0xFF0D9488)
                      : const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                item.balance,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data model for ledger transactions
class LedgerItem {
  final String day;
  final String month;
  final String title;
  final String subtitle;
  final String amount;
  final String balance;
  final bool isCredit;

  const LedgerItem({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.balance,
    required this.isCredit,
  });
}
