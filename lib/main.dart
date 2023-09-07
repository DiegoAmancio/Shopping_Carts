import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/cart.dart';

import 'class/theme.dart';
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
    final theme = AppTheme();
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
      theme: theme.lightTheme(),
      darkTheme: theme.darkTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/list': (context) => CartScreen(),
      },
    );
  }
}
