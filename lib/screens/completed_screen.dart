import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Modern, Clean & Modular Completed Screen
class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  int _rating = 5; // Default 5 stars like in design

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

  void _onSubmitReview() {
    _showToast('Thank you for rating your vendor!');
    Navigator.pushReplacementNamed(context, AppRoutes.home);
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
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Hero Success Banner Graphic
                        const _HeroSuccessBanner(),

                        const SizedBox(height: 16),

                        // Order Summary 2x2 Grid Card
                        const _OrderSummaryGridCard(
                          orderId: '#BM123456',
                          finalWeight: '24.8 kg',
                          category: '24.8 kg',
                          totalPrice: '₹ 3,200',
                        ),

                        const SizedBox(height: 14),

                        // Pickup Proof Card with Photos & View Invoice Button
                        _PickupProofCard(
                          onViewInvoiceTap: () {
                            Navigator.pushNamed(context, AppRoutes.invoice);
                          },
                        ),

                        const SizedBox(height: 14),

                        // Rate Your Vendor Card
                        _RateVendorCard(
                          currentRating: _rating,
                          onRatingChanged: (newRating) {
                            setState(() => _rating = newRating);
                          },
                          onAddReviewTap: () => _showToast('Add review comment section'),
                        ),

                        const SizedBox(height: 16),

                        // Submit Review Button
                        _SubmitReviewBottomButton(
                          onTap: _onSubmitReview,
                        ),

                        const SizedBox(height: 16),
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
          left: -20,
          child: Opacity(
            opacity: 0.15,
            child: Transform.rotate(
              angle: -0.4,
              child: const Icon(
                Icons.eco_rounded,
                size: 160,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ),
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

/// Hero Banner Graphic for Pickup Completed
class _HeroSuccessBanner extends StatelessWidget {
  const _HeroSuccessBanner();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Glowing Checkmark Circle with Celebratory Rays
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Aura Glow Ring
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD1FAE5),
              ),
            ),

            // Checkmark Circle Badge
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF34D399),
                    Color(0xFF059669),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4010B981),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 56,
              ),
            ),

            // Celebratory Floating Leaf Accents
            Positioned(
              top: 0,
              right: 10,
              child: Opacity(
                opacity: 0.9,
                child: Transform.rotate(
                  angle: 0.5,
                  child: const Icon(Icons.eco_rounded, color: Color(0xFF10B981), size: 24),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 10,
              child: Opacity(
                opacity: 0.9,
                child: Transform.rotate(
                  angle: -0.6,
                  child: const Icon(Icons.eco_rounded, color: Color(0xFF10B981), size: 22),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Title: Pickup Completed!
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Pickup ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              TextSpan(
                text: 'Completed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Your scrap has been collected successfully.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Order Summary 2x2 Grid Card
class _OrderSummaryGridCard extends StatelessWidget {
  final String orderId;
  final String finalWeight;
  final String category;
  final String totalPrice;

  const _OrderSummaryGridCard({
    required this.orderId,
    required this.finalWeight,
    required this.category,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Row 1: Order ID & Final Weight
          Row(
            children: [
              Expanded(
                child: _SummaryGridTile(
                  icon: Icons.assignment_outlined,
                  label: 'Order ID',
                  value: orderId,
                ),
              ),
              Container(width: 1, height: 45, color: const Color(0xFFE2E8F0)),
              Expanded(
                child: _SummaryGridTile(
                  icon: Icons.scale_rounded,
                  label: 'Final Weight',
                  value: finalWeight,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(color: Color(0xFFE2E8F0), height: 1),
          ),

          // Row 2: Location/Weight & Total Price
          Row(
            children: [
              Expanded(
                child: _SummaryGridTile(
                  icon: Icons.location_on_rounded,
                  label: '',
                  value: category,
                  showLabel: false,
                ),
              ),
              Container(width: 1, height: 45, color: const Color(0xFFE2E8F0)),
              Expanded(
                child: _SummaryGridTile(
                  icon: Icons.currency_rupee_rounded,
                  label: '',
                  value: totalPrice,
                  showLabel: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryGridTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showLabel;

  const _SummaryGridTile({
    required this.icon,
    required this.label,
    required this.value,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE2FAF2),
            ),
            child: Icon(icon, color: const Color(0xFF059669), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showLabel && label.isNotEmpty) ...[
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
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
    );
  }
}

/// Pickup Proof Photo Thumbnails Card + View Invoice Button
class _PickupProofCard extends StatelessWidget {
  final VoidCallback onViewInvoiceTap;

  const _PickupProofCard({required this.onViewInvoiceTap});

  @override
  Widget build(BuildContext context) {
    final List<String> proofImages = [
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?q=80&w=200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1504917599217-d4dc5ebe6122?q=80&w=200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=200&auto=format&fit=crop',
    ];

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
          // Header Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Pickup Proof',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Color(0xFF64748B),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Photo Thumbnails Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: proofImages.map((url) {
              return Expanded(
                child: Container(
                  height: 76,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF1F5F9),
                          child: const Icon(Icons.image_rounded, color: Color(0xFF94A3B8)),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // View Invoice Button
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
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
                  color: Color(0x3310B981),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: onViewInvoiceTap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'View Invoice',
                    style: TextStyle(
                      fontSize: 15,
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
    );
  }
}

/// Rate Your Vendor Card Widget
class _RateVendorCard extends StatelessWidget {
  final int currentRating;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onAddReviewTap;

  const _RateVendorCard({
    required this.currentRating,
    required this.onRatingChanged,
    required this.onAddReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
        children: [
          const Text(
            'Rate Your Vendor',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 10),

          // Interactive 5 Star Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: () => onRatingChanged(starIndex),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    starIndex <= currentRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: const Color(0xFFF59E0B),
                    size: 36,
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 8),

          GestureDetector(
            onTap: onAddReviewTap,
            child: const Text(
              'Add Review (Optional)',
              style: TextStyle(
                fontSize: 13,
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

/// Bottom Submit Review Button
class _SubmitReviewBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SubmitReviewBottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: onTap,
        child: const Text(
          'Submit Review',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
