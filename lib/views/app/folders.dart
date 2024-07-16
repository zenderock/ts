import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_vision/services/folders_service.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/views/app/detail_folder.dart';
import 'package:url_launcher/url_launcher.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  _FoldersScreenState createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  late Future<List<Folder>> futureFolder;

  @override
  void initState() {
    super.initState();
    futureFolder = FolderService().getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dossiers"),
        elevation: 1,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red.shade100,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Folder>>(
            future: futureFolder,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final List<Folder> folders = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: folders.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, index) {
                    final Folder folder = folders[index];
                    return FolderContainer(
                      title: folder.libelle,
                      uTelephone: folder.uInitTelephone,
                      code: folder.code,
                      subtitle: "Ouvert le ${folder.openDate}",
                      subtitle2: folder.agNom,
                      numero: "N°${folder.code}",
                      fullname:
                          "${folder.uInitFirstname} ${folder.uInitLastname}",
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Vous n'avez pas de dossier en cours"));
              } else {
                return const Center(child: Text("Une erreur est survenue"));
              }
            },
          ),
        ),
      ),
    );
  }
}

class FolderContainer extends StatelessWidget {
  const FolderContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.numero,
    required this.code,
    required this.subtitle2,
    required this.fullname,
    required this.uTelephone,
  });
  final String title, subtitle, numero, code, subtitle2, fullname, uTelephone;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const DetailFolderScreen(), arguments: {"code": code});
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(
                      numero,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subtitle),
                    Row(
                      children: [
                        const Icon(Iconsax.home, size: 15),
                        Text(subtitle2),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(Iconsax.user, size: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.36,
                      child: TextButton(
                        child: Text(
                          fullname,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onPressed: () {/* ... */},
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    launchWhatsApp(uTelephone);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        TVImagesString.whatsappIcon,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'NOUS CONTACTER',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void launchWhatsApp(String numeroTelephone) async {
  String url = "https://wa.me/237$numeroTelephone";
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    Get.snackbar("Erreur", "Impossible d'ouvrir WhatsApp");
  }
}
