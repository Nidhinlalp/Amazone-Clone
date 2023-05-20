import 'package:amazone_clone/models/product_model.dart';
import 'package:amazone_clone/provider/user_details_provider.dart';
import 'package:amazone_clone/utils/colrs_theme.dart';
import 'package:amazone_clone/utils/constats.dart';
import 'package:amazone_clone/utils/utils.dart';
import 'package:amazone_clone/widgets/cart_item_widget.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:amazone_clone/widgets/loding_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_details_model.dart';
import '../resources/cloud_firestore_methods.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/user_details.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(hasBackButton: false, isReadOnly: true),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomMainButton(
                            clolor: yellowColor,
                            isLoading: true,
                            onPressed: () {},
                            child: const Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else {
                          return CustomMainButton(
                            clolor: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFirestoreService().buyAllItemsInCart(
                                userDetails: Provider.of<UserDetailsProvider>(
                                  context,
                                  listen: false,
                                ).userDetails,
                              );
                              Utils().showSnackBar(
                                  context: context, content: "Done");
                            },
                            child: Text(
                              'Procce to by(${snapshot.data!.docs.length}) items',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                      }),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductModel product =
                                  ProductModel.getModelFromJson(
                                json: snapshot.data!.docs[index].data(),
                              );
                              return CartItemWidget(product: product);
                            },
                          );
                        }
                      }),
                )
              ],
            ),
            const UserDetails(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
