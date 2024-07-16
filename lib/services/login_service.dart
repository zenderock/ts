import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_vision/utils/helpers/token.dart';

class Login {
  final String message;
  final User user;
  final String accessToken;

  Login({
    required this.message,
    required this.user,
    required this.accessToken,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
    );
  }
}

class User {
  final String id;
  final String uuid;
  final String civilite;
  final String lastname;
  final String firstname;
  final String role;
  final String agence;
  final String telephone;
  final String email;
  final String state;
  final String lastConnexion;
  final String updatedAt;
  final String createdAt;
  final String roleId;
  final String roleNom;
  final String roleDesc;
  final String agNom;
  final String agAdresse;
  final String agContact;
  final String agEmail;
  final String agType;
  final String tagNom;
  final String tagIcon;
  final String profilUser;

  User({
    required this.id,
    required this.uuid,
    required this.civilite,
    required this.lastname,
    required this.firstname,
    required this.role,
    required this.agence,
    required this.telephone,
    required this.email,
    required this.state,
    required this.lastConnexion,
    required this.updatedAt,
    required this.createdAt,
    required this.roleId,
    required this.roleNom,
    required this.roleDesc,
    required this.agNom,
    required this.agAdresse,
    required this.agContact,
    required this.agEmail,
    required this.agType,
    required this.tagNom,
    required this.tagIcon,
    required this.profilUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      uuid: json['uuid'] ?? '',
      civilite: json['civilite'] ?? '',
      lastname: json['lastname'] ?? '',
      firstname: json['firstname'] ?? '',
      role: json['role'] ?? '',
      agence: json['agence'] ?? '',
      telephone: json['telephone'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      lastConnexion: json['last_connexion'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      roleId: json['roleId'] ?? '',
      roleNom: json['roleNom'] ?? '',
      roleDesc: json['roleDesc'] ?? '',
      agNom: json['agNom'] ?? '',
      agAdresse: json['agAdresse'] ?? '',
      agContact: json['agContact'] ?? '',
      agEmail: json['agEmail'] ?? '',
      agType: json['agType'] ?? '',
      tagNom: json['tagNom'] ?? '',
      tagIcon: json['tagIcon'] ?? '',
      profilUser: json['profilUser'] ?? '',
    );
  }
}

class LoginService {
  static const String apiUrl =
      'https://app-demo.tejispro.com/auth/mobile-login';

  static Future<Login?> login(String email, String password) async {
    try {
      final String token = await AccountToken().getToken();
      final response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'password': password,
      }, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        print("login : ${response.body}");
        // Si la requête est réussie, désérialisez la réponse JSON en un objet Login
        return Login.fromJson(jsonDecode(response.body));
      } else {
        // En cas d'échec de la requête, imprimez le message d'erreur de la réponse
        return null;
      }
    } catch (e) {
      // En cas d'erreur, imprimez l'exception
      return null;
    }
  }
}
