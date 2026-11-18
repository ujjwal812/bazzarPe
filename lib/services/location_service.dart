class LocationService {
  Future<String> getCurrentLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    return "New Delhi, India";
  }
}
