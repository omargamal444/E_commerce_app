import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'model/product_model.dart';

class CartScreen extends StatelessWidget {
  static String id = '/CartScreen';
  final controller=Get.find<CartController>();
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            if (controller.productsInCart.isNotEmpty) {
              return SizedBox(
                height: screenHeight -
                    statusBarHeight -
                    appBarHeight -
                    (screenHeight * .08),
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          child: SizedBox(
                            height: screenHeight * .15,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: screenHeight * .15 / 2,
                                  backgroundImage: AssetImage(controller
                                      .productsInCart[index].pLocation!),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              controller
                                                  .productsInCart[index].pName!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\$ ${controller.productsInCart[index].pPrice}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          controller
                                              .productsInCart[index].pQuantity
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.deletePrpoductsInCart(
                                              controller.productsInCart[index]);
                                        },
                                        icon: const Icon(Icons.clear),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.productsInCart.length,
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: const Center(
                  child: Text('Cart is Empty'),
                ),
              );
            }
          }),
          Builder(
            builder: (context) => ButtonTheme(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              minWidth: screenWidth,
              height: screenHeight * .08,
              child: ElevatedButton(
                onPressed: () async {
                  showAlertDialog(context);
                },
                child: Text('Order'.toUpperCase()),
              ),
            ),
          )
        ],
      ),
    );
  }
}

int getPrice(List<Product> products) {
  int totalPrice = 0;
  for (var product in products) {
    totalPrice += product.pQuantity! * int.parse(product.pPrice!);
  }
  return totalPrice;

}

void showAlertDialog(BuildContext context) async {
  var controller = Get.put(CartController());
  String? address;
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Confirm"),
    onPressed: () {
      Navigator.pop(context);
      controller.storeOrder({
        "adress": address,
        "total price ": getPrice(controller.productsInCart)
      }, controller.productsInCart);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Total price is ${getPrice(controller.productsInCart)}"),
    content: TextField(
      onChanged: (value) {
        address = value;
        print(address);
      },
      decoration: const InputDecoration(hintText: "Enter your Address"),
    ),
    actions: [
      okButton,
    ],
  );
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
