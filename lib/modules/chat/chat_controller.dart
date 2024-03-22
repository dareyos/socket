import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/data/models/chat_message/chat_message.dart';
import 'package:socket/services/socket_service.dart';
import 'package:socket/services/user_service.dart';

class ChatController extends GetxController {
  RxList<ChatMessage> get messages => UserService.to.messages;

  final textCntrl = TextEditingController();
  final scrollCntrl = ScrollController();

  @override
  void onInit() {
    messages.listen((p0) async {
      var max = scrollCntrl.position.maxScrollExtent;
      if (scrollCntrl.offset + 100 >= max) {
        await Future.delayed(const Duration(microseconds: 300));
        scrollCntrl.jumpTo(max);
      }
    });
    super.onInit();
  }

  sendMessage() {
    var message = textCntrl.text;
    if (messages.isNotEmpty) SocketService.to.sendMessageToChat(message);
    textCntrl.clear();
  }

  bool itsMe(String clientId) => clientId == SocketService.to.clientId;

  disconnect() => SocketService.to.disconnect();
}
