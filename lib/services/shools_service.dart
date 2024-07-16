import "package:http/http.dart" as http;
import "dart:convert";

import "package:the_vision/utils/helpers/token.dart";

class School {
  final String nom;
  final String offreBourse;
  final String? dureeEtudeCandidature;
  final String testDeLangueRequis;
  final String debutPeriodeAdmission;
  final String finPeriodeAdmission;
  final String siteWeb;
  final String nomPays;
  final String flagUrl;
  final String? rentree;
  final String? campus;
  final String? logo;

  School({
    required this.nom,
    required this.offreBourse,
    required this.dureeEtudeCandidature,
    required this.testDeLangueRequis,
    required this.debutPeriodeAdmission,
    required this.finPeriodeAdmission,
    required this.siteWeb,
    required this.nomPays,
    required this.flagUrl,
    required this.rentree,
    required this.campus,
    required this.logo,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      nom: json['nom'],
      offreBourse: json['offre_bourse'],
      dureeEtudeCandidature: json['duree_etude_candidature'],
      testDeLangueRequis: json['test_de_langue_requis'],
      debutPeriodeAdmission: json['debut_periode_admission'],
      finPeriodeAdmission: json['fin_periode_admission'],
      siteWeb: json['site_web'],
      nomPays: json['nomPays'],
      flagUrl: json['flag_url'],
      rentree: json['rentree'],
      campus: json['campus'],
      logo: json['logo'],
    );
  }
}

class SchoolsService {
  Future<List<School>> getSchools() async {
    final uri = Uri.parse("https://app-demo.tejispro.com/mobile/get-schools");
    try {
      final String token = await AccountToken().getToken();
      final response = await http.post(uri, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<School> schoolsList = [];
        for (var i = 0; i < jsonData["data"].length; i++) {
          print(jsonData);
          schoolsList.add(School.fromJson(jsonData["data"][i]));
        }
        return schoolsList;
      } else {
        throw Exception("Une erreur est survenue${response.body}");
      }
    } catch (e) {
      throw Exception("Une erreur est survenue $e");
    }
  }
}
