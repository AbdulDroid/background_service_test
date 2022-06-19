import 'package:shared_preferences/shared_preferences.dart';

abstract class Preferences {
  bool hasToken();
  Future<void> saveTokenToPrefs({required String value});
  Future<String?> getTokenFromPrefs();
  Future<void> removeTokenFromPrefs();
  Future<int> getNewBornsCreated();
  Future<void> updateNewBornCount();
}

class PreferencesImpl implements Preferences {
  static const String AUTH_KEY = "authToken";
  static const String CREATED_COUNT = "newbornCount";

  SharedPreferences prefs;

  PreferencesImpl({required this.prefs});

  @override
  bool hasToken() {
    return prefs.containsKey(AUTH_KEY);
  }

  @override
  Future<String?> getTokenFromPrefs() async {
    return prefs.getString(AUTH_KEY);
  }

  @override
  Future<void> saveTokenToPrefs({required String value}) async {
    await prefs.setString(AUTH_KEY, value);
  }

  @override
  Future<void> removeTokenFromPrefs() async {
    if (hasToken()) {
      await prefs.remove(AUTH_KEY);
    }
  }

  @override
  Future<int> getNewBornsCreated() async {
    return prefs.getInt(CREATED_COUNT) ?? 0;
  }

  @override
  Future<void> updateNewBornCount() async {
    final currentCount = await getNewBornsCreated();
    await prefs.setInt(CREATED_COUNT, currentCount + 1);
  }
}
