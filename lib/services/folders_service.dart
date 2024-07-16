import "package:http/http.dart" as http;
import "dart:convert";

import "package:the_vision/utils/helpers/token.dart";

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
  final String uInitTelephone;
  final String uInitEmail;
  final String agNom;
  final String agAdresse;
  final String agContact;
  final String agEmail;

  const Folder({
    required this.code,
    required this.openDate,
    required this.libelle,
    required this.firstname,
    required this.lastname,
    required this.telephone,
    required this.email,
    required this.uInitFirstname,
    required this.uInitLastname,
    required this.uInitTelephone,
    required this.uInitEmail,
    required this.agNom,
    required this.agAdresse,
    required this.agContact,
    required this.agEmail,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
        code: json["code"],
        openDate: json["open_date"],
        libelle: json["libelle"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        telephone: json["telephone"],
        email: json["email"],
        uInitFirstname: json["uInitFirstname"],
        uInitLastname: json["uInitLastname"],
        uInitEmail: json["uInitEmail"],
        uInitTelephone: json["uInitTelephone"],
        agNom: json["agNom"],
        agAdresse: json["agAdresse"],
        agContact: json["agContact"],
        agEmail: json["agEmail"]);
  }
}

class FolderService {
  Future<List<Folder>> getFolders() async {
    final String token = await AccountToken().getToken();
    final uri =
        Uri.parse("https://app-demo.tejispro.com/mobile/get-client-folders");
    final response = await http.post(uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> foldersData = jsonData["data"]["folders"];
      final List<Folder> folders =
          foldersData.map((folderData) => Folder.fromJson(folderData)).toList();
      print("folders : ${foldersData}");
      return folders;
    } else {
      throw Exception("Une erreur est survenue");
    }
  }
}
