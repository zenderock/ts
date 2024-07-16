import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_vision/utils/helpers/token.dart';

class DetailFolderResponse {
  final String message;
  final int status;
  final DetailFolderData data;

  DetailFolderResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DetailFolderResponse.fromJson(Map<String, dynamic> json) {
    return DetailFolderResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      data: DetailFolderData.fromJson(json['data'] ?? {}),
    );
  }
}

class DetailFolderData {
  final Folder folder;
  final List<Destination> destinations;
  final List<Filiere> filieres;
  final List<DocumentFolder> documents;
  final List<InfosSupp> infosSupp;
  final List<MotifPayment> motifPayments;
  final String? montantPaid;
  final double percentPayment;

  DetailFolderData({
    required this.folder,
    required this.destinations,
    required this.filieres,
    required this.documents,
    required this.infosSupp,
    required this.motifPayments,
    required this.percentPayment,
    this.montantPaid,
  });

  factory DetailFolderData.fromJson(Map<String, dynamic> json) {
    return DetailFolderData(
      folder: Folder.fromJson(json['folder'] ?? {}),
      destinations: (json['destinations'] as List<dynamic>?)
              ?.map((item) => Destination.fromJson(item))
              .toList() ??
          [],
      filieres: (json['filieres'] as List<dynamic>?)
              ?.map((item) => Filiere.fromJson(item))
              .toList() ??
          [],
      documents: (json['documents'] as List<dynamic>?)
              ?.map((item) => DocumentFolder.fromJson(item))
              .toList() ??
          [],
      infosSupp: (json['infosSupp'] as List<dynamic>?)
              ?.map((item) => InfosSupp.fromJson(item))
              .toList() ??
          [],
      motifPayments: (json['motifsPayment'] as List<dynamic>?)
              ?.map((item) => MotifPayment.fromJson(item))
              .toList() ??
          [],
      montantPaid: json['montantPaid'],
      percentPayment: (json['percentPayment'] ?? 0).toDouble(),
    );
  }
}

class Folder {
  final String code;
  final String openDate;
  final String libelle;
  final String firstname;
  final String lastname;
  final String telephone;
  final String email;
  final String uInitFirstname;
  final String uInitLastname;
  final String uInitEmail;
  final String uInitTelephone;
  final String agNom;
  final String agAdresse;
  final String agContact;
  final String agEmail;
  final String profilUser;
  final String? agLogo;
  final String? photo;
  final String? agLogoExt;
  final String profilUserExt;
  final String statusText;
  final String lastUpdate;

  Folder({
    required this.code,
    required this.openDate,
    required this.libelle,
    required this.firstname,
    required this.lastname,
    required this.telephone,
    required this.email,
    required this.uInitFirstname,
    required this.uInitLastname,
    required this.uInitEmail,
    required this.uInitTelephone,
    required this.agNom,
    required this.agAdresse,
    required this.agContact,
    required this.agEmail,
    required this.profilUser,
    this.agLogo,
    this.photo,
    this.agLogoExt,
    required this.profilUserExt,
    required this.statusText,
    required this.lastUpdate,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      code: json["code"] ?? '',
      openDate: json["open_date"] ?? '',
      libelle: json["libelle"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      telephone: json["telephone"] ?? '',
      email: json["email"] ?? '',
      uInitFirstname: json["uInitFirstname"] ?? '',
      uInitLastname: json["uInitLastname"] ?? '',
      uInitEmail: json["uInitEmail"] ?? '',
      uInitTelephone: json["uInitTelephone"] ?? '',
      agNom: json["agNom"] ?? '',
      agAdresse: json["agAdresse"] ?? '',
      agContact: json["agContact"] ?? '',
      agEmail: json["agEmail"] ?? '',
      profilUser: json["profilUser"] ?? '',
      agLogo: json["agLogo"],
      photo: json["photo"],
      agLogoExt: json["agLogoExt"],
      profilUserExt: json["profilUserExt"] ?? '',
      statusText: json["statusText"] ?? '',
      lastUpdate: json["lastUpdate"] ?? '',
    );
  }
}

class Destination {
  final String pNom;
  final String flagUrl;
  final String pNation;

  Destination({
    required this.pNom,
    required this.flagUrl,
    required this.pNation,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      pNom: json["pNom"] ?? '',
      flagUrl: json["flag_url"] ?? '',
      pNation: json["pNation"] ?? '',
    );
  }
}

class Filiere {
  final String intitule;

  Filiere({
    required this.intitule,
  });

  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      intitule: json["intitule"] ?? '',
    );
  }
}

class DocumentFolder {
  final String dpNom;
  final String source;
  final String ext;

  DocumentFolder({
    required this.dpNom,
    required this.source,
    required this.ext,
  });

  factory DocumentFolder.fromJson(Map<String, dynamic> json) {
    return DocumentFolder(
      dpNom: json["dpNom"] ?? '',
      source: json["source"] ?? '',
      ext: json["ext"] ?? '',
    );
  }
}

class InfosSupp {
  final String question;
  final String reponse;

  InfosSupp({
    required this.question,
    required this.reponse,
  });

  factory InfosSupp.fromJson(Map<String, dynamic> json) {
    return InfosSupp(
      question: json["question"] ?? '',
      reponse: json["reponse"] ?? '',
    );
  }
}

class MotifPayment {
  final String intitule;
  final String montant;
  final String tva;
  final String remise;
  final String montantAPayer;

  MotifPayment({
    required this.intitule,
    required this.montant,
    required this.tva,
    required this.remise,
    required this.montantAPayer,
  });

  factory MotifPayment.fromJson(Map<String, dynamic> json) {
    return MotifPayment(
      intitule: json["intitule"] ?? '',
      montant: json["montant"] ?? '',
      tva: json["tva"] ?? '',
      remise: json["remise"] ?? '',
      montantAPayer: json["montant_a_payer"] ?? '',
    );
  }
}

class DetailFolderService {
  static const String _baseUrl =
      "https://app-demo.tejispro.com/mobile/search-folder-by-code";

  Future<DetailFolderData> getDetailFolder(String code) async {
    try {
      final Map<String, dynamic> request = {"codeDossier": code};
      final String token = await _getToken();
      final uri = Uri.parse(_baseUrl);
      final response =
          await http.post(uri, body: jsonEncode(request), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse : ${jsonResponse}");
        final detailFolderData =
            DetailFolderData.fromJson(jsonResponse['data']);
        return detailFolderData;
      } else {
        throw Exception(
            "Une erreur est survenue lors de la récupération des détails du dossier. Code de statut: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Une erreur est survenue: $e");
    }
  }

  Future<String> _getToken() async {
    final String token = await AccountToken().getToken();
    return token;
  }
}
