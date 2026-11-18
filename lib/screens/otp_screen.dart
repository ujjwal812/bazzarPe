import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<String> _otp = ['', '', '', '', '', ''];

  void _onKeyPress(String val) {
    setState(() {
      for (int i = 0; i < _otp.length; i++) {
        if (_otp[i].isEmpty) {
          _otp[i] = val;
          break;
        }
      }
    });

    if (_otp.every((element) => element.isNotEmpty)) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.privacy);
        }
      });
    }
  }

  void _onBackspace() {
    setState(() {
      for (int i = _otp.length - 1; i >= 0; i--) {
        if (_otp[i].isNotEmpty) {
          _otp[i] = '';
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = (ModalRoute.of(context)?.settings.arguments as String?) ?? '9876543210';

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF7),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back (<) & Scan Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 44,
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
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
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
                      icon: const Icon(Icons.crop_free_rounded, size: 22, color: Color(0xFF0F172A)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Top Shield & Leaf Banner Graphic
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: _HeaderWaveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF8CE3AA),
                          Color(0xFF34D399),
                        ],
                      ),
                    ),
                  ),
                ),
                // Shield Lock Icon
                Container(
                  width: 76,
                  height: 86,
                  decoration: const BoxDecoration(
                    color: Color(0xFF059669),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(38),
                      bottomRight: Radius.circular(38),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_rounded,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Title: Verify OTP
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Verify ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  TextSpan(
                    text: 'OTP',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Enter the 6-digit code sent to',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '+91 $phoneNumber',
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // 6 OTP Input Boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 48,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _otp[index].isNotEmpty
                            ? const Color(0xFF10B981)
                            : const Color(0xFFA7F3D0),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A10B981),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      _otp[index],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // Resend Timer Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '00:45',
                  style: TextStyle(
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('|', style: TextStyle(color: Color(0xFFCBD5E1))),
                ),
                Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Custom On-Screen Numeric Keypad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFE2FAF2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _KeypadKey(text: '1', onTap: () => _onKeyPress('1')),
                      _KeypadKey(text: '2', onTap: () => _onKeyPress('2')),
                      _KeypadKey(text: '3', onTap: () => _onKeyPress('3')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _KeypadKey(text: '4', onTap: () => _onKeyPress('4')),
                      _KeypadKey(text: '5', onTap: () => _onKeyPress('5')),
                      _KeypadKey(text: '6', onTap: () => _onKeyPress('6')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _KeypadKey(text: '7', onTap: () => _onKeyPress('7')),
                      _KeypadKey(text: '8', onTap: () => _onKeyPress('8')),
                      _KeypadKey(text: '9', onTap: () => _onKeyPress('9')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _KeypadKey(
                        icon: Icons.home_rounded,
                        onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                      ),
                      _KeypadKey(text: '0', onTap: () => _onKeyPress('0')),
                      _KeypadKey(
                        icon: Icons.backspace_outlined,
                        onTap: _onBackspace,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeypadKey extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;

  const _KeypadKey({this.text, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: icon != null
                ? Icon(icon, color: const Color(0xFF0F172A), size: 22)
                : Text(
                    text!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
