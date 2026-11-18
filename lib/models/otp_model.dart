class OtpModel {
  final bool success;
  final String message;
  final String mobileNumber;
  final String phone;
  final bool isRegistered;
  final String action;
  final int expiresInSeconds;
  final int resendAfterSeconds;

  OtpModel({
    required this.success,
    required this.message,
    required this.mobileNumber,
    required this.phone,
    required this.isRegistered,
    required this.action,
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      phone: json['phone'] ?? '',
      isRegistered: json['is_registered'] ?? false,
      action: json['action'] ?? '',
      expiresInSeconds: json['expires_in_seconds'] ?? 0,
      resendAfterSeconds: json['resend_after_seconds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'mobile_number': mobileNumber,
      'phone': phone,
      'is_registered': isRegistered,
      'action': action,
      'expires_in_seconds': expiresInSeconds,
      'resend_after_seconds': resendAfterSeconds,
    };
  }
}
