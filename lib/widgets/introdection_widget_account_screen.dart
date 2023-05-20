import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_details_model.dart';
import '../provider/user_details_provider.dart';
import '../utils/colrs_theme.dart';
import '../utils/constats.dart';

class IntrodectionWidgetAccountScreen extends StatelessWidget {
  const IntrodectionWidgetAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.01),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                      ),
                    ),
                    TextSpan(
                      text: userDetailsModel.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://tse2.mm.bing.net/th?id=OIP.Rc9qEH8QxHXM8JZSeIKIeQHaJQ&pid=Api&P=0&h=180',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
