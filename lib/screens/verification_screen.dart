import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routes/app_routes.dart';

/// Modern, Clean & Modular Pickup Verification Screen
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendSeconds = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Fill pre-filled example OTP like in design (2, 4, 8, 7, 5, 6)
    const initialOtp = ['2', '4', '8', '7', '5', '6'];
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].text = initialOtp[i];
    }
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _resendSeconds = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onVerifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      _showToast('Please enter complete 6-digit OTP');
      return;
    }

    _showToast('OTP Verified Successfully!');
    Navigator.pushReplacementNamed(context, AppRoutes.tracking);
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF7),
      body: Stack(
        children: [
          // Background Leaf Aesthetics
          const _BackgroundLeafDecorations(),

          SafeArea(
            child: Column(
              children: [
                // 1. Top Header App Bar
                const _VerificationHeaderAppBar(),

                // 2. Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Column(
                      children: [
                        // Hero Agent Illustration Banner
                        const _PickupAgentHeroIllustration(),

                        const SizedBox(height: 16),

                        // Main Verification Form Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1A10B981),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Title Instruction
                              const Text(
                                'Enter OTP provided by User',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),

                              const SizedBox(height: 18),

                              // 6-Digit OTP Boxes Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 44,
                                    height: 52,
                                    child: TextField(
                                      controller: _otpControllers[index],
                                      focusNode: _focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding: EdgeInsets.zero,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Color(0xFFA7F3D0), width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
                                        ),
                                        fillColor: const Color(0xFFF8FAFC),
                                        filled: true,
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          _focusNodes[index + 1].requestFocus();
                                        } else if (value.isEmpty && index > 0) {
                                          _focusNodes[index - 1].requestFocus();
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),

                              const SizedBox(height: 20),

                              // Verify OTP Button
                              Container(
                                width: double.infinity,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF34D399),
                                      Color(0xFF059669),
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x4010B981),
                                      blurRadius: 12,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                  ),
                                  onPressed: _onVerifyOtp,
                                  child: const Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Resend OTP Countdown Timer
                              GestureDetector(
                                onTap: _resendSeconds == 0 ? _startTimer : null,
                                child: Column(
                                  children: [
                                    Text(
                                      _resendSeconds > 0
                                          ? 'Resend OTP (00:${_resendSeconds.toString().padLeft(2, '0')})'
                                          : 'Resend OTP Now',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _resendSeconds > 0 ? const Color(0xFF059669) : const Color(0xFF2563EB),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 18,
                                      color: Color(0xFF059669),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Upload Photos & Weight Instructions Box
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE2FAF2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFFA7F3D0)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFD1FAE5),
                                      ),
                                      child: const Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: Color(0xFF059669),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'After verification, please upload pickup photos and final weight.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF475569),
                                          height: 1.3,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Decorative background leaf elements
class _BackgroundLeafDecorations extends StatelessWidget {
  const _BackgroundLeafDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -20,
          right: -20,
          child: Opacity(
            opacity: 0.15,
            child: Transform.rotate(
              angle: 0.4,
              child: const Icon(
                Icons.eco_rounded,
                size: 160,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: -25,
          child: Opacity(
            opacity: 0.15,
            child: Transform.rotate(
              angle: -0.5,
              child: const Icon(
                Icons.eco_rounded,
                size: 150,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: -25,
          child: Opacity(
            opacity: 0.15,
            child: Transform.rotate(
              angle: 0.5,
              child: const Icon(
                Icons.eco_rounded,
                size: 150,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Top Header App Bar with Back Button & Title
class _VerificationHeaderAppBar extends StatelessWidget {
  const _VerificationHeaderAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF059669)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Pickup ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                TextSpan(
                  text: 'Verification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Hero Agent Illustration Banner
class _PickupAgentHeroIllustration extends StatelessWidget {
  const _PickupAgentHeroIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Light Green Glow Aura Circle
          Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0xFFD1FAE5),
                  Color(0xFFE2FAF2),
                  Color(0x00F4FBF7),
                ],
              ),
            ),
          ),

          // Central Agent Avatar Graphic
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF10B981),
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3310B981),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person_pin_rounded,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),

          // Speech Bubble with Checkmark Badge (Top Right)
          Positioned(
            top: 15,
            right: 45,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF10B981),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4010B981),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          // Floating Leaf Accents around Illustration
          Positioned(
            top: 25,
            left: 35,
            child: Opacity(
              opacity: 0.8,
              child: Transform.rotate(
                angle: -0.4,
                child: const Icon(Icons.eco_rounded, size: 28, color: Color(0xFF10B981)),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            right: 35,
            child: Opacity(
              opacity: 0.8,
              child: Transform.rotate(
                angle: 0.6,
                child: const Icon(Icons.eco_rounded, size: 32, color: Color(0xFF10B981)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
