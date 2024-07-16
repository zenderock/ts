class Destination {
  final String pNom;
  final String flagUrl;
  final String pNation;
  final String paysId;

  const Destination({
    required this.pNom,
    required this.flagUrl,
    required this.pNation,
    required this.paysId,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      pNom: json["pNom"] ?? '',
      flagUrl: json["flag_url"] ?? '',
      pNation: json["pNation"] ?? '',
      paysId: json["paysId"] ?? '',
    );
  }
}

class Filiere {
  final String intitule;
  final String id;

  const Filiere({required this.intitule, required this.id});

  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      intitule: json["intitule"] ?? '',
      id: json["id"] ?? '',
    );
  }
}

class DocumentFolder {
  final String id;
  final String dpNom;
  final String description;
  final String requis;
  final String source;
  final String ext;

  const DocumentFolder({
    required this.id,
    required this.dpNom,
    required this.description,
    required this.requis,
    required this.source,
    required this.ext,
  });

  factory DocumentFolder.fromJson(Map<String, dynamic> json) {
    return DocumentFolder(
      id: json["id"] ?? '',
      dpNom: json["dpNom"] ?? '',
      description: json["description"] ?? '',
      requis: json["requis"] ?? '',
      source: json["source"] ?? '',
      ext: json["ext"] ?? '',
    );
  }
}

class InfosSupp {
  final String id;
  final String question;
  final String reponse;
  final String requis;

  const InfosSupp({
    required this.id,
    required this.question,
    required this.reponse,
    required this.requis,
  });

  factory InfosSupp.fromJson(Map<String, dynamic> json) {
    return InfosSupp(
      id: json["id"] ?? '',
      question: json["question"] ?? '',
      reponse: json["reponse"] ?? '',
      requis: json["requis"] ?? '',
    );
  }
}

class MotifPayment {
  final String id;
  final String intitule;
  final String dmpId;
  final String description;
  final String montant;
  final String tva;
  final String remise;
  final String montantAPayer;

  const MotifPayment({
    required this.id,
    required this.intitule,
    required this.dmpId,
    required this.description,
    required this.montant,
    required this.tva,
    required this.remise,
    required this.montantAPayer,
  });

  factory MotifPayment.fromJson(Map<String, dynamic> json) {
    return MotifPayment(
      id: json["id"] ?? '',
      intitule: json["intitule"] ?? '',
      dmpId: json["dmpId"] ?? '',
      description: json["description"] ?? '',
      montant: json["montant"] ?? '',
      tva: json["tva"] ?? '',
      remise: json["remise"] ?? '',
      montantAPayer: json["montant_a_payer"] ?? '',
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
  final String percentPayment;

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
    required this.percentPayment,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      code: json["code"] ?? '',
      openDate: json["openDate"] ?? '',
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
      percentPayment: json["percentPayment"] ?? '0',
    );
  }
}

class DetailFolder {
  final Folder folder;
  final List<Destination> destinations;
  final List<Filiere> filieres;
  final List<DocumentFolder> documents;
  final List<InfosSupp> infosSupp;
  final List<MotifPayment> motifPayments;
  final String? montantPaid;
  final double percentPayment;

  const DetailFolder({
    required this.folder,
    required this.destinations,
    required this.filieres,
    required this.documents,
    required this.infosSupp,
    required this.motifPayments,
    required this.percentPayment,
    this.montantPaid,
  });
}

// class DetailFolderService {
//   Future<DetailFolder> getFolder(String code) async {
//     try {
//       final Map<String, dynamic> request = {"codeDossier": code};
//       final String token = await AccountToken().getToken();
//       final dio = Dio();
//       final response = await dio.post(
//         "https://app-demo.tejispro.com/mobile/search-folder-by-code",
//         data: request,
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final jsonData = response.data["data"];
//         final List<DocumentFolder> documentList =
//             (jsonData["documents"] as List)
//                 .map((doc) => DocumentFolder.fromJson(doc))
//                 .toList();
//         final List<InfosSupp> infosSuppList = (jsonData["infosSupp"] as List)
//             .map((info) => InfosSupp.fromJson(info))
//             .toList();
//         final List<MotifPayment> motifPaymentsList =
//             (jsonData["motifsPayment"] as List)
//                 .map((motif) => MotifPayment.fromJson(motif))
//                 .toList();
//         final List<Destination> destinationsList =
//             (jsonData["destinations"] as List)
//                 .map((destination) => Destination.fromJson(destination))
//                 .toList();
//         final List<Filiere> filieresList = (jsonData["filieres"] as List)
//             .map((filiere) => Filiere.fromJson(filiere))
//             .toList();
//         return DetailFolder(
//           documents: documentList,
//           infosSupp: infosSuppList,
//           motifPayments: motifPaymentsList,
//           montantPaid: jsonData["montantPaid"],
//           percentPayment: jsonData["percentPayment"],
//           folder: Folder.fromJson(jsonData["folder"]),
//           destinations: destinationsList,
//           filieres: filieresList,
//         );
//       } else {
//         throw Exception(
//             "Une erreur est survenue lors de la récupération des détails du dossier. Code de statut: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Une erreur est survenue: $e");
//     }
//   }
// }
