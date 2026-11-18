class PickupService {
  Future<bool> createPickup(String address) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
