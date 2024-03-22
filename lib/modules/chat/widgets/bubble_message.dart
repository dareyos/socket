import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/data/models/chat_message/chat_message.dart';

class BubbleMessage extends StatelessWidget {
  final ChatMessage message;
  final bool itsMe;
  const BubbleMessage({super.key, required this.message, required this.itsMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: itsMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
            top: 5, bottom: 10, left: itsMe ? 60 : 15, right: itsMe ? 10 : 60),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: itsMe
              ? Get.theme.primaryColorDark
              : const Color.fromARGB(255, 18, 104, 146),
        ),
        child: Column(
          crossAxisAlignment:
              itsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!itsMe)
              Text(
                message.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            if (!itsMe)
              const SizedBox(
                height: 5,
              ),
            Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
