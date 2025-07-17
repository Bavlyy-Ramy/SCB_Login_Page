import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:scb_login/core/utils/crypto_helper.dart';
import 'package:scb_login/core/utils/user_storage_helper.dart';
import 'package:scb_login/features/auth/data/models/user_model.dart';
import 'package:scb_login/injection_container.dart';
import 'features/auth/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive(); // 🔧 Hive first
  await init(); // 📦 Then DI
  


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
