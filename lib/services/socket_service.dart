import 'package:get/get.dart';
import 'package:socket/data/models/chat_message/chat_message.dart';
import 'package:socket/data/socket_event.dart';
import 'package:socket/routes/pages.dart';
import 'package:socket/services/user_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();
  late Socket _socket;
  Future<SocketService> init() async {
    _socket = io(
      'https://masqed.ru',
      OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/chat/socket.io')
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );
    _socket.onConnect((data) {
      _sendLoginMessage();
      printInfo(info: 'Socket connected');
      Get.offNamed(Routes.CHAT);
    });

    _socket.onDisconnect((data) {
      printInfo(info: 'Socket disconnected');
      Get.offNamed(Routes.HOME);
    });
    _socket
        .onConnectError((data) => printInfo(info: 'Socket connection error'));

    _socket.onAny((event, data) {
      var isKnown = SocketEvent.values.any((element) => element.name == event);
      if (!isKnown) return;
      data['type'] = event;
      var message = ChatMessage.fromJson(data);
      UserService.to.addMessageToList(message);
    });

    return this;
  }

  String get clientId => _socket.id ?? '';

  void connect() {
    _socket.connect();
  }

  void disconnect() async {
    _sendLogoutMessage();
    await Future.delayed(const Duration(seconds: 1));
    _socket.disconnect();
  }

  void _sendLoginMessage() {
    _socket.emit(SocketEvent.login.name, UserService.to.username);
  }

  void _sendLogoutMessage() {
    _socket.emit(SocketEvent.logout.name);
  }

  void sendMessageToChat(String message) {
    _socket.emit(SocketEvent.newMessage.name, message);
  }
}
