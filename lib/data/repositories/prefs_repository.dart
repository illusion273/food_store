import 'dart:convert';

import 'package:food_store/data/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {
  Future<Location?> getPrefLocation() async {
    final prefs = await SharedPreferences.getInstance();
    var locationFromSp = prefs.getString("pref_location");
    return locationFromSp != null
        ? Location.fromJson(jsonDecode(locationFromSp))
        : null;
  }

  void setPrefLocation(Location prefLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("pref_location", jsonEncode(prefLocation));
  }
}
