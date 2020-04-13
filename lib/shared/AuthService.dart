import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {
  final FacebookLogin facebookLogin = FacebookLogin();

  Future<void> logout() async {
    return facebookLogin.logOut();
  }

  Future<FacebookAccessToken> currentAccessToken() async {
    return facebookLogin.currentAccessToken;
  }

  Future<String> getUserId() async {
    var accessToken = await facebookLogin.currentAccessToken;
    return 'F' + accessToken.userId;
  }

  Future<bool> isLoggedIn() async {
    return facebookLogin.isLoggedIn;
  }

  Future<FacebookLoginResult> login() {
    return facebookLogin.logIn(['email']);
  }
}
