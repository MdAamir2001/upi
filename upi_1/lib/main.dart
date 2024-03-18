// main.dart

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:upi_1/sendmoney.dart';
import 'package:upi_1/welcome.dart';
import 'dashboard.dart';
import 'package:upi_1/dashboard.dart' as dashboard; // Import dashboard.dart with a prefix
import 'package:upi_1/transaction_history_details_screen.dart' as details; // Import transaction_history_details_screen.dart with a prefix

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();

  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyA-4UwZqVZKa3axkdwC_pOPqaNyQ8vUOZE',
    authDomain: 'upi1-95a79.firebaseapp.com',
    projectId: 'upi1-95a79',
    storageBucket: 'gs://upi1-95a79.appspot.com',
    messagingSenderId: '825185799274',
    appId: '1:825185799274:android:330341692cce7ed7cdce13',
  );
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}/${message.notification?.body}');
    showNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked!');
    showNotification(message);
  });


  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter()); // Assuming you have a TransactionAdapter
  await Hive.openBox<Transaction>('transactionBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SendMoneyState()),
        // Add other providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status == PermissionStatus.granted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }
}
void showNotification(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    '1',
    'notification channel',
    importance: Importance.max,
    priority: Priority.high,
  );
  final NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  print("trying to show notification");
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'hi',
    message.notification?.body ?? 'hello',
    platformChannelSpecifics,
    payload: json.encode(message.data),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
