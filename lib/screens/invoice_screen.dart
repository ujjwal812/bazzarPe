import 'package:flutter/material.dart';

/// Modern, Clean & Modular Invoice Screen
class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  void _showToast(BuildContext context, String message) {
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
                const _InvoiceHeaderAppBar(),

                // 2. Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BazaarPe Branding Banner Card
                        const _BazaarPeBrandingBanner(),

                        const SizedBox(height: 18),

                        // Invoice Number & Order Date Meta Info Row
                        const _InvoiceMetaInfo(
                          invoiceNumber: '#INV-2025-0045',
                          orderId: '#BM123456',
                          date: '12 Apr 2025',
                        ),

                        const SizedBox(height: 16),

                        // User & Vendor Details Card
                        const _UserAndVendorDetailsCard(
                          userName: 'Ujjwal Kumar',
                          userPhone: '+91 98765 43210',
                          vendorName: 'Rohit Kumar',
                          vehicleNo: 'KA 01 AB 1334',
                        ),

                        const SizedBox(height: 16),

                        // Billing Breakdown Table Card
                        const _BillingBreakdownTableCard(
                          itemDescription: 'Aluminium Scrap',
                          weight: '24.8 kg',
                          itemAmount: '₹ 2,800',
                          gstAmount: '₹ 140',
                          totalAmount: '₹ 3,200',
                        ),

                        const SizedBox(height: 20),

                        // Download PDF Button
                        _DownloadPdfBottomButton(
                          onTap: () => _showToast(context, 'Downloading Invoice PDF...'),
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
class _InvoiceHeaderAppBar extends StatelessWidget {
  const _InvoiceHeaderAppBar();

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
          const Text(
            'Invoice',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

/// BazaarPe Branding Header Banner
class _BazaarPeBrandingBanner extends StatelessWidget {
  const _BazaarPeBrandingBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE2FAF2),
            Color(0xFFA7F3D0),
            Color(0xFF6EE7B7),
          ],
        ),
        border: Border.all(color: const Color(0xFF34D399), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2610B981),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -10,
            top: -10,
            child: Opacity(
              opacity: 0.3,
              child: const Icon(Icons.eco_rounded, size: 70, color: Color(0xFF059669)),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.3,
              child: const Icon(Icons.eco_rounded, size: 70, color: Color(0xFF059669)),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.eco_rounded, color: Color(0xFF047857), size: 32),
                  SizedBox(width: 8),
                  Text(
                    'BAZAARPE',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Recycle for a Better Tomorrow',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF047857),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF047857),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Invoice Meta Info (Number, Order ID, Date)
class _InvoiceMetaInfo extends StatelessWidget {
  final String invoiceNumber;
  final String orderId;
  final String date;

  const _InvoiceMetaInfo({
    required this.invoiceNumber,
    required this.orderId,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice $invoiceNumber',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Order ID: ',
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  TextSpan(
                    text: orderId,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 15,
                  color: Color(0xFF10B981),
                ),
                const SizedBox(width: 6),
                Text(
                  'Date: $date',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// User & Vendor Details Card
class _UserAndVendorDetailsCard extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String vendorName;
  final String vehicleNo;

  const _UserAndVendorDetailsCard({
    required this.userName,
    required this.userPhone,
    required this.vendorName,
    required this.vehicleNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          // User Details Row
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2FAF2),
                ),
                child: const Icon(Icons.person_outline_rounded, color: Color(0xFF059669), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Details',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userPhone,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Color(0xFFE2E8F0), height: 1),
          ),

          // Vendor Details Row
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2FAF2),
                ),
                child: const Icon(Icons.storefront_outlined, color: Color(0xFF059669), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vendor Details',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vendorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF059669),
                          ),
                          child: const Icon(Icons.local_shipping_rounded, size: 10, color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          vehicleNo,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Itemized Billing Breakdown Table Card
class _BillingBreakdownTableCard extends StatelessWidget {
  final String itemDescription;
  final String weight;
  final String itemAmount;
  final String gstAmount;
  final String totalAmount;

  const _BillingBreakdownTableCard({
    required this.itemDescription,
    required this.weight,
    required this.itemAmount,
    required this.gstAmount,
    required this.totalAmount,
  });

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
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Weight',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Amount',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Item Row 1
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    itemDescription,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    weight,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    itemAmount,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                ),
              ],
            ),
          ),

          // Item Row 2 (GST)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: const [
                Expanded(
                  flex: 5,
                  child: Text(
                    'GST (5%)',
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '₹ 140',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Total Amount Highlight Box
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE2FAF2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    totalAmount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF059669),
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

/// Download PDF Button
class _DownloadPdfBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DownloadPdfBottomButton({required this.onTap});

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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_download_outlined, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text(
              'Download PDF',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
