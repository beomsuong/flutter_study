import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageListViewModel extends StateNotifier<List<MessageModel>> {
  final String roomName;
  late final Socket socket;

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
      final message = MessageModel.fromJson(roomName, data);
      state = [...state, message];
    });

    socket.onDisconnect((_) => print('Socket 연결 해제됨'));
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
