class PickupModel {
  final String id;
  final String address;
  final String status;
  final DateTime dateTime;

  PickupModel({
    required this.id,
    required this.address,
    required this.status,
    required this.dateTime,
  });

  factory PickupModel.fromJson(Map<String, dynamic> json) {
    return PickupModel(
      id: json['id'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] ?? 'Pending',
      dateTime: DateTime.tryParse(json['dateTime'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'status': status,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
