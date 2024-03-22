import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Укажите ваш ник!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.textCtrl,
                onSubmitted: (value) => controller.signIn(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              )
            ],
          ),
        ));
  }
}
