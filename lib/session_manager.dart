import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _tokenKey = 'token';
  static const _teacherIdKey = 'teacher_id';

  static const String _keyCampaignId = 'campaign_id';

  static Future<void> saveCampaignId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCampaignId, id);
  }

  static Future<int?> getCampaignId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyCampaignId);
  }

  static Future<void> clearCampaignId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCampaignId);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> setTeacherId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_teacherIdKey, id);
  }

  static Future<int?> getTeacherId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_teacherIdKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveSelectedCampaignId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_campaign_id', id);
  }

  static Future<int?> getSelectedCampaignId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('selected_campaign_id');
  }
}
