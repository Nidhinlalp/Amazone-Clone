import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/widgets/product_information.dart';

import '../models/product_model.dart';
import '../screens/product_screen.dart';
import '../utils/colrs_theme.dart';
import '../utils/utils.dart';
import 'custo_square_button.dart';
import 'custom_simple_rounded_button.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(productModel: product),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.network(
                            product.url,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ProductInformationWidget(
                    productName: product.productName,
                    cost: product.cost,
                    sellerName: product.sellerName,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.remove),
                ),
                CustomSquareButton(
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 40,
                  child: const Text(
                    "0",
                    style: TextStyle(
                      color: activeCyanColor,
                    ),
                  ),
                ),
                CustomSquareButton(
                  onPressed: () async {
                    await CloudFirestoreService().addProductToCart(
                      productModel: ProductModel(
                        url: product.url,
                        productName: product.productName,
                        cost: product.cost,
                        discount: product.discount,
                        uid: Utils().getUid(),
                        sellerName: product.sellerName,
                        sellerUid: product.sellerUid,
                        rating: product.rating,
                        noOfRating: product.noOfRating,
                      ),
                    );
                  },
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: () async {
                            CloudFirestoreService().deleteProductFromCart(
                              uid: product.uid,
                            );
                          },
                          text: "Delete"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(color: activeCyanColor, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
