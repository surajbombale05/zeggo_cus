import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/constants/app_init.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';
import 'package:zeggo_cus/firebase_options.dart';

String? firebasetoken;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AppInit.init();
  } catch (e, stk) {
    log("-------- $e $stk");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zeggo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
