import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_vision/services/receipts_service.dart';
import 'package:the_vision/views/app/pdf_viewer.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  late Future<List<Receipt>> futureReceipts;

  @override
  void initState() {
    super.initState();
    futureReceipts = ReceiptService().getReceipts(Get.arguments["code"]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos reçus"),
        elevation: 1,
      ),
      body: FutureBuilder<List<Receipt>>(
        future: futureReceipts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Vous avez pas de reçu"));
          } else {
            return ListView.separated(
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                Receipt receipt = snapshot.data![index];
                return ListTile(
                  title: Text("Reçu N° ${receipt.ref}"),
                  subtitle:
                      Text("Montant: ${receipt.amount} ${receipt.devise}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const PDFScreen(), arguments: {
                        "path": receipt.link,
                        "name": "Reçu N° ${receipt.ref}"
                      });
                    },
                    child: const Text('Ouvrir'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
