import 'package:flutter/material.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talaga App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      home: const Scaffold(
        body: Center(
          child: Text(
            'تم التشغيل بنجاح! \nاربطي دي بأول شاشة في الـ Architecture.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}