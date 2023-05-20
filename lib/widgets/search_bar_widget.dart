import 'package:amazone_clone/screens/result_screen.dart';
import 'package:amazone_clone/screens/search_screen.dart';
import 'package:amazone_clone/utils/colrs_theme.dart';
import 'package:amazone_clone/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/constats.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget({
    super.key,
    required this.isReadOnly,
    required this.hasBackButton,
  }) : preferredSize = const Size.fromHeight(kAppBarHeight);

  @override
  final Size preferredSize;

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: Colors.grey, width: 1),
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                  )
                ],
              ),
              child: TextField(
                onSubmitted: (String query) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: query),
                    ),
                  )
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
        ],
      ),
    );
  }
}
