import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/otp_model.dart';
import '../utils/api_endpoint.dart';

class ApiServices {
  /// Send OTP to user's mobile number
  static Future<OtpModel> sendOtp({required String mobileNumber}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoint.sendOtp),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'mobile_number': mobileNumber,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OtpModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to send OTP (${response.statusCode})');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format from server');
      }
      rethrow;
    }
  }

  /// Register new user with full registration details
  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String mobileNumber,
    String? email,
    required String address,
    required String pincode,
    required String city,
    required String otp,
    bool acceptPrivacy = true,
    String privacyVersion = "2026.1",
    bool acceptTerms = true,
    String termsVersion = "2026.1",
  }) async {
    try {
      final bodyData = <String, dynamic>{
        'full_name': fullName,
        'mobile_number': mobileNumber,
        if (email != null && email.isNotEmpty) 'email': email,
        'address': address,
        'pincode': pincode,
        'city': city,
        'otp': otp,
        'accept_privacy': acceptPrivacy,
        'privacy_version': privacyVersion,
        'accept_terms': acceptTerms,
        'terms_version': termsVersion,
      };

      final response = await http.post(
        Uri.parse(ApiEndpoint.register),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Registration failed (${response.statusCode})');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format from server');
      }
      rethrow;
    }
  }
}
