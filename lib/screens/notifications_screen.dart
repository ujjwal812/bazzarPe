import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_bottom_nav_bar.dart';

/// Modern, Clean & Modular Notifications Screen
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _todayNotifications = [
    {
      'id': '1',
      'icon': Icons.local_shipping_rounded,
      'title': 'Vendor Rohit Kumar Assigned',
      'subtitle': 'Rohit Kumar is on the way for order #BM12456.',
      'time': '10:42 AM',
      'isUnread': true,
      'route': AppRoutes.tracking,
    },
    {
      'id': '2',
      'icon': Icons.check_circle_rounded,
      'title': 'Pickup Order Confirmed',
      'subtitle': 'Your pickup for Metal Scrap is confirmed for 10:00 AM - 12:00 PM.',
      'time': '10:24 AM',
      'isUnread': true,
      'route': AppRoutes.pickup,
    },
    {
      'id': '3',
      'icon': Icons.trending_up_rounded,
      'title': 'Scrap Rate Update!',
      'subtitle': 'Copper rate updated to ₹450/kg (+12%). Recycle now to earn more.',
      'time': '09:15 AM',
      'isUnread': true,
      'route': AppRoutes.vendor,
    },
  ];

  final List<Map<String, dynamic>> _earlierNotifications = [
    {
      'id': '4',
      'icon': Icons.account_balance_wallet_rounded,
      'title': 'Payment Received - ₹ 3,200',
      'subtitle': 'Payout for Order #BM123456 credited successfully to your account.',
      'time': 'Yesterday, 04:30 PM',
      'isUnread': false,
      'route': AppRoutes.invoice,
    },
    {
      'id': '5',
      'icon': Icons.star_rounded,
      'title': 'Order #BM123456 Completed',
      'subtitle': 'Thank you for recycling! You saved 24.8 kg CO2 carbon footprint.',
      'time': 'Yesterday, 04:15 PM',
      'isUnread': false,
      'route': AppRoutes.completed,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _todayNotifications) {
        n['isUnread'] = false;
      }
      for (var n in _earlierNotifications) {
        n['isUnread'] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All notifications marked as read'),
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
                // 1. Top App Bar Header
                _NotificationsHeaderAppBar(
                  onMarkReadTap: _markAllAsRead,
                ),

                // 2. Notifications Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section: Today
                        const _NotificationSectionHeader(title: 'TODAY'),
                        const SizedBox(height: 8),

                        ..._todayNotifications.map((n) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: _NotificationCard(
                              icon: n['icon'] as IconData,
                              title: n['title'] as String,
                              subtitle: n['subtitle'] as String,
                              time: n['time'] as String,
                              isUnread: n['isUnread'] as bool,
                              onTap: () {
                                setState(() => n['isUnread'] = false);
                                Navigator.pushNamed(context, n['route'] as String);
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 14),

                        // Section: Earlier
                        const _NotificationSectionHeader(title: 'EARLIER'),
                        const SizedBox(height: 8),

                        ..._earlierNotifications.map((n) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: _NotificationCard(
                              icon: n['icon'] as IconData,
                              title: n['title'] as String,
                              subtitle: n['subtitle'] as String,
                              time: n['time'] as String,
                              isUnread: n['isUnread'] as bool,
                              onTap: () {
                                setState(() => n['isUnread'] = false);
                                Navigator.pushNamed(context, n['route'] as String);
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // 3. Bottom Navigation Bar with Floating Center (+) Button
                const CustomBottomNavigationBar(selectedIndex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Background Leaf Decorations
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
          bottom: 80,
          left: -30,
          child: Opacity(
            opacity: 0.12,
            child: Transform.rotate(
              angle: -0.6,
              child: const Icon(
                Icons.eco_rounded,
                size: 140,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Top Header App Bar
class _NotificationsHeaderAppBar extends StatelessWidget {
  final VoidCallback onMarkReadTap;

  const _NotificationsHeaderAppBar({required this.onMarkReadTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Notifi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    TextSpan(
                      text: 'cations',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: onMarkReadTap,
            child: const Text(
              'Read All',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section Category Header Title
class _NotificationSectionHeader extends StatelessWidget {
  final String title;

  const _NotificationSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }
}

/// Individual Notification Card
class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFE2FAF2) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnread ? const Color(0xFFA7F3D0) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isUnread ? const Color(0xFF10B981) : const Color(0xFFE2FAF2),
                  ),
                  child: Icon(
                    icon,
                    color: isUnread ? Colors.white : const Color(0xFF059669),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: 6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF475569),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
