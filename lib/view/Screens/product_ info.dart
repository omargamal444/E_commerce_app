import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/cart_screen.dart';
import 'package:products/controller/cart_controller.dart';
import 'package:products/controller/product_info_controller.dart';
import 'package:products/model/product_model.dart';

class ProductInfo extends StatefulWidget {
  static const productInfo = "/Productinfo";

  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final cartController = Get.put(CartController());
  final productInfoController=Get.find<ProductInfoController>();
  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments;
    product.pQuantity = productInfoController.quantity.value;
    return Scaffold(
        body: Stack(children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage(product.pLocation!),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              GestureDetector(
                  onTap: () {
                    Get.to(CartScreen());
                  },
                  child: const Icon(Icons.shopping_cart))
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          child: Column(children: <Widget>[
            Opacity(
                opacity: .3,
                child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.pName!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                product.pName!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$${product.pPrice}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipOval(
                                    child: Material(
                                      color: Colors.black,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                           productInfoController. quantity.value++;
                                          });
                                        },
                                        child: const SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() =>
                                     Text(
                                      "${productInfoController.quantity.value}",
                                      style: const TextStyle(fontSize: 60),
                                    ),
                                  ),
                                  ClipOval(
                                    child: Material(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (productInfoController.quantity > 1) {
                                           productInfoController.quantity--;
                                          }
                                        },
                                        child: const SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ])))),
            ButtonTheme(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              splashColor: Colors.red,
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .08,
              child: Builder(
                  builder: (context) => ElevatedButton(
                        onPressed: () {
                          return cartController.addToCart(product);
                        },
                        child: Text(
                          'Add to Cart'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )),
            )
          ]))
    ]));
  }
}
