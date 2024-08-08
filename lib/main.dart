import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/Bindings/bindings.dart';
import 'package:products/cart_screen.dart';
import 'package:products/firebase_options.dart';
import 'package:products/view/Screens/home_page.dart';
import 'package:products/view/Screens/product_%20info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: [
      GetPage(
          name: ProductInfo.productInfo,
          page: () => const ProductInfo(),
          binding: ProductInfoBinding()),
      GetPage(name: CartScreen.id, page: () => CartScreen())
    ], initialBinding: MainBinding(), home: const Homepage());
  }
}
