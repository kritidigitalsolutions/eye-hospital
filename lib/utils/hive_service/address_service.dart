import 'package:hive/hive.dart';

class AddressService {
  static final box = Hive.box('addressBox');

  /// Get all addresses
  static List<Map<String, dynamic>> getAddresses() {
    final data = box.get('addresses', defaultValue: []);

    return (data as List)
        .map((e) => (e as Map).cast<String, dynamic>())
        .toList();
  }

  /// Save full list
  static Future<void> saveAddresses(List<Map<String, dynamic>> list) async {
    await box.put('addresses', list);
  }

  /// Add new address
  static Future<void> addAddress(Map<String, dynamic> newAddress) async {
    final box = Hive.box('addressBox');

    List list = box.get('addresses', defaultValue: []);

    /// ✅ CHECK DUPLICATE
    bool alreadyExists = list.any(
      (e) =>
          e["phone"] == newAddress["phone"] &&
          e["address"] == newAddress["address"] &&
          e["zip"] == newAddress["zip"],
    );

    if (alreadyExists) {
      print("Address already exists ❌");
      return; // stop saving
    }

    /// Remove previous default
    for (var e in list) {
      e["isDefault"] = false;
    }

    list.add(newAddress);

    await box.put('addresses', list);
  }

  /// Set default address
  static Future<void> setDefault(String id) async {
    final list = getAddresses();

    for (var e in list) {
      e["isDefault"] = e["id"] == id;
    }

    await saveAddresses(list);
  }

  /// Get default address
  static Map<String, dynamic>? getDefaultAddress() {
    final list = getAddresses();
    try {
      return list.firstWhere((e) => e["isDefault"] == true);
    } catch (e) {
      return null;
    }
  }

  /// Update address
  static Future<void> updateAddress(
    String id,
    Map<String, dynamic> updated,
  ) async {
    final list = getAddresses();

    final index = list.indexWhere((e) => e["id"] == id);
    if (index != -1) {
      list[index] = updated;
    }

    await saveAddresses(list);
  }

  // delete address

  static Future<void> deleteAddress(String id) async {
    final box = Hive.box('addressBox');

    List list = box.get('addresses', defaultValue: []);

    list.removeWhere((e) => e["id"] == id);

    /// If deleted default → set first as default
    if (list.isNotEmpty && !list.any((e) => e["isDefault"] == true)) {
      list[0]["isDefault"] = true;
    }

    await box.put('addresses', list);
  }
}
