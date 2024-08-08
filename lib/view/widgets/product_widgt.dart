import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';

// ignore: must_be_immutable
class JacketView extends StatelessWidget {
  List theProducts = [];

  JacketView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data!.docs) {
            var data = doc;
            products.add(Product(
              pId: doc.id,
              pPrice: data["price"],
              pName: data["name"],
              pLocation: data["location"],
            ));
          }
          theProducts = [...products];
          products.clear();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              Text('\$ ${products[index].pPrice}')
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}
