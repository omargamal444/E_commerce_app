import 'package:flutter/material.dart';
import 'package:products/view/widgets/product_category.dart';

class Homepage extends StatefulWidget {
  static const homepage = "Homepage";

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                onTap: (value) {
                  setState(() {
                    x = value;
                  });
                },
                tabs: [
                  Text(
                    "Jackets",
                    style:
                        TextStyle(color: x == 0 ? Colors.black : Colors.white),
                  ),
                  Text("Troussers",
                      style: TextStyle(
                          color: x == 1 ? Colors.black : Colors.white)),
                  Text("T-shirts",
                      style: TextStyle(
                          color: x == 2 ? Colors.black : Colors.white)),
                  Text("Shoes",
                      style: TextStyle(
                          color: x == 3 ? Colors.black : Colors.white)),
                ]),
          ),
          body: TabBarView(
            children: [
              ProductCategory(category: "jacket"),
              ProductCategory(category: "troussers"),
              ProductCategory(category: "Tshirt"),
              ProductCategory(category: "shoes")
            ],
          )),
    );
  }
}
