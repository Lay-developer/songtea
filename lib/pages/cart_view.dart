import 'package:flutter/material.dart';
import 'package:song_tea_app/helper/st_color.dart';
import 'package:song_tea_app/helper/st_variable.dart';
import 'package:song_tea_app/models/product.dart';

class CartView extends StatelessWidget {
  final List<Product> product;
  const CartView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ClsSTColor.getColor(color: STColor.appBarColor),
      ),
      body: product.isEmpty
          ? const Center(
              child: Text('Your cart is empty!'),
            )
          : ListView(
              children: List.generate(
                  product.length,
                  (index) => ListTile(
                        leading: Image.asset(
                          product[index].cartImage,
                          width: mainWidth * wPaddingAll * 2.5,
                          height: mainWidth * wPaddingAll * 3,
                        ),
                        subtitle: Text(product[index].productName),
                      )),
            ),
    );
  }
}
