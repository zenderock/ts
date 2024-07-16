import "package:http/http.dart" as http;
import "dart:convert";

import "package:the_vision/utils/helpers/token.dart";

class Partner {
  final String id;
  final String nom;
  final String adresse;
  final String contact;
  final String email;
  final String responsable;
  final String type;
  final String niu;
  final String logo;
  final String reduction;
  final String state;
  final String motif;
  final String updatedAt;
  final String createdAt;
  final String nomRespo;
  final String prenomRespo;
  final String telRespo;
  final String emailRespo;
  final String libelle;

  Partner({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.contact,
    required this.email,
    required this.responsable,
    required this.type,
    required this.niu,
    required this.logo,
    required this.reduction,
    required this.state,
    required this.motif,
    required this.updatedAt,
    required this.createdAt,
    required this.nomRespo,
    required this.prenomRespo,
    required this.telRespo,
    required this.emailRespo,
    required this.libelle,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      adresse: json['adresse'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      responsable: json['responsable'] ?? '',
      type: json['type'] ?? '',
      niu: json['niu'] ?? '',
      logo: json['logo'] ?? '',
      reduction: json['reduction'] ?? '',
      state: json['state'] ?? '',
      motif: json['motif'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      nomRespo: json['nomRespo'] ?? '',
      prenomRespo: json['prenomRespo'] ?? '',
      telRespo: json['telRespo'] ?? '',
      emailRespo: json['emailRespo'] ?? '',
      libelle: json['libelle'] ?? '',
    );
  }
}

class PartnersService {
  Future<List<Partner>> getPartners() async {
    final uri = Uri.parse("https://app-demo.tejispro.com/mobile/get-partners");
    try {
      final String token = await AccountToken().getToken();
      final response = await http.post(uri, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Partner> partnersList = [];
        for (var i = 0; i < jsonData["data"].length; i++) {
          partnersList.add(Partner.fromJson(jsonData["data"][i]));
        }
        return partnersList;
      } else {
        throw Exception("Une erreur est survenue");
      }
    } catch (e) {
      throw Exception("Une erreur est survenue");
    }
  }
}
