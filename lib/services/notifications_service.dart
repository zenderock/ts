import 'dart:convert';

import 'package:the_vision/utils/helpers/token.dart';
import 'package:http/http.dart' as http;

class Notification {
  final String message;
  final int status;
  final List<NotificationItem> data;

  Notification({
    required this.message,
    required this.status,
    required this.data,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    List<NotificationItem> dataList = [];
    if (json['data'] != null) {
      dataList = List<NotificationItem>.from(
          json['data'].map((item) => NotificationItem.fromJson(item)));
    }
    return Notification(
      message: json['message'],
      status: json['status'],
      data: dataList,
    );
  }
}

class NotificationItem {
  final String id;
  final String channel;
  final String initUser;
  final String nextUser;
  final String object;
  final String content;
  final dynamic documents;
  final String priority;
  final String seen;
  final String createdAt;
  final String updatedAt;
  final String lastname;
  final String firstname;
  final String uConcernLastname;
  final String uConcernFirstname;
  final String roleNom;

  NotificationItem({
    required this.id,
    required this.channel,
    required this.initUser,
    required this.nextUser,
    required this.object,
    required this.content,
    required this.documents,
    required this.priority,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
    required this.lastname,
    required this.firstname,
    required this.uConcernLastname,
    required this.uConcernFirstname,
    required this.roleNom,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      channel: json['channel'],
      initUser: json['init_user'],
      nextUser: json['next_user'],
      object: json['objet'],
      content: json['content'],
      documents: json['documents'],
      priority: json['priority'],
      seen: json['seen'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      uConcernLastname: json['uConcernlastname'],
      uConcernFirstname: json['uConcernfirstname'],
      roleNom: json['roleNom'],
    );
  }
}

class NotificationService {
  Future<List<NotificationItem>> getNotifications() async {
    try {
      final String token = await AccountToken().getToken();
      final uri =
          Uri.parse("https://app-demo.tejispro.com/mobile/get-notifications");
      final response = await http.get(uri, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<NotificationItem> notificationList = [];
        for (var i = 0; i < jsonData["data"].length; i++) {
          notificationList.add(NotificationItem.fromJson(jsonData["data"][i]));
        }
        return notificationList;
      } else {
        throw Exception("Une erreur est survenue");
      }
    } catch (e) {
      throw Exception("Une erreur est survenue");
    }
  }
}

// fotso@f.com2s