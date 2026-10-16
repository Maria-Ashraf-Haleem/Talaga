import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class TalagaApp extends StatelessWidget {
  const TalagaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talaga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}