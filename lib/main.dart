import 'package:flutter/material.dart';
import 'package:flutter_local_notification/global_context.dart';

import 'home.dart';
import 'service/local_notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalContextServive.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          elevation: 4,
        ),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
