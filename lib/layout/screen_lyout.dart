import 'package:amazone_clone/provider/user_details_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/utils/colrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constats.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int currentPage = 0;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    CloudFirestoreService().getNameAndAddress();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  chagePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
                indicator: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: activeCyanColor, width: 4),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (int page) => chagePage(page),
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.home_outlined,
                      color: currentPage == 0 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: currentPage == 1 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: currentPage == 2 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.menu_outlined,
                      color: currentPage == 3 ? activeCyanColor : Colors.black,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
