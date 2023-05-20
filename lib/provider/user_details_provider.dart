import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';

import '../models/user_details_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreService().getNameAndAddress();
    notifyListeners();
  }
}
