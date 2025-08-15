import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_local_repo.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepo authLocalRepo(Ref ref) {
  return AuthLocalRepo();
}

class AuthLocalRepo {
  late SharedPreferences _sharedPreferences;
  Future<void> init() async {
    debugPrint('Init shared preferences called.');
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) {
    if (token != null) {
      debugPrint('Saving token in local storage: $token');
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  String? getToken() {
    debugPrint('Get token from local storage called.');
    return _sharedPreferences.getString('x-auth-token');
  }
}
