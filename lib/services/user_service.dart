import 'package:get/get.dart';
import 'package:socket/data/models/chat_message/chat_message.dart';
import 'package:socket/routes/pages.dart';
import 'package:socket/services/socket_service.dart';

class UserService extends GetxService {
  static UserService get to => Get.find<UserService>();

  String username = "";
  final messages = RxList<ChatMessage>.empty();

  Future<UserService> init() async {
    return this;
  }

  void login() {
    Get.toNamed(Routes.CHAT);
  }

  void setUsernameAndConnect(String user) {
    username = user;
    SocketService.to.connect();
  }

  //добавляет сообщение [ChatMessage] в историю
  void addMessageToList(ChatMessage message) {
    messages.add(message);
  }

  void clearMessages() {
    messages.clear();
  }
}
