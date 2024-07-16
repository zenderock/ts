import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:the_vision/utils/helpers/token.dart';

class Receipt {
  final String ref;
  final DateTime date;
  final double amount;
  final String state;
  final String devise;
  final String link;

  Receipt({
    required this.ref,
    required this.date,
    required this.amount,
    required this.state,
    required this.devise,
    required this.link,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      ref: json['ref'],
      date: DateTime.parse(json['date']),
      amount: double.parse(json['amount']),
      state: json['state'],
      devise: json['devise'],
      link: json['link'],
    );
  }
}

class ReceiptService {
  final String apiUrl =
      "https://app-demo.tejispro.com/mobile/get-client-receipts";

  Future<List<Receipt>> getReceipts(String folderCode) async {
    final String token = await AccountToken().getToken();
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'codeDossier': folderCode,
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Receipt> receiptsList = [];
      for (var data in jsonData["data"]) {
        receiptsList.add(Receipt.fromJson(data));
      }
      return receiptsList;
    } else {
      throw Exception("Failed to load receipts");
    }
  }
}
