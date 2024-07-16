import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import "package:http/http.dart" as http;
import 'package:the_vision/utils/helpers/createFileLinkPdf.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({super.key, this.path});

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  File filePath = File("");
  bool isFileLoading = true;

  late Future<http.Response> _pdfFuture;

  @override
  initState() {
    super.initState();
    _pdfFuture = _fetchPDF(Get.arguments["path"]!);
    if (Get.arguments["path"] != null) {
      createFileOfPdfUrl(Get.arguments["path"]!).then((file) {
        setState(() {
          filePath = file;
          isFileLoading = false;
        });
      });
    }
  }

  Future<http.Response> _fetchPDF(String path) {
    final url = Uri.parse(path);
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lecteur PDF"),
      ),
      body: isFileLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                PDFView(
                  filePath: filePath.path,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage!,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation:
                      false, // if set to true the link is handled in flutter
                  onRender: (pages) {
                    setState(() {
                      pages = pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    Get.snackbar("Erreur", error.toString());
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                    // print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onLinkHandler: (String? uri) {
                    // print('goto uri: $uri');
                  },
                  onPageChanged: (int? page, int? total) {
                    // print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
                errorMessage.isEmpty
                    ? !isReady
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                    : Center(
                        child: Text(errorMessage),
                      )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sharePDF(_pdfFuture, context);
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}

void sharePDF(Future<http.Response> pdfFuture, BuildContext context) async {
  final response = await pdfFuture;
  final result = await Share.shareXFiles([
    XFile.fromData(response.bodyBytes,
        name: Get.arguments["name"]!, mimeType: "application/pdf")
  ], subject: "${Get.arguments["name"]!} - The vision");

  if (result.status == ShareResultStatus.success) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Le document a été partagé avec succès."),
      ),
    );
  }
}
