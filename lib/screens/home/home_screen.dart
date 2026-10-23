import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/optical_logo.dart';
import 'package:optical_app/screens/home/Browse_Screen/Browser_Screen.dart';
import 'package:optical_app/screens/home/Cart_Screen/Card_Screen.dart';
import 'package:optical_app/screens/home/NotificationScreen.dart';
import 'package:optical_app/screens/home/widgets/eyewear_frame_graphic.dart';
import 'package:optical_app/screens/home/widgets/lens_sphere_graphic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Page controller for promotional hero banners
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  // Search query & filtering
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Active category & filter chips
  int _selectedCategoryIndex = 0;
  String _selectedFilterTag = 'All';

  // Interactive Wishlist & Cart state
  final Set<String> _wishlist = {};
  final Map<String, int> _cartQuantities = {};

  // Power quick-finder state
  String _selectedSph = '-2.00';
  String _selectedCyl = '-0.50';
  String _selectedLensType = 'Blue Cut';

  // Categories list for e-commerce
  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'all',
      'title': 'All Items',
      'icon': Icons.grid_view_rounded,
      'badge': null,
      'color': const Color(0xFF1B2333),
      'bg': const Color(0xFFF1F5F9),
      'image': null,
    },
    {
      'id': 'blue_cut',
      'title': 'Blue Cut',
      'icon': Icons.laptop_chromebook_rounded,
      'badge': 'HOT',
      'color': const Color(0xFF2563EB),
      'bg': const Color(0xFFEFF6FF),
      'image': 'assets/images/categories/cat_bluecut.jpg',
    },
    {
      'id': 'single_vision',
      'title': 'Single Vision',
      'icon': Icons.remove_red_eye_outlined,
      'badge': 'SV',
      'color': const Color(0xFF0D9488),
      'bg': const Color(0xFFF0FDFA),
      'image': 'assets/images/categories/cat_singlevision.jpg',
    },
    {
      'id': 'progressive',
      'title': 'Progressive',
      'icon': Icons.tune_rounded,
      'badge': 'PRO',
      'color': const Color(0xFF7C3AED),
      'bg': const Color(0xFFF5F3FF),
      'image': 'assets/images/categories/cat_progressive.jpg',
    },
    {
      'id': 'bifocal',
      'title': 'Bifocal (KT)',
      'icon': Icons.splitscreen_rounded,
      'badge': 'KT',
      'color': const Color(0xFF0284C7),
      'bg': const Color(0xFFF0F9FF),
      'image': 'assets/images/categories/cat_bifocal.jpg',
    },
    {
      'id': 'rx_lab',
      'title': 'Rx Custom',
      'icon': Icons.biotech_rounded,
      'badge': '24h',
      'color': const Color(0xFF9333EA),
      'bg': const Color(0xFFFAF5FF),
      'image': 'assets/images/categories/cat_rx.jpg',
    },
    {
      'id': 'contact_lens',
      'title': 'Contact Lens',
      'icon': Icons.water_drop_outlined,
      'badge': null,
      'color': const Color(0xFF059669),
      'bg': const Color(0xFFECFDF5),
      'image': 'assets/images/categories/cat_contactlens.jpg',
    },
  ];

  // Promotional Banners
  final List<Map<String, dynamic>> _promoBanners = [
    {
      'badge': 'SEASON CLEARANCE · UP TO 40% OFF',
      'title': 'AirSmart 1.61 Blue Cut',
      'subtitle':
          'Zero-glare computer lenses with UV420 shield. Instant stock dispatch.',
      'priceTag': 'From ₹129 / pair',
      'buttonText': 'Order Now',
      'bgGradient': [const Color(0xFF1B2333), const Color(0xFF24344D)],
      'badgeColor': const Color(0xFF38BDF8),
      'image': 'assets/images/banners/banner_bluecut.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.blueCut,
      'badgeText': 'BLUE CUT',
    },
    {
      'badge': 'NEW ARRIVALS · 2026 COLLECTION',
      'title': 'Titanium & Acetate Frames',
      'subtitle': 'Ultra-lightweight optical frames with flex spring temples.',
      'priceTag': 'Starting ₹499 / pc',
      'buttonText': 'View Catalog',
      'bgGradient': [const Color(0xFF0F172A), const Color(0xFF1E293B)],
      'badgeColor': const Color(0xFFF59E0B),
      'image': 'assets/images/banners/banner_frames.jpg',
      'isLens': false,
      'frameStyle': EyewearFrameStyle.classicSquare,
      'badgeText': 'NEW',
    },
    {
      'badge': 'VOC EXPRESS RX LAB',
      'title': 'Custom Power in 24 Hrs',
      'subtitle':
          'High cylinder powers, progressive corridors & tint options surfaced on demand.',
      'priceTag': 'Express Turnaround',
      'buttonText': 'Upload Rx',
      'bgGradient': [const Color(0xFF1E1B4B), const Color(0xFF312E81)],
      'badgeColor': const Color(0xFFA78BFA),
      'image': 'assets/images/banners/banner_rxlab.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.rx,
      'badgeText': 'RX LAB',
    },
  ];

  // Flash Deals
  final List<Map<String, dynamic>> _flashDeals = [
    {
      'id': 'fd_1',
      'title': 'Blu Safe 1.56 Anti-Glare',
      'specs': 'Index 1.56 · Green HMC',
      'price': 110,
      'originalPrice': 160,
      'discount': '31% OFF',
      'rating': 4.9,
      'reviews': 82,
      'image': 'assets/images/products/lens_blusafe.jpg',
      'lensStyle': LensTypeStyle.singleVision,
      'badgeText': 'SUPER DEAL',
      'inStock': true,
    },
    {
      'id': 'fd_2',
      'title': 'VeriWide 1.56 Progressive',
      'specs': 'Wide Corridor · Blue Cut',
      'price': 299,
      'originalPrice': 399,
      'discount': '25% OFF',
      'rating': 4.8,
      'reviews': 64,
      'image': 'assets/images/products/lens_veriwide.jpg',
      'lensStyle': LensTypeStyle.progressive,
      'badgeText': 'PROGRESSIVE',
      'inStock': true,
    },
    {
      'id': 'fd_3',
      'title': 'Gold Aviator Polarized',
      'specs': 'UV400 · Scratch Resistant',
      'price': 450,
      'originalPrice': 650,
      'discount': '30% OFF',
      'rating': 4.9,
      'reviews': 45,
      'image': 'assets/images/products/frame_aviator.jpg',
      'isFrame': true,
      'frameStyle': EyewearFrameStyle.aviator,
      'badgeText': 'POLARIZED',
      'inStock': true,
    },
    {
      'id': 'fd_4',
      'title': 'Lords Fast Photochromic',
      'specs': 'Index 1.56 · Grey Transition',
      'price': 180,
      'originalPrice': 240,
      'discount': '25% OFF',
      'rating': 4.7,
      'reviews': 39,
      'image': 'assets/images/products/lens_photochromic.jpg',
      'lensStyle': LensTypeStyle.blueCut,
      'badgeText': 'TRANSITION',
      'inStock': true,
    },
  ];

  // Full E-commerce Product Catalog
  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': 'prod_1',
      'title': 'AirSmart 1.61 Blue Cut SV',
      'subtitle': 'Hi-Index 1.61 · UV420 Protection',
      'category': 'Blue Cut',
      'tag': 'BESTSELLER',
      'price': 129,
      'originalPrice': 180,
      'rating': 4.9,
      'reviews': 128,
      'image': 'assets/images/products/lens_airsmart.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.blueCut,
      'badgeText': 'BLUE CUT',
      'stockLocation': 'Pune Central Hub',
      'isRx': false,
    },
    {
      'id': 'prod_2',
      'title': 'VeriWide 1.56 B.CUT PG',
      'subtitle': 'Progressive · Soft Corridor',
      'category': 'Progressive',
      'tag': 'POPULAR',
      'price': 350,
      'originalPrice': 450,
      'rating': 4.8,
      'reviews': 94,
      'image': 'assets/images/products/lens_veriwide.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.progressive,
      'badgeText': 'PROGRESSIVE',
      'stockLocation': 'Pune Central Hub',
      'isRx': false,
    },
    {
      'id': 'prod_3',
      'title': 'Titanium Flex Classic Frame',
      'subtitle': 'Ultralight 8.5g · Memory Alloy',
      'category': 'Frames',
      'tag': 'NEW',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.9,
      'reviews': 52,
      'image': 'assets/images/products/frame_titanium.jpg',
      'isLens': false,
      'frameStyle': EyewearFrameStyle.classicSquare,
      'badgeText': 'TITANIUM',
      'stockLocation': 'Direct Warehouse',
      'isRx': false,
    },
    {
      'id': 'prod_4',
      'title': 'AeroLite 1.56 Single Vision',
      'subtitle': 'Hard Coat · Green Anti-Reflective',
      'category': 'Single Vision',
      'tag': 'VALUE PACK',
      'price': 95,
      'originalPrice': 130,
      'rating': 4.7,
      'reviews': 110,
      'image': 'assets/images/products/lens_aerolite.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.singleVision,
      'badgeText': 'SINGLE VISION',
      'stockLocation': 'Ready to Dispatch',
      'isRx': false,
    },
    {
      'id': 'prod_5',
      'title': 'SLX 1.67 Ultra-Thin Aspheric',
      'subtitle': 'For High Minus Powers · Zero Distortion',
      'category': 'Single Vision',
      'tag': 'HI-INDEX',
      'price': 240,
      'originalPrice': 320,
      'rating': 4.9,
      'reviews': 76,
      'image': 'assets/images/products/lens_blusafe.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.singleVision,
      'badgeText': '1.67 ULTRA',
      'stockLocation': 'Pune Central Hub',
      'isRx': false,
    },
    {
      'id': 'prod_6',
      'title': 'Vintage Round Retro Spectacles',
      'subtitle': 'Gloss Tortoise & Matte Gunmetal',
      'category': 'Frames',
      'tag': 'TRENDING',
      'price': 420,
      'originalPrice': 600,
      'rating': 4.8,
      'reviews': 41,
      'image': 'assets/images/products/frame_vintage.jpg',
      'isLens': false,
      'frameStyle': EyewearFrameStyle.roundVintage,
      'badgeText': 'VINTAGE',
      'stockLocation': 'Direct Warehouse',
      'isRx': false,
    },
    {
      'id': 'prod_7',
      'title': 'Smoke Polarized Aviator 3025',
      'subtitle': '100% UV400 Protection · Alloy Body',
      'category': 'Sunglasses',
      'tag': 'SUMMER PICK',
      'price': 520,
      'originalPrice': 750,
      'rating': 4.9,
      'reviews': 63,
      'image': 'assets/images/products/frame_sunglasses.jpg',
      'isLens': false,
      'frameStyle': EyewearFrameStyle.sunglassesSmoke,
      'badgeText': 'POLARIZED',
      'stockLocation': 'In Stock',
      'isRx': false,
    },
    {
      'id': 'prod_8',
      'title': 'Kryptok Bifocal 1.56 (KT)',
      'subtitle': 'D-Segment 28mm · Distance + Reading',
      'category': 'Single Vision',
      'tag': 'BIFOCAL',
      'price': 165,
      'originalPrice': 220,
      'rating': 4.6,
      'reviews': 58,
      'image': 'assets/images/categories/cat_bifocal.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.bifocal,
      'badgeText': 'KT BIFOCAL',
      'stockLocation': 'Pune Central Hub',
      'isRx': false,
    },
    {
      'id': 'prod_9',
      'title': 'Rx Precision Surfaced Lab Lens',
      'subtitle': 'Digital Freeform · Any Cyl / Axis',
      'category': 'Progressive',
      'tag': 'CUSTOM RX',
      'price': 480,
      'originalPrice': 650,
      'rating': 5.0,
      'reviews': 91,
      'image': 'assets/images/categories/cat_rx.jpg',
      'isLens': true,
      'lensStyle': LensTypeStyle.rx,
      'badgeText': '24H RX',
      'stockLocation': 'VOC Rx Lab Pune',
      'isRx': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Auto banner carousel slider
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        int next = (_currentBannerIndex + 1) % _promoBanners.length;
        _bannerController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Filter products by selected Category and Search Query
  List<Map<String, dynamic>> get _filteredProducts {
    return _allProducts.where((p) {
      final title = p['title'].toString().toLowerCase();
      final category = p['category'].toString().toLowerCase();
      final subtitle = p['subtitle'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      // Search match
      final matchesSearch =
          query.isEmpty ||
          title.contains(query) ||
          category.contains(query) ||
          subtitle.contains(query);

      if (!matchesSearch) return false;

      // Filter category match
      if (_selectedFilterTag == 'All') {
        if (_selectedCategoryIndex == 0) return true;
        final selectedCatId = _categories[_selectedCategoryIndex]['id'];
        if (selectedCatId == 'all') return true;
        if (selectedCatId == 'blue_cut') return category.contains('blue cut');
        if (selectedCatId == 'progressive')
          return category.contains('progressive');
        if (selectedCatId == 'frames') return category.contains('frames');
        if (selectedCatId == 'sunglasses')
          return category.contains('sunglasses');
        if (selectedCatId == 'single_vision')
          return category.contains('single vision');
        return true;
      }

      if (_selectedFilterTag == 'Blue Cut')
        return category.contains('blue cut');
      if (_selectedFilterTag == 'Progressive')
        return category.contains('progressive');
      if (_selectedFilterTag == 'Frames') return category.contains('frames');
      if (_selectedFilterTag == 'Sunglasses')
        return category.contains('sunglasses');
      if (_selectedFilterTag == 'Single Vision')
        return category.contains('single vision');

      return true;
    }).toList();
  }

  int get _cartTotalItems {
    return _cartQuantities.values.fold(0, (sum, qty) => sum + qty);
  }

  void _toggleWishlist(String id, String title) {
    setState(() {
      if (_wishlist.contains(id)) {
        _wishlist.remove(id);
        _showToast('Removed "$title" from Wishlist');
      } else {
        _wishlist.add(id);
        _showToast('Added "$title" to Wishlist ❤️');
      }
    });
  }

  void _addToCart(String id, String title) {
    setState(() {
      _cartQuantities[id] = (_cartQuantities[id] ?? 0) + 1;
    });
    _showToast('Added "$title" to Cart (Qty: ${_cartQuantities[id]}) 🛒');
  }

  void _removeFromCart(String id) {
    setState(() {
      if ((_cartQuantities[id] ?? 0) > 1) {
        _cartQuantities[id] = _cartQuantities[id]! - 1;
      } else {
        _cartQuantities.remove(id);
      }
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
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
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // 1. E-Commerce Header with Brand, Delivery Pin & Action Badges
              _buildTopHeader(),

              // Scrollable E-commerce Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // 2. Search Bar + Scan / Filter triggers
                      _buildSearchBar(),

                      SizedBox(height: 14.h),

                      // 3. Promotional Hero Carousel Banners
                      _buildHeroPromoCarousel(),

                      SizedBox(height: 16.h),

                      // 4. Shop by Category (Comprehensive Optical Categories)
                      _buildCategoriesSection(),

                      SizedBox(height: 14.h),

                      // 5. Retailer Credit Line & Wallet Bar (Preserving Project Feature)
                      _buildCreditWalletCard(),

                      SizedBox(height: 18.h),

                      // 6. Flash Deals / Deals of the Day (Countdown + Discount Cards)
                      _buildFlashDealsSection(),

                      SizedBox(height: 18.h),

                      // 7. Interactive Prescription Power Quick Finder
                      _buildPrescriptionQuickFinder(),

                      SizedBox(height: 20.h),

                      // 9. E-Commerce Product Catalog / Best Sellers (with Filter Tabs)
                      _buildProductCatalogSection(),

                      SizedBox(height: 20.h),

                      // 10. Recent Orders Quick Tracking
                      _buildRecentOrdersSection(),

                      SizedBox(height: 20.h),

                      // 11. Optical Quality & Trust Badges
                      _buildTrustBadgesSection(),

                      SizedBox(height: 30.h),
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
  // 1. HEADER (Brand, Location, Wishlist, Notification, Cart)
  // ===========================================================================
  Widget _buildTopHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Delivery address
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: const OpticalLogoWidget(
                  width: 22,
                  height: 12,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Vishal Optical Co.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'B2B',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 11.5.sp,
                        color: const Color(0xFF64748B),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Deliver to: Shree Optical, Pune',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Action Icons: Wishlist, Notification, Cart
          _buildHeaderIconButton(
            icon: Icons.notifications_none_rounded,
            iconColor: const Color(0xFF334155),
            showRedDot: true,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIconButton({
    required IconData icon,
    required Color iconColor,
    Color? bgColor,
    bool showRedDot = false,
    int? badgeCount,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: bgColor != null
                ? Colors.transparent
                : const Color(0xFFE2E8F0),
            width: 1.w,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 19.sp, color: iconColor),
            if (showRedDot)
              Positioned(
                top: 6.h,
                right: 7.w,
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (badgeCount != null)
              Positioned(
                top: -2.h,
                right: -2.w,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 15.w, minHeight: 15.w),
                  alignment: Alignment.center,
                  child: Text(
                    '$badgeCount',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. SEARCH BAR + FILTERS
  // ===========================================================================
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 21.sp,
            color: const Color(0xFF64748B),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search lenses, powers, frames, brands...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          // QR / Prescription Scanner Icon
          GestureDetector(
            onTap: () {
              _showToast('Prescription OCR Scanner opened');
            },
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.document_scanner_outlined,
                size: 17.sp,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          // Filter Icon
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const BrowserScreen()));
            },
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.tune_rounded, size: 17.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. HERO PROMO CAROUSEL
  // ===========================================================================

  Widget _buildHeroPromoCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 155.h,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemCount: _promoBanners.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> banner = _promoBanners[index];

              final List<Color> bgGradient = (banner['bgGradient'] as List)
                  .cast<Color>();

              final Color badgeColor = banner['badgeColor'] as Color;

              final bool isLens = banner['isLens'] == true;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: bgGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: bgGradient.first.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: badgeColor.withOpacity(0.4),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              banner['badge']?.toString() ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: badgeColor,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            banner['title']?.toString() ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            banner['subtitle']?.toString() ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5.sp,
                              color: const Color(0xFFCBD5E1),
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  banner['priceTag']?.toString() ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const BrowserScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      banner['buttonText']?.toString() ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25),
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: banner['image'] != null
                                ? Image.asset(
                                    banner['image'] as String,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => isLens
                                        ? LensSphereGraphic(
                                            style:
                                                banner['lensStyle']
                                                    as LensTypeStyle,
                                            size: 58,
                                            badgeText:
                                                banner['badgeText'] as String?,
                                          )
                                        : EyewearFrameGraphic(
                                            style:
                                                banner['frameStyle']
                                                    as EyewearFrameStyle,
                                            size: 52,
                                            badgeText:
                                                banner['badgeText'] as String?,
                                          ),
                                  )
                                : (isLens
                                      ? LensSphereGraphic(
                                          style:
                                              banner['lensStyle']
                                                  as LensTypeStyle,
                                          size: 58,
                                          badgeText:
                                              banner['badgeText'] as String?,
                                        )
                                      : EyewearFrameGraphic(
                                          style:
                                              banner['frameStyle']
                                                  as EyewearFrameStyle,
                                          size: 52,
                                          badgeText:
                                              banner['badgeText'] as String?,
                                        )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promoBanners.length, (index) {
            final bool isSelected = index == _currentBannerIndex;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: isSelected ? 18.w : 6.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryDark
                    : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. CATEGORIES SECTION ("Shop by Category")
  // ===========================================================================
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shop by Category',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Lenses, Frames, Sunglasses & Lab Rx',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BrowserScreen()),
                );
              },
              child: Text(
                'View all ›',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Categories Horizontal Scroll List
        SizedBox(
          height: 94.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategoryIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                    _selectedFilterTag = 'All';
                  });
                },
                child: SizedBox(
                  width: 68.w,
                  child: Column(
                    children: [
                      // Circular / Rounded Icon Box
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 54.w,
                            height: 54.w,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryDark
                                  : (cat['bg'] as Color),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryDark
                                    : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1.0,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primaryDark.withValues(
                                          alpha: 0.25,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: cat['image'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Image.asset(
                                      cat['image'] as String,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Icon(
                                        cat['icon'] as IconData,
                                        size: 24.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : (cat['color'] as Color),
                                      ),
                                    ),
                                  )
                                : Icon(
                                    cat['icon'] as IconData,
                                    size: 24.sp,
                                    color: isSelected
                                        ? Colors.white
                                        : (cat['color'] as Color),
                                  ),
                          ),
                          // Badge (e.g. HOT, NEW, 24h)
                          if (cat['badge'] != null)
                            Positioned(
                              // top: 1.h,
                              right: -4.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDC2626),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  cat['badge'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 7.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // Title
                      Text(
                        cat['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10.5.sp,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. CREDIT WALLET BAR (B2B Optical perk preserved from project)
  // ===========================================================================
  Widget _buildCreditWalletCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 16.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Retailer Credit Line',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF28344A),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 5.w,
                      height: 5.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Pay in 30 Days',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹ 18,450',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Limit ₹ 50,000',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Progress indicator bar
          Container(
            width: double.infinity,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF384459),
              borderRadius: BorderRadius.circular(2.r),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.58,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF38BDF8),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Outstanding: ₹ 31,550 due 15 Nov',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFCBD5E1),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showToast('Navigating to credit ledger & payment statement');
                },
                child: Text(
                  'Pay Due ›',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF38BDF8),
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
  // 6. FLASH DEALS (Countdown + Horizontal Deal Cards)
  // ===========================================================================
  Widget _buildFlashDealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    size: 18.sp,
                    color: const Color(0xFFDC2626),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flash Deals',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      'Limited stock wholesale prices',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Countdown timer chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 13.sp,
                    color: const Color(0xFFDC2626),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '04h : 38m : 15s',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Horizontal Deals Cards List
        SizedBox(
          height: 195.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _flashDeals.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final deal = _flashDeals[index];
              final String id = deal['id'] as String;
              final bool isWishlisted = _wishlist.contains(id);

              return Container(
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Graphic Box with Discount & Wishlist
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 76.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: deal['image'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.asset(
                                    deal['image'] as String,
                                    width: double.infinity,
                                    height: 76.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        deal['isFrame'] == true
                                        ? EyewearFrameGraphic(
                                            style:
                                                deal['frameStyle']
                                                    as EyewearFrameStyle,
                                            size: 44,
                                          )
                                        : LensSphereGraphic(
                                            style:
                                                deal['lensStyle']
                                                    as LensTypeStyle,
                                            size: 46,
                                            badgeText:
                                                deal['badgeText'] as String?,
                                          ),
                                  ),
                                )
                              : (deal['isFrame'] == true
                                    ? EyewearFrameGraphic(
                                        style:
                                            deal['frameStyle']
                                                as EyewearFrameStyle,
                                        size: 44,
                                      )
                                    : LensSphereGraphic(
                                        style:
                                            deal['lensStyle'] as LensTypeStyle,
                                        size: 46,
                                        badgeText: deal['badgeText'] as String?,
                                      )),
                        ),
                        // Discount Tag
                        Positioned(
                          top: 4.h,
                          left: 4.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDC2626),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              deal['discount'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Wishlist toggle
                        Positioned(
                          top: 2.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: () =>
                                _toggleWishlist(id, deal['title'] as String),
                            child: CircleAvatar(
                              radius: 12.r,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.85,
                              ),
                              child: Icon(
                                isWishlisted
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                size: 13.sp,
                                color: isWishlisted
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Title
                    Text(
                      deal['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      deal['specs'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),

                    const Spacer(),

                    // Price & Add to Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹ ${deal['originalPrice']}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9.5.sp,
                                color: const Color(0xFF94A3B8),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '₹ ${deal['price']}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _addToCart(id, deal['title'] as String),
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 7. PRESCRIPTION QUICK FINDER ("Find My Lens by Power")
  // ===========================================================================
  Widget _buildPrescriptionQuickFinder() {
    final sphOptions = ['-0.50', '-1.00', '-2.00', '-3.00', '-4.00', '-5.00'];
    final cylOptions = ['0.00', '-0.50', '-1.00', '-1.50', '-2.00'];
    final lensTypes = [
      'Blue Cut',
      'Single Vision',
      'Progressive',
      'Photochromic',
    ];

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
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.manage_search_rounded,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Lens by Prescription',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Select power & instantly see all in-stock lenses',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // SPH Dropdown
          Text(
            'SPHERICAL (SPH)',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSph,
                hint: Text(
                  'Select SPH',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                ),
                items: sphOptions.map((sph) {
                  return DropdownMenuItem<String>(
                    value: sph,
                    child: Text(
                      sph,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedSph = val!;
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // CYL Dropdown
          Text(
            'CYLINDER (CYL)',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCyl,
                hint: Text(
                  'Select CYL',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                ),
                items: cylOptions.map((cyl) {
                  return DropdownMenuItem<String>(
                    value: cyl,
                    child: Text(
                      cyl,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCyl = val!;
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Lens Type Dropdown
          Text(
            'LENS COATING / TYPE',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLensType,
                hint: Text(
                  'Select Lens Type',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                ),
                items: lensTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedLensType = val!;
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildProductCatalogSection() {
    final filterChips = [
      'All',
      'Blue Cut',
      'Single Vision',
      'Progressive',
      'Frames',
      'Sunglasses',
    ];
    final products = _filteredProducts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Optical Products',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Showing ${products.length} verified products',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BrowserScreen()),
                );
              },
              child: Text(
                'Browse all ›',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        // Filter Pills
        SizedBox(
          height: 34.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: filterChips.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final chip = filterChips[index];
              final isSel = _selectedFilterTag == chip;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilterTag = chip;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.primaryDark : Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: isSel
                          ? AppColors.primaryDark
                          : const Color(0xFFE2E8F0),
                      width: 1.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    chip,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5.sp,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      color: isSel ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 14.h),

        // 2-Column Product Grid
        if (products.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(28.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 38.sp,
                  color: const Color(0xFF94A3B8),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No products found matching "$_searchQuery"',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Try searching for "Blue Cut", "Progressive", or "Frame"',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(product);
            },
          ),
      ],
    );
  }

  // Individual Product Card in 2-Column Grid
  Widget _buildProductCard(Map<String, dynamic> product) {
    final String id = product['id'] as String;
    final bool isWishlisted = _wishlist.contains(id);
    final int qty = _cartQuantities[id] ?? 0;

    return Container(
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
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Graphic container + Wishlist button + Tag
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 98.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: product['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          product['image'] as String,
                          width: double.infinity,
                          height: 98.h,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              product['isLens'] == true
                              ? LensSphereGraphic(
                                  style: product['lensStyle'] as LensTypeStyle,
                                  size: 56,
                                  badgeText: product['badgeText'] as String?,
                                )
                              : EyewearFrameGraphic(
                                  style:
                                      product['frameStyle']
                                          as EyewearFrameStyle,
                                  size: 52,
                                  badgeText: product['badgeText'] as String?,
                                ),
                        ),
                      )
                    : (product['isLens'] == true
                          ? LensSphereGraphic(
                              style: product['lensStyle'] as LensTypeStyle,
                              size: 56,
                              badgeText: product['badgeText'] as String?,
                            )
                          : EyewearFrameGraphic(
                              style: product['frameStyle'] as EyewearFrameStyle,
                              size: 52,
                              badgeText: product['badgeText'] as String?,
                            )),
              ),
              // Top tag (e.g. BESTSELLER, NEW, TITANIUM)
              Positioned(
                top: 4.h,
                left: 4.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    product['tag'] as String,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              // Wishlist Heart Icon
              Positioned(
                top: 2.h,
                right: 2.w,
                child: GestureDetector(
                  onTap: () => _toggleWishlist(id, product['title'] as String),
                  child: CircleAvatar(
                    radius: 13.r,
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: Icon(
                      isWishlisted
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 14.sp,
                      color: isWishlisted
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Rating + In-Stock Row
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 14.sp,
                color: const Color(0xFFF59E0B),
              ),
              SizedBox(width: 2.w),
              Text(
                '${product['rating']}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '(${product['reviews']})',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const Spacer(),
              // In Stock dot
              Container(
                width: 5.w,
                height: 5.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF16A34A),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'Stock',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF16A34A),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Title
          Text(
            product['title'] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 2.h),

          // Subtitle / Specs
          Text(
            product['subtitle'] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              color: const Color(0xFF64748B),
            ),
          ),

          const Spacer(),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹ ${product['price']} ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '₹ ${product['originalPrice']}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  color: const Color(0xFF94A3B8),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // Add to Cart / Quantity Counter Button
          if (qty == 0)
            SizedBox(
              width: double.infinity,
              height: 32.h,
              child: ElevatedButton.icon(
                onPressed: () => _addToCart(id, product['title'] as String),
                icon: Icon(Icons.add_shopping_cart_rounded, size: 13.sp),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 32.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primaryDark, width: 1.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 28.w),
                    icon: Icon(
                      Icons.remove,
                      size: 14.sp,
                      color: AppColors.primaryDark,
                    ),
                    onPressed: () => _removeFromCart(id),
                  ),
                  Text(
                    '$qty pair${qty > 1 ? 's' : ''}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 28.w),
                    icon: Icon(
                      Icons.add,
                      size: 14.sp,
                      color: AppColors.primaryDark,
                    ),
                    onPressed: () => _addToCart(id, product['title'] as String),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 10. RECENT ORDERS QUICK STATUS
  // ===========================================================================
  Widget _buildRecentOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Wholesale Orders',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            GestureDetector(
              onTap: () {
                _showToast('Navigating to full order history');
              },
              child: Text(
                'View all ›',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          child: Column(
            children: [
              _buildOrderItem(
                orderId: '#VO-24581',
                detail: '4 items · AirSmart & VeriWide',
                courier: 'Delhivery Express · ETA Tomorrow',
                badgeText: 'Dispatched',
                badgeBg: const Color(0xFFE0F2FE),
                badgeColor: const Color(0xFF0369A1),
                dotColor: const Color(0xFF0284C7),
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: const Color(0xFFF1F5F9),
              ),
              _buildOrderItem(
                orderId: '#VO-24577',
                detail: '8 of 10 pairs ready in warehouse',
                courier: 'Awaiting your confirmation',
                badgeText: 'Needs OK',
                badgeBg: const Color(0xFFFEF3C7),
                badgeColor: const Color(0xFFB45309),
                dotColor: const Color(0xFFD97706),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String orderId,
    required String detail,
    required String courier,
    required String badgeText,
    required Color badgeBg,
    required Color badgeColor,
    required Color dotColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    orderId,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '· $detail',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                courier,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4.5.w,
                  height: 4.5.w,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  badgeText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 11. TRUST & SERVICE BADGES
  // ===========================================================================
  Widget _buildTrustBadgesSection() {
    final features = [
      {
        'icon': Icons.verified_user_outlined,
        'title': '100% Genuine',
        'desc': 'Optical Certified',
      },
      {
        'icon': Icons.bolt_outlined,
        'title': '24h Surfacing',
        'desc': 'In-house Rx Lab',
      },
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Fast Delivery',
        'desc': 'Insured Courier',
      },
      {
        'icon': Icons.credit_score_outlined,
        'title': 'Credit Terms',
        'desc': '30-Day Pay Later',
      },
    ];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: features.map((f) {
          return Column(
            children: [
              Icon(
                f['icon'] as IconData,
                size: 22.sp,
                color: AppColors.primaryDark,
              ),
              SizedBox(height: 4.h),
              Text(
                f['title'] as String,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                f['desc'] as String,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
