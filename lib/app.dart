import 'package:dasm_core/dasm_core.dart';
import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

class DasmSouqApp extends StatelessWidget {
  const DasmSouqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق داسم',
      debugShowCheckedModeBanner: false,
      theme: DasmTheme.light(),
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [Locale('ar', 'SA')],
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const SplashScreen(),
    );
  }
}
