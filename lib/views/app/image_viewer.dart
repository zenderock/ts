import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:share_plus/share_plus.dart';
import "package:http/http.dart" as http;

class ImageViewerScreen extends StatefulWidget {
  final String? path;
  const ImageViewerScreen({super.key, this.path});

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late Future<http.Response> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _fetchImage(Get.arguments["path"]!);
  }

  Future<http.Response> _fetchImage(String path) {
    final url = Uri.parse(path);
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecteur Image'),
      ),
      // fab for share the image
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          shareImage(_imageFuture, context);
        },
        child: const Icon(Icons.share),
      ),
      body: Center(
        child: FutureBuilder(
          future: _imageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Image.memory(snapshot.data!.bodyBytes);
            } else {
              return const Text('Aucune donnée');
            }
          },
        ),
      ),
    );
  }
}

void shareImage(Future<http.Response> imageFuture, BuildContext context) async {
  final response = await imageFuture;
  final result = await Share.shareXFiles([
    XFile.fromData(response.bodyBytes,
        name: Get.arguments["name"]!, mimeType: "image/jpeg")
  ], subject: "${Get.arguments["name"]} - The vision");

  if (result.status == ShareResultStatus.success) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Le document a été partagé avec succès."),
      ),
    );
  }
}
