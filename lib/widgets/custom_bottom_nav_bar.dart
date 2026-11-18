import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Reusable 5-item Bottom Navigation Bar with Smooth Silk Fade Tab Transitions
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onTabSelected,
  });

  void _smoothNavigate(BuildContext context, String routeName) {
    final targetWidgetBuilder = AppRoutes.routes[routeName];
    if (targetWidgetBuilder == null) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetWidgetBuilder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  void _handleTabTap(BuildContext context, int index) {
    if (onTabSelected != null) {
      onTabSelected!(index);
    }

    if (index == 0 && selectedIndex != 0) {
      _smoothNavigate(context, AppRoutes.home);
    } else if (index == 1 && selectedIndex != 1) {
      _smoothNavigate(context, AppRoutes.tracking);
    } else if (index == 2) {
      // Center Floating Button (+) -> Create Pickup
      Navigator.pushNamed(context, AppRoutes.pickup);
    } else if (index == 3 && selectedIndex != 3) {
      _smoothNavigate(context, AppRoutes.notifications);
    } else if (index == 4 && selectedIndex != 4) {
      _smoothNavigate(context, AppRoutes.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 0: Home
            _NavTile(
              icon: Icons.home_rounded,
              label: 'Home',
              isSelected: selectedIndex == 0,
              onTap: () => _handleTabTap(context, 0),
            ),

            // 1: Orders
            _NavTile(
              icon: Icons.assignment_outlined,
              label: 'Orders',
              isSelected: selectedIndex == 1,
              onTap: () => _handleTabTap(context, 1),
            ),

            // 2: Center Floating (+) Action Button
            GestureDetector(
              onTap: () => _handleTabTap(context, 2),
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF34D399), Color(0xFF059669)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4010B981),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
              ),
            ),

            // 3: Notifications
            _NavTile(
              icon: Icons.notifications_none_rounded,
              label: 'Notifications',
              badgeCount: 3,
              isSelected: selectedIndex == 3,
              onTap: () => _handleTabTap(context, 3),
            ),

            // 4: Profile / Settings
            _NavTile(
              icon: Icons.person_rounded,
              label: 'Profile',
              isSelected: selectedIndex == 4,
              onTap: () => _handleTabTap(context, 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF059669) : const Color(0xFF94A3B8);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badgeCount > 0)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 16,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF059669),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
