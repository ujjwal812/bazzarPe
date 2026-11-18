import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int _currentStepIndex = 4; // "Pickup In Progress" active

  final List<Map<String, String>> _timelineSteps = [
    {"title": "Order Confirmed", "time": "10:24 AM"},
    {"title": "Vendor Assigned", "time": "10:42 AM"},
    {"title": "On the Way", "time": "11:05 AM"},
    {"title": "Reached Location", "time": "11:20 AM"},
    {"title": "Pickup In Progress", "time": "11:35 AM"},
    {"title": "Completed – Awaiting Payment", "time": ""},
    {"title": "Pending", "time": ""},
  ];

  void _onStepTap(int index) {
    if (index >= 5) {
      Navigator.pushReplacementNamed(context, AppRoutes.completed);
    } else {
      setState(() {
        _currentStepIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF7),
      body: Stack(
        children: [
          // Leaf background accents
          Positioned(
            top: -10,
            right: -20,
            child: Opacity(
              opacity: 0.18,
              child: Transform.rotate(
                angle: 0.5,
                child: const Icon(
                  Icons.eco_rounded,
                  size: 160,
                  color: Color(0xFF10B981),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -20,
            child: Opacity(
              opacity: 0.15,
              child: Transform.rotate(
                angle: -0.4,
                child: const Icon(
                  Icons.eco_rounded,
                  size: 150,
                  color: Color(0xFF10B981),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -30,
            child: Opacity(
              opacity: 0.12,
              child: Transform.rotate(
                angle: 0.3,
                child: const Icon(
                  Icons.eco_rounded,
                  size: 130,
                  color: Color(0xFF10B981),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar (< Order Tracking - #BM12456)
                  Row(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Order ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Tracking',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '#BM12456',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Main Tracking Card Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
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
                        // Vendor Assigned Header Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2FAF2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD1FAE5),
                                ),
                                child: const Icon(Icons.person_rounded, color: Color(0xFF059669), size: 18),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Vendor Assigned',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF047857),
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF059669), size: 14),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Assigned Vendor Info Row
                        Row(
                          children: [
                            // Avatar with Verified Badge
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFFDE68A), width: 2),
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Color(0xFFFEF3C7),
                                    backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
                                    ),
                                    child: Icon(Icons.person_rounded, size: 38, color: Color(0xFFD97706)),
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
                                    color: Color(0xFF2563EB),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(width: 12),

                            // Vendor Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Assigned Vendor',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Rohit Kumar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '+91 98765 43210',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Action Buttons: Call & Chat
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
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
                                  child: IconButton(
                                    icon: const Icon(Icons.phone_rounded, color: Colors.white, size: 20),
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 44,
                                  height: 44,
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
                                  child: IconButton(
                                    icon: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Map View Container
                        Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFA7F3D0)),
                            color: const Color(0xFFE0F2FE),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: Size.infinite,
                                  painter: _TrackingMapPainter(),
                                ),

                                // Distance Badge Pill
                                Positioned(
                                  top: 12,
                                  left: 110,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF064E3B),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x33000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                                        SizedBox(width: 4),
                                        Text(
                                          '3.4 km away',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Vertical Timeline List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _timelineSteps.length,
                          itemBuilder: (context, index) {
                            final isCompleted = index <= _currentStepIndex;
                            final step = _timelineSteps[index];

                            return InkWell(
                              onTap: () => _onStepTap(index),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Step Circle & Vertical Connector Line
                                    Column(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isCompleted ? const Color(0xFF059669) : Colors.white,
                                            border: Border.all(
                                              color: isCompleted ? const Color(0xFF059669) : const Color(0xFFCBD5E1),
                                              width: 2,
                                            ),
                                          ),
                                          child: isCompleted
                                              ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                                              : Container(
                                                  margin: const EdgeInsets.all(6),
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFF94A3B8),
                                                  ),
                                                ),
                                        ),
                                        if (index < _timelineSteps.length - 1)
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: index < _currentStepIndex
                                                ? const Color(0xFF059669)
                                                : const Color(0xFFE2E8F0),
                                          ),
                                      ],
                                    ),

                                    const SizedBox(width: 14),

                                    // Title & Timestamp
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              step["title"]!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
                                                color: isCompleted ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                                              ),
                                            ),
                                            if (step["time"]!.isNotEmpty)
                                              Text(
                                                step["time"]!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF64748B),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
    );
  }
}

// Custom Painter for Map view with road grid, route, truck badge & location labels
class _TrackingMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background Grid / Map roads
    final gridPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Secondary Map Roads
    canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.25), gridPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), gridPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), gridPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), gridPaint);

    // Map Labels: Indiranagar, Koramangala, HSR Layout
    final textStyle = const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600);
    _drawText(canvas, 'Indiranagar', Offset(size.width * 0.52, size.height * 0.2), textStyle);
    _drawText(canvas, 'Koramangala', Offset(size.width * 0.65, size.height * 0.7), textStyle);
    _drawText(canvas, 'HSR Layout', Offset(size.width * 0.72, size.height * 0.88), textStyle);

    // Main Route Line
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePath = Path();
    routePath.moveTo(size.width * 0.45, size.height * 0.85);
    routePath.lineTo(size.width * 0.52, size.height * 0.75);
    routePath.lineTo(size.width * 0.58, size.height * 0.65);
    routePath.lineTo(size.width * 0.62, size.height * 0.45);
    routePath.lineTo(size.width * 0.76, size.height * 0.25);

    // Draw White Road Base
    canvas.drawPath(routePath, roadPaint);
    // Draw Blue Route Line
    canvas.drawPath(routePath, routePaint);

    // Pickup Start Circle (Green ring)
    canvas.drawCircle(
      Offset(size.width * 0.45, size.height * 0.85),
      9,
      Paint()..color = const Color(0xFF10B981),
    );
    canvas.drawCircle(
      Offset(size.width * 0.45, size.height * 0.85),
      4,
      Paint()..color = Colors.white,
    );

    // Destination Pin (Red Location Pin)
    final pinCenter = Offset(size.width * 0.76, size.height * 0.25);
    canvas.drawCircle(
      pinCenter,
      8,
      Paint()..color = const Color(0xFFEF4444),
    );

    // Delivery Truck Badge Graphic
    final truckPos = Offset(size.width * 0.6, size.height * 0.52);
    final truckRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: truckPos, width: 28, height: 24),
      const Radius.circular(6),
    );
    canvas.drawRRect(truckRect, Paint()..color = Colors.white);
    canvas.drawRRect(
      truckRect,
      Paint()
        ..color = const Color(0xFF059669)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    final TextPainter truckPainter = TextPainter(
      text: const TextSpan(
        text: '🚚',
        style: TextStyle(fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    truckPainter.layout();
    truckPainter.paint(canvas, Offset(truckPos.dx - 8, truckPos.dy - 10));
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
