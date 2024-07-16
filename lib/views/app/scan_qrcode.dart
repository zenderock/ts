import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/views/app/detail_folder.dart';

class ScanQrcodeScreen extends StatefulWidget {
  const ScanQrcodeScreen({super.key});

  @override
  State<ScanQrcodeScreen> createState() => _QrPageState();
}

class _QrPageState extends State<ScanQrcodeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String barcode = 'Tap to scan';
  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      validator: (context) {
        return context.length == 9;
      },
      canPop: true,
      onScan: (String value) async {
        final SharedPreferences prefs = await _prefs;
        prefs.setString("code", value);
        debugPrint(value);
        setState(() {
          barcode = value;
        });
        Get.snackbar("Recherche", "Recherche du Dossier N°$value");
        Get.to(() => const DetailFolderScreen(), arguments: {"code": value});
      },
      onDetect: (p0) {},
      onDispose: () {
        debugPrint("Barcode scanner disposed!");
      },
      controller:
          MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates),
    );
  }
}
