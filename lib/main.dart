import 'package:demo/Services/firebase_service.dart';
import 'package:demo/app_dependency_binding.dart';
import 'package:demo/features/home/presentation/pages/bottom_nav_page.dart';
import 'package:demo/firebase_options.dart';
import 'package:demo/notification_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//navigator key
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initNotification();
  iniBindings();

  // await openDatabase(
  //   join(await getDatabasesPath(), '${SqlLocalDatabase.instance.database}'),
  // );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          navigatorKey: navigatorKey,
          routes: {
            // '/': (context) => const FirstScreen(),
            '/notification_screen': (context) => const NotificationPage()
          },
          home: const HomePage()),
    );
  }
}
