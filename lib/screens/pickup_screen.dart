import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final String _address = "123 Green Park, Sector 12, Bangalore";
  String _selectedCategory = "Metal";
  String _selectedSubtype = "Aluminium";
  int _selectedWeight = 25;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTimeSlot = "10:00 AM - 12:00 PM";
  final TextEditingController _notesController = TextEditingController(text: "Please handle with care.");

  final Map<String, List<String>> _subtypesMap = {
    "Metal": ["Aluminium", "Iron", "Copper", "Brass", "Steel"],
    "Plastic/Paper": ["Cardboard", "Newspaper", "PET Bottles", "Hard Plastic"],
    "Electronics": ["Monitor / TV", "Washing Machine", "Refrigerator", "AC Unit"],
    "E-waste": ["Mobile Phones", "Laptops / Computer", "Batteries", "Circuit Boards"],
  };

  final Map<String, int> _rateMap = {
    "Aluminium": 128,
    "Iron": 35,
    "Copper": 450,
    "Brass": 310,
    "Steel": 45,
    "Cardboard": 14,
    "Newspaper": 18,
    "PET Bottles": 22,
    "Hard Plastic": 16,
    "Monitor / TV": 350,
    "Washing Machine": 850,
    "Refrigerator": 1200,
    "AC Unit": 2200,
    "Mobile Phones": 150,
    "Laptops / Computer": 500,
    "Batteries": 80,
    "Circuit Boards": 120,
  };

  final List<int> _weightOptions = [5, 10, 15, 20, 25, 30, 40, 50, 75, 100];

  final List<String> _timeSlots = [
    "08:00 AM - 10:00 AM",
    "10:00 AM - 12:00 PM",
    "12:00 PM - 02:00 PM",
    "02:00 PM - 04:00 PM",
    "04:00 PM - 06:00 PM",
  ];

  int get _calculatedPrice {
    final rate = _rateMap[_selectedSubtype] ?? 128;
    return rate * _selectedWeight;
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF10B981),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onProceedToReview() {
    Navigator.pushNamed(context, AppRoutes.verification);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> currentSubtypes = _subtypesMap[_selectedCategory] ?? ["Aluminium"];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar (< Create Pickup Order)
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
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Create ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: 'Pickup Order',
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

              const SizedBox(height: 16),

              // Step Tracker Card (1 Details -> 2 Review -> 3 Done)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A10B981),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StepItem(stepNumber: '1', title: 'Details', isActive: true),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: const Color(0xFF10B981),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    _StepItem(stepNumber: '2', title: 'Review', isActive: false),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: const Color(0xFFE2E8F0),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    _StepItem(stepNumber: '3', title: 'Done', isActive: false),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Section Title: Pickup Details
              Row(
                children: const [
                  Icon(Icons.eco_rounded, color: Color(0xFF10B981), size: 24),
                  SizedBox(width: 6),
                  Text(
                    'Pickup Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Field 1: Pickup Address *
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A10B981),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE2FAF2),
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Color(0xFF059669), size: 22),
                  ),
                  title: const Row(
                    children: [
                      Text('Pickup Address ', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      Text('*', style: TextStyle(fontSize: 12, color: Colors.redAccent)),
                    ],
                  ),
                  subtitle: Text(
                    _address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEFF6FF),
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Color(0xFF2563EB), size: 18),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Field 2: Item Category *
              _FormDropdownCard<String>(
                icon: Icons.recycling_rounded,
                label: 'Item Category *',
                value: _selectedCategory,
                items: _subtypesMap.keys.toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedCategory = val;
                      _selectedSubtype = _subtypesMap[val]!.first;
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Field 3: Item Sub-type
              _FormDropdownCard<String>(
                icon: Icons.layers_rounded,
                label: 'Item Sub-type',
                value: _selectedSubtype,
                items: currentSubtypes,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedSubtype = val;
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Field 4: Approximate Weight (kg) *
              _FormDropdownCard<int>(
                icon: Icons.scale_rounded,
                label: 'Approximate Weight (kg) *',
                value: _selectedWeight,
                items: _weightOptions,
                displayTextBuilder: (val) => '$val',
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedWeight = val;
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Field 5 & 6 Row: Pickup Date * & Preferred Time Slot *
              Row(
                children: [
                  // Pickup Date
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A10B981),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE2FAF2),
                              ),
                              child: const Icon(Icons.calendar_month_rounded, color: Color(0xFF059669), size: 20),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Pickup Date *', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${_selectedDate.day} ${_monthName(_selectedDate.month)} ${_selectedDate.year}',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Time Slot
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A10B981),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE2FAF2),
                            ),
                            child: const Icon(Icons.access_time_rounded, color: Color(0xFF059669), size: 18),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Preferred Time *', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedTimeSlot,
                                    isExpanded: true,
                                    isDense: true,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                                    onChanged: (val) {
                                      if (val != null) setState(() => _selectedTimeSlot = val);
                                    },
                                    items: _timeSlots.map((slot) => DropdownMenuItem(value: slot, child: Text(slot, overflow: TextOverflow.ellipsis))).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Field 7: Notes (Optional)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A10B981),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE2FAF2),
                      ),
                      child: const Icon(Icons.description_rounded, color: Color(0xFF059669), size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Notes (Optional)', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                          TextField(
                            controller: _notesController,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 2),
                              border: InputBorder.none,
                              hintText: 'Add instructions...',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Estimated Price Banner Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE2FAF2), Color(0xFFA7F3D0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: const Color(0xFF6EE7B7)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x2610B981),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF10B981),
                      ),
                      child: const Icon(Icons.monetization_on_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimated Price (Including GST)',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF047857)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹ ${_formatNumber(_calculatedPrice)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Full-width Next: Review Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
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
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: _onProceedToReview,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next: Review',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatNumber(int num) {
    return num.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

class _StepItem extends StatelessWidget {
  final String stepNumber;
  final String title;
  final bool isActive;

  const _StepItem({
    required this.stepNumber,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF059669) : const Color(0xFFE2E8F0),
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF059669) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

class _FormDropdownCard<T> extends StatelessWidget {
  final IconData icon;
  final String label;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)? displayTextBuilder;

  const _FormDropdownCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.displayTextBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A10B981),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE2FAF2),
            ),
            child: Icon(icon, color: const Color(0xFF059669), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    value: value,
                    isExpanded: true,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                    onChanged: onChanged,
                    items: items.map<DropdownMenuItem<T>>((T item) {
                      final text = displayTextBuilder != null ? displayTextBuilder!(item) : item.toString();
                      return DropdownMenuItem<T>(
                        value: item,
                        child: Text(text),
                      );
                    }).toList(),
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
