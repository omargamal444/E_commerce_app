import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/model/product_model.dart';
import '../cart_screen.dart';

class CartController extends GetxController {
  bool exist = true;
  List<Product>productsInCart= <Product>[].obs;
  List? products;

  void deletePrpoductsInCart(Product product) {
    productsInCart.remove(product);
  }

  void addToCart(product) {
    bool exist = false;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      Get.snackbar("error", "the product has been added before",
          backgroundColor: Colors.orange, duration: const Duration(seconds: 10));
    } else {
      productsInCart.add(product);
      Get.to(CartScreen());
    }
  }

  Future<void> storeOrder(data, List<Product> products) async {
    DocumentReference reference =
        FirebaseFirestore.instance.collection("orders").doc();
    await reference.set(data);
    Get.snackbar("اشعار", "تمت اضافة المنتج بنجاح",
        backgroundColor: Colors.blue);
    for (var product in products) {
      reference.collection("orderdetail").doc().set({
        "pName": product.pName,
        "pQuantity": product.pQuantity,
        "pPrice": product.pPrice
      });
    }
  }
}
