import 'package:flutter/material.dart';
import 'package:flutter_local_notification/service/local_notification.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notification"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              LocalNotification().showNotification(
                  title: "Local Notification",
                  body: "Hi, You Click Local Notification Buttton",
                  payLoad: 'message');
            },
            child: Text("Click Me")),
      ),
    );
  }
}
