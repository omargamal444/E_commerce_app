import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';
import '../Screens/product_ info.dart';

// ignore: must_be_immutable
class ProductCategory extends StatelessWidget {
  List<Product> products = [];
  String? category;

  ProductCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("loading");
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final productName = snapshot.data!.docs[index]["name"];
            final productPrice = snapshot.data!.docs[index]["price"];
            final productLocation = snapshot.data!.docs[index]["location"];
            products.add(Product(
                pName: productName,
                pLocation: productLocation,
                pPrice: productPrice));

            return SizedBox(
              height: 250,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(ProductInfo.productInfo,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation!),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
