import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/utils/constats.dart';
import 'package:amazone_clone/widgets/loding_widget.dart';
import 'package:amazone_clone/widgets/product_show_case_listview.dart';
import 'package:amazone_clone/widgets/search_bar_widget.dart';
import 'package:amazone_clone/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:amazone_clone/widgets/ctegory_horizontal_listview_barwidget.dart';

import '../widgets/banner_add_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreService().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreService().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreService().getProductsFromDiscount(50);
    List<Widget> temp0 =
        await CloudFirestoreService().getProductsFromDiscount(0);
    print("everything is done");
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(height: kAppBarHeight / 2),
                      const CategorieHorizontalListViewBar(),
                      const BannerAddWidget(),
                      ProductsShowcaseListView(
                          title: 'Upto 70% Of', children: discount70!),
                      ProductsShowcaseListView(
                          title: 'Upto 60% Of', children: discount60!),
                      ProductsShowcaseListView(
                          title: 'Upto 50% Of', children: discount50!),
                      ProductsShowcaseListView(
                          title: 'Explore', children: discount0!),
                    ],
                  ),
                ),
                UserDetails(
                  offset: offset,
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
