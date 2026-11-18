import 'package:flutter/material.dart';

/// Modern, Clean & Responsive Vendor Details & Live Location Screen
class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  bool _isOrderStatusExpanded = true;

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
                const _VendorHeaderAppBar(),

                // 2. Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        // Vendor Profile Header Card
                        _VendorProfileCard(
                          name: 'Rohit Kumar',
                          rating: '4.8',
                          reviewsCount: 126,
                          imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
                          onCallTap: () => _showToast('Calling Rohit Kumar...'),
                          onChatTap: () => _showToast('Opening chat with Rohit...'),
                        ),

                        const SizedBox(height: 14),

                        // Live Map Container
                        const _LiveMapContainer(),

                        const SizedBox(height: 14),

                        // Vehicle Number & Distance Card
                        const _VehicleAndDistanceCard(
                          vehicleNo: 'KA 01 AB 1234',
                          distanceText: '4.2 km away',
                        ),

                        const SizedBox(height: 14),

                        // Order Status Stepper Card
                        _OrderStatusCard(
                          isExpanded: _isOrderStatusExpanded,
                          onToggleExpand: () {
                            setState(() {
                              _isOrderStatusExpanded = !_isOrderStatusExpanded;
                            });
                          },
                        ),

                        const SizedBox(height: 14),

                        // Need Help? Card
                        _NeedHelpCard(
                          onTap: () => _showToast('Contacting Vendor Support...'),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // 3. Bottom Call Vendor Button
                _CallVendorBottomButton(
                  onTap: () => _showToast('Initiating call with Rohit Kumar...'),
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

/// Top Header App Bar with Back Button & Responsive Title
class _VendorHeaderAppBar extends StatelessWidget {
  const _VendorHeaderAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
          const SizedBox(width: 10),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Vendor Details & ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    TextSpan(
                      text: 'Live Location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Vendor Profile Header Card
class _VendorProfileCard extends StatelessWidget {
  final String name;
  final String rating;
  final int reviewsCount;
  final String imageUrl;
  final VoidCallback onCallTap;
  final VoidCallback onChatTap;

  const _VendorProfileCard({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.onCallTap,
    required this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
      child: Row(
        children: [
          // Vendor Image with Verified Badge
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF10B981), width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFCBD5E1),
                  backgroundImage: NetworkImage(imageUrl),
                  child: const Icon(Icons.person_rounded, size: 36, color: Color(0xFF64748B)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Vendor Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.verified_user_rounded, size: 13, color: Color(0xFFF59E0B)),
                    SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        'Verified Vendor',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 15, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        '($reviewsCount Reviews)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // Action Buttons: Call & Chat
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onCallTap,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF059669),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33059669),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.phone_rounded, color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onChatTap,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF10B981),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3310B981),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Live Tracking Map Box Widget
class _LiveMapContainer extends StatelessWidget {
  const _LiveMapContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
        color: const Color(0xFFEAF8F1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A10B981),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          size: Size.infinite,
          painter: _VendorLiveMapPainter(),
        ),
      ),
    );
  }
}

/// Custom Painter to draw Live Map with Route, Waypoints & Truck Badges
class _VendorLiveMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final secondaryRoadPaint = Paint()
      ..color = const Color(0x80FFFFFF)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), secondaryRoadPaint);
    canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width, size.height * 0.75), secondaryRoadPaint);
    canvas.drawLine(Offset(size.width * 0.25, 0), Offset(size.width * 0.25, size.height), secondaryRoadPaint);
    canvas.drawLine(Offset(size.width * 0.65, 0), Offset(size.width * 0.65, size.height), secondaryRoadPaint);

    final routePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePath = Path();
    routePath.moveTo(size.width * 0.22, size.height * 0.4);
    routePath.lineTo(size.width * 0.38, size.height * 0.6);
    routePath.lineTo(size.width * 0.58, size.height * 0.35);
    routePath.lineTo(size.width * 0.78, size.height * 0.25);

    canvas.drawPath(routePath, roadPaint);
    canvas.drawPath(routePath, routePaint);

    final startPos = Offset(size.width * 0.22, size.height * 0.4);
    canvas.drawCircle(startPos, 18, Paint()..color = const Color(0x332563EB));
    canvas.drawCircle(startPos, 10, Paint()..color = const Color(0xFF2563EB));
    canvas.drawCircle(startPos, 4, Paint()..color = Colors.white);

    final endPos = Offset(size.width * 0.78, size.height * 0.25);
    canvas.drawCircle(endPos, 16, Paint()..color = const Color(0x33EF4444));
    canvas.drawCircle(endPos, 9, Paint()..color = const Color(0xFFEF4444));

    _drawWaypoint(canvas, Offset(size.width * 0.31, size.height * 0.3));
    _drawWaypoint(canvas, Offset(size.width * 0.44, size.height * 0.48));

    _drawTruckBadge(canvas, Offset(size.width * 0.48, size.height * 0.45));
    _drawTruckBadge(canvas, Offset(size.width * 0.69, size.height * 0.3));
  }

  void _drawWaypoint(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 7, Paint()..color = const Color(0xFFF59E0B));
    canvas.drawCircle(offset, 3, Paint()..color = Colors.white);
  }

  void _drawTruckBadge(Canvas canvas, Offset center) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 28, height: 22),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect, Paint()..color = const Color(0xFF059669));
    canvas.drawRRect(
      rect,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke,
    );

    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: '🚚',
        style: TextStyle(fontSize: 13),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - 8, center.dy - 9));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Vehicle Number & Distance Details Card
class _VehicleAndDistanceCard extends StatelessWidget {
  final String vehicleNo;
  final String distanceText;

  const _VehicleAndDistanceCard({
    required this.vehicleNo,
    required this.distanceText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vehicle No Section
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEFF6FF),
                  ),
                  child: const Icon(Icons.local_shipping_outlined, color: Color(0xFF2563EB), size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Vehicle No.',
                        style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        vehicleNo,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Vertical Divider Line
          Container(
            height: 28,
            width: 1,
            color: const Color(0xFFE2E8F0),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),

          // Distance Section
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEFF6FF),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: Color(0xFF2563EB), size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: distanceText.split(' ').first,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF059669),
                            ),
                          ),
                          TextSpan(
                            text: ' ${distanceText.split(' ').skip(1).join(' ')}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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

/// Order Status Stepper Accordion Card
class _OrderStatusCard extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const _OrderStatusCard({
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggleExpand,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF64748B),
                  size: 24,
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: const [
              Icon(Icons.circle, color: Color(0xFF10B981), size: 10),
              SizedBox(width: 8),
              Text(
                'Vendor On The Way',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          if (isExpanded) ...[
            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatusStepNode(
                  icon: Icons.check_rounded,
                  title: 'Assigned',
                  isCompleted: true,
                  isCurrent: false,
                ),
                _StatusStepLine(isCompleted: true),
                _StatusStepNode(
                  icon: Icons.local_shipping_rounded,
                  title: 'On Way',
                  isCompleted: true,
                  isCurrent: true,
                ),
                _StatusStepLine(isCompleted: false),
                _StatusStepNode(
                  icon: Icons.location_on_rounded,
                  title: 'Reached',
                  isCompleted: false,
                  isCurrent: false,
                ),
                _StatusStepLine(isCompleted: false),
                _StatusStepNode(
                  icon: Icons.inventory_2_rounded,
                  title: 'Pickup',
                  isCompleted: false,
                  isCurrent: false,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Stepper Node Circle & Title
class _StatusStepNode extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCompleted;
  final bool isCurrent;

  const _StatusStepNode({
    required this.icon,
    required this.title,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final color = (isCompleted || isCurrent) ? const Color(0xFF059669) : const Color(0xFF94A3B8);
    final circleColor = (isCompleted || isCurrent) ? const Color(0xFF10B981) : const Color(0xFFCBD5E1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            border: Border.all(
              color: isCurrent ? const Color(0xFF059669) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: (isCompleted || isCurrent) ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// Line segment connecting stepper nodes
class _StatusStepLine extends StatelessWidget {
  final bool isCompleted;

  const _StatusStepLine({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        margin: const EdgeInsets.only(bottom: 18),
        color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
      ),
    );
  }
}

/// Need Help? Support Tile
class _NeedHelpCard extends StatelessWidget {
  final VoidCallback onTap;

  const _NeedHelpCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEFF6FF),
                  ),
                  child: const Icon(Icons.headset_mic_rounded, color: Color(0xFF2563EB), size: 22),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Contact Vendor',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom Call Vendor Button
class _CallVendorBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CallVendorBottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
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
              borderRadius: BorderRadius.circular(27),
            ),
          ),
          onPressed: onTap,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'Call Vendor',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
