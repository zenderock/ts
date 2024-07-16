import 'package:shared_preferences/shared_preferences.dart';

class AccountToken {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    final String token = prefs.getString("token") ?? "";
    return token;
  }

  final String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImxlZmluZGV4QGdtYWlsLmNvbSIsImlhdCI6MTcxMDQzMDIyNCwiZXhwIjoxNzEwNjAzMDI0fQ.GaQOmZOfz_Jw1k-dFhOj7BZfdAOT7ZcNAqHkgWnAM90";

  Future<String> getDefaultToken() async {
    return _token;
  }
}
