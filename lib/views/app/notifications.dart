import 'package:flutter/material.dart';
import 'package:the_vision/services/notifications_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // late Future<List<NotificationItem>> futureNotifications;
  late Future<List<NotificationItem>> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = NotificationService().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: const Text("Notifications"),
      ),
      body: Center(
        child: FutureBuilder<List<NotificationItem>>(
            future: futureNotifications,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notifications = snapshot.data!;
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: const EdgeInsets.all(10),
                      color: notification.seen == "0"
                          ? Colors.grey[300]
                          : Colors.grey[100],
                      child: ListTile(
                          title: Text(
                            notification.object,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: notification.seen == "0"
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(notification.content),
                          trailing: snapshot.data![index].seen == "0"
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                )
                              : null),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
