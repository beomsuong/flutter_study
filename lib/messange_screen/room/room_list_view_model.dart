import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageListViewModel extends StateNotifier<List<MessageModel>> {
  final String roomName;

  late final Socket socket;
  String nickName = '자히르장인';
  List<MessageModel> messageList = [];
  MessageListViewModel(this.roomName) : super([]) {
    getMessageList();
  }

  void getMessageList() {
    socket = io(
      'http://10.0.2.2:3000',
      OptionBuilder().setTransports(['websocket']).enableForceNew().build(),
    );

    socket.emit('join room', roomName);

    socket.on('chat message', (data) {
      print('메시지 수신 $data');
      final message = MessageModel.fromJson(roomName, data);
      messageList.add(message);
      state = [...state, message]; //상태 갱신
    });

    socket.onDisconnect((_) => print('Socket 연결 해제됨'));
  }

  void sendMessage(String text) {
    socket.emit('chat message', {
      'text': text,
      'roomName': roomName,
      'userId': socket.id,
      'nickName': nickName
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
