import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_ground/UI/firebase_flowers_streams/flowers_stream_screen.dart';
import 'package:learning_ground/firebase_options.dart';
import 'package:learning_ground/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const FlowersStreamScreen(),
    );
  }
}
