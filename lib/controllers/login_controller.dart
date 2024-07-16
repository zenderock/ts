import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'package:the_vision/services/login_service.dart';
import 'package:the_vision/utils/helpers/token.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isError = false;

  Future<bool> loginWithEmail() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await AccountToken().getDefaultToken()}',
    };

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      try {
        var url = Uri.parse("https://app-demo.tejispro.com/auth/mobile-login");
        Map body = {
          "email": emailController.text,
          "password": passwordController.text,
        };

        http.Response response =
            await http.post(url, body: body, headers: headers);
        if (response.statusCode == 200) {
          final login = Login.fromJson(jsonDecode(response.body));
          final SharedPreferences prefs = await _prefs;
          await prefs.setString("token", login.accessToken);
          await prefs.setString("firstname", login.user.firstname);
          await prefs.setString("lastname", login.user.lastname);
          await prefs.setString("phone", login.user.telephone);
          await prefs.setString("email", login.user.email);
          await prefs.setString("role", login.user.roleNom);
          await prefs.setString("avatar", login.user.profilUser);
          emailController.clear();
          passwordController.clear();
          return true;
        } else {
          throw Exception("Une erreur est survenue: ${response.body}");
        }
      } catch (e) {
        return false;
      }
    }
  }
}
