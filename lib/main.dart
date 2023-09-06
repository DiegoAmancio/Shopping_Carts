import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/cart.dart';

import 'class/translations.dart';
import 'controller/cart.controller.dart';
import 'controller/product.controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
        brightness: Brightness.light,
        primarySwatch: const MaterialColor(0xFF226FE3, <int, Color>{
          50: Color(0xFFE0F0FF),
          100: Color(0xFFB3D2FF),
          200: Color(0xFF80ABFF),
          300: Color(0xFF4D84FF),
          400: Color(0xFF226FE3),
          500: Color(0xFF1C64D4), // Your primary color
          600: Color(0xFF195ABE),
          700: Color(0xFF1550A9),
          800: Color(0xFF124695),
          900: Color(0xFF0E3C80),
        }),
        fontFamily: 'QuickSand');

    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
        Get.lazyPut(() => ProductsController());
      }),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
            primary: const Color(0xFF267CFF),
            secondary: const Color(0xFF4D94FF),
            tertiary: const Color(0xFF00BCD4)),
        textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            labelLarge: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/list': (context) => CartScreen(),
      },
    );
  }
}
