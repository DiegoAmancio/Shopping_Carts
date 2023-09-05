import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/cart.dart';

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
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand');

    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
        Get.lazyPut(() => ProductsController());
      }),
      title: 'Flutter Demo',
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
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
