import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/services/user_service.dart';

class HomeController extends GetxController {
  final textCtrl = TextEditingController();

  void signIn() {
    String username = textCtrl.text;
    UserService.to.setUsernameAndConnect(username);
    //TODO logic for signIn
  }
}
