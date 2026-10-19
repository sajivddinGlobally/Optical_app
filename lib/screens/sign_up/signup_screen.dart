import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optical_app/core/constants/app_colors.dart';
import 'package:optical_app/core/widgets/dashed_border_box.dart';
import 'package:optical_app/screens/sign_up/account_review_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0; // 0: Step 1, 1: Step 2, 2: Step 3

  // Step 1 Controllers & States
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _landlineController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _sameAsMobile = true;

  // Step 2 Controllers & States
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  String _selectedState = 'Maharashtra';
  String _selectedCity = 'Pune';

  // Step 3 Controllers & States
  final TextEditingController _panNoController = TextEditingController();
  final TextEditingController _aadhaarNoController = TextEditingController();
  final TextEditingController _gstNoController = TextEditingController();
  bool _acceptPolicies = false;

  // Document upload states
  String _panFileName = 'pan_card.jpg';
  String _panFileSize = '148 KB · uploaded';
  bool _panUploaded = true;

  String? _aadhaarFileName;
  String? _aadhaarFileSize;
  bool _aadhaarUploaded = false;

  String? _visitingCardFileName;
  String? _visitingCardFileSize;
  bool _visitingCardUploaded = false;

  final List<String> _stepTitles = [
    'Your details',
    'Shop details',
    'Documents',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _customerNameController.dispose();
    _contactPersonController.dispose();
    _mobileController.dispose();
    _whatsappController.dispose();
    _landlineController.dispose();
    _emailController.dispose();
    _companyNameController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _panNoController.dispose();
    _aadhaarNoController.dispose();
    _gstNoController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onBack() {
    if (_currentStep > 0) {
      _goToStep(_currentStep - 1);
    } else {
      Navigator.of(context).pop();
    }
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
        backgroundColor: const Color(0xFFf4f6fa),
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              _buildProgressStepper(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    setState(() {
                      _currentStep = page;
                    });
                  },
                  children: [
                    _buildStepOne(),
                    _buildStepTwo(),
                    _buildStepThree(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar
  // ---------------------------------------------------------------------------
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
                InkWell(
                  onTap: _onBack,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 24.sp,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Sign up',
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
                'Help',
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

  // ---------------------------------------------------------------------------
  // Stepper Header
  // ---------------------------------------------------------------------------
  Widget _buildProgressStepper() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
      child: Column(
        children: [
          // 3-segment progress indicator
          Row(
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0) SizedBox(width: 6.w),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 3.5.h,
                    decoration: BoxDecoration(
                      color: i <= _currentStep
                          ? AppColors.primaryDark
                          // : const Color(0xFFE2E8F0),
                          : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of 3',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                _stepTitles[_currentStep],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 1: Tell us about you
  // ---------------------------------------------------------------------------
  Widget _buildStepOne() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us about you',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 18.h),

                // Customer full name
                _buildFieldLabel('Customer full name'),
                _buildTextField(
                  controller: _customerNameController,
                  hintText: 'Enter full name',
                ),

                SizedBox(height: 14.h),

                // Contact person *
                _buildFieldLabel('Contact person *'),
                _buildTextField(
                  controller: _contactPersonController,
                  hintText: 'Enter contact person',
                ),

                SizedBox(height: 14.h),

                // Mobile *
                _buildFieldLabel('Mobile *'),
                _buildTextField(
                  controller: _mobileController,
                  hintText: 'Enter mobile number',
                  keyboardType: TextInputType.phone,
                  isHighlighted: true,
                ),
                SizedBox(height: 4.h),
                Text(
                  'We send order updates on this number',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),

                SizedBox(height: 14.h),

                // WhatsApp
                _buildFieldLabel('WhatsApp'),
                _buildTextField(
                  controller: _whatsappController,
                  hintText: 'Enter WhatsApp number',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 8.h),

                // Checkbox: Same as mobile number
                InkWell(
                  onTap: () {
                    setState(() {
                      _sameAsMobile = !_sameAsMobile;
                      if (_sameAsMobile) {
                        _whatsappController.text = _mobileController.text;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(4.r),
                  child: Row(
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          color: _sameAsMobile
                              ? AppColors.primaryDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: _sameAsMobile
                                ? AppColors.primaryDark
                                : const Color(0xFFCBD5E1),
                            width: 1.5.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: _sameAsMobile
                            ? Icon(
                                Icons.check,
                                size: 13.sp,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Same as mobile number',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // Landline
                _buildFieldLabel('Landline'),
                _buildTextField(
                  controller: _landlineController,
                  hintText: 'Enter landline no. (optional)',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // Email ID
                _buildFieldLabel('Email ID'),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Enter email address',
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 14.h),

                // Profile photo upload area
                _buildFieldLabel('Profile photo'),
                _buildUploadDashedBox(),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Bottom Continue button
        _buildBottomButtonRow(
          onContinue: () => _goToStep(1),
          continueText: 'Continue',
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Tell us about your shop
  // ---------------------------------------------------------------------------
  Widget _buildStepTwo() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us about your shop',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 18.h),

                // Company name *
                _buildFieldLabel('Company name *'),
                _buildTextField(
                  controller: _companyNameController,
                  hintText: 'Enter company name',
                ),

                SizedBox(height: 14.h),

                // Row of State & City
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('State *'),
                          _buildDropdownField(
                            value: _selectedState,
                            items: const [
                              'Maharashtra',
                              'Gujarat',
                              'Delhi',
                              'Karnataka',
                              'Tamil Nadu',
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedState = val);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('City *'),
                          _buildDropdownField(
                            value: _selectedCity,
                            items: const [
                              'Pune',
                              'Mumbai',
                              'Nagpur',
                              'Nashik',
                              'Thane',
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedCity = val);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // Address
                _buildFieldLabel('Address'),
                _buildTextField(
                  controller: _addressController,
                  hintText: 'Enter shop address',
                ),

                SizedBox(height: 14.h),

                // Pin code
                _buildFieldLabel('Pin code'),
                _buildTextField(
                  controller: _pincodeController,
                  hintText: 'Enter 6 digit pincode',
                  keyboardType: TextInputType.number,
                  isHighlighted: true,
                ),
                SizedBox(height: 4.h),
                Text(
                  '6 digits',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),

                SizedBox(height: 18.h),

                // City missing help note
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 17.sp,
                      color: const Color(0xFF475569),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Pick your city from the list. If it is missing, type it and our team will add it.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5.sp,
                          color: const Color(0xFF475569),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Bottom Action buttons (Back + Continue)
        _buildBottomButtonRow(
          onBack: () => _goToStep(0),
          onContinue: () => _goToStep(2),
          continueText: 'Continue',
          hasBack: true,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Upload your documents
  // ---------------------------------------------------------------------------
  Widget _buildStepThree() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload your documents',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 18.h),
                // PAN no.
                _buildFieldLabel('PAN no.'),
                _buildTextField(
                  controller: _panNoController,
                  hintText: 'Enter PAN number',
                ),
                SizedBox(height: 14.h),
                // PAN image *
                _buildFieldLabel('PAN image *'),
                if (_panUploaded)
                  _buildUploadedCard(
                    fileName: _panFileName,
                    fileSize: _panFileSize,
                    onChange: () => _showDocumentUploadBottomSheet(
                      docName: 'PAN Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _panFileName = name;
                          _panFileSize = size;
                          _panUploaded = true;
                        });
                      },
                    ),
                  )
                else
                  _buildUploadDashedBox(
                    onTap: () => _showDocumentUploadBottomSheet(
                      docName: 'PAN Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _panFileName = name;
                          _panFileSize = size;
                          _panUploaded = true;
                        });
                      },
                    ),
                  ),
                SizedBox(height: 14.h),
                // Aadhaar card no.
                _buildFieldLabel('Aadhaar card no.'),
                _buildTextField(
                  controller: _aadhaarNoController,
                  hintText: 'Enter Aadhaar card number',
                ),
                SizedBox(height: 14.h),
                // Aadhaar card image *
                _buildFieldLabel('Aadhaar card image *'),
                if (_aadhaarUploaded)
                  _buildUploadedCard(
                    fileName: _aadhaarFileName ?? 'aadhaar_card.jpg',
                    fileSize: _aadhaarFileSize ?? '155 KB · uploaded',
                    onChange: () => _showDocumentUploadBottomSheet(
                      docName: 'Aadhaar Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _aadhaarFileName = name;
                          _aadhaarFileSize = size;
                          _aadhaarUploaded = true;
                        });
                      },
                    ),
                  )
                else
                  _buildUploadDashedBox(
                    onTap: () => _showDocumentUploadBottomSheet(
                      docName: 'Aadhaar Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _aadhaarFileName = name;
                          _aadhaarFileSize = size;
                          _aadhaarUploaded = true;
                        });
                      },
                    ),
                  ),

                SizedBox(height: 14.h),

                // Visiting card *
                _buildFieldLabel('Visiting card *'),
                if (_visitingCardUploaded)
                  _buildUploadedCard(
                    fileName: _visitingCardFileName ?? 'visiting_card.jpg',
                    fileSize: _visitingCardFileSize ?? '138 KB · uploaded',
                    onChange: () => _showDocumentUploadBottomSheet(
                      docName: 'Visiting Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _visitingCardFileName = name;
                          _visitingCardFileSize = size;
                          _visitingCardUploaded = true;
                        });
                      },
                    ),
                  )
                else
                  _buildUploadDashedBox(
                    onTap: () => _showDocumentUploadBottomSheet(
                      docName: 'Visiting Card',
                      onUploaded: (name, size) {
                        setState(() {
                          _visitingCardFileName = name;
                          _visitingCardFileSize = size;
                          _visitingCardUploaded = true;
                        });
                      },
                    ),
                  ),

                SizedBox(height: 14.h),

                // GST number (if registered)
                _buildFieldLabel('GST number (if registered)'),
                _buildTextField(
                  controller: _gstNoController,
                  hintText: 'Enter GST number',
                ),

                SizedBox(height: 16.h),

                // Acceptance Policy Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _acceptPolicies = !_acceptPolicies;
                          });
                        },
                        borderRadius: BorderRadius.circular(4.r),
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          margin: EdgeInsets.only(top: 2.h),
                          decoration: BoxDecoration(
                            color: _acceptPolicies
                                ? AppColors.primaryDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: _acceptPolicies
                                  ? AppColors.primaryDark
                                  : const Color(0xFF94A3B8),
                              width: 1.5.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _acceptPolicies
                              ? Icon(
                                  Icons.check,
                                  size: 13.sp,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By continuing, I accept all policies. My documents are used only to verify my account.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5.sp,
                                color: const Color(0xFF334155),
                                height: 1.35,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              'Read the privacy policy',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Bottom Submit button
        _buildBottomButtonRow(
          onContinue: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AccountReviewScreen()),
            );
          },
          continueText: 'Submit',
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helper Form Widgets
  // ---------------------------------------------------------------------------
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E293B),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isHighlighted = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 13.5.h,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13.sp,
          color: const Color(0xFF94A3B8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primaryDark, width: 1.5.w),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 22.sp,
            color: const Color(0xFF64748B),
          ),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          items: items.map((e) {
            return DropdownMenuItem<String>(value: e, child: Text(e));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildUploadedCard({
    required String fileName,
    required String fileSize,
    required VoidCallback onChange,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.check,
              size: 20.sp,
              color: const Color(0xFF16A34A),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  fileSize,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onChange,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Change',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadDashedBox({VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: DashedBorderBox(
        borderRadius: 10.r,
        // backgroundColor: const Color(0xFFF8FAFC),
        backgroundColor: Color(0xffe9ecf2),
        color: const Color(0xFFCBD5E1),
        dashLength: 5,
        gap: 3.5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Column(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.file_upload_outlined,
                  size: 20.sp,
                  color: const Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Upload a file or take a photo',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'JPG, PNG or PDF · max 200 KB',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDocumentUploadBottomSheet({
    required String docName,
    required Function(String fileName, String fileSize) onUploaded,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upload $docName',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 22.sp,
                        color: const Color(0xFF64748B),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Choose source to upload your file (max 200 KB)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 18.h),
                _buildUploadOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take photo / Camera',
                  subtitle: 'Capture document directly with camera',
                  onTap: () {
                    Navigator.pop(ctx);
                    final safeName =
                        '${docName.toLowerCase().replaceAll(' ', '_')}_photo.jpg';
                    onUploaded(safeName, '176 KB · uploaded');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$docName captured & uploaded!',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        backgroundColor: AppColors.primaryDark,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                _buildUploadOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle: 'Select image from device photos',
                  onTap: () {
                    Navigator.pop(ctx);
                    final safeName =
                        '${docName.toLowerCase().replaceAll(' ', '_')}_image.jpg';
                    onUploaded(safeName, '184 KB · uploaded');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$docName uploaded from gallery!',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        backgroundColor: AppColors.primaryDark,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                _buildUploadOption(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Upload PDF / Document',
                  subtitle: 'Select PDF file up to 200 KB',
                  onTap: () {
                    Navigator.pop(ctx);
                    final safeName =
                        '${docName.toLowerCase().replaceAll(' ', '_')}.pdf';
                    onUploaded(safeName, '142 KB · uploaded');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$docName PDF uploaded successfully!',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        backgroundColor: AppColors.primaryDark,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20.sp, color: AppColors.primaryDark),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonRow({
    VoidCallback? onBack,
    required VoidCallback onContinue,
    required String continueText,
    bool hasBack = false,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (hasBack) ...[
            SizedBox(
              width: 95.w,
              height: 48.h,
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E293B),
                  side: BorderSide(color: const Color(0xFFCBD5E1), width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Back',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  continueText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.1,
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
