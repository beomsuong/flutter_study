import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:fmdakgg/messange_screen/room/room_view.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageListViewModel extends StateNotifier<List<MessageModel>> {
  final String roomName;

  late final Socket socket;
  String nickName = '자히르장인';
  List<MessageModel> messageList = [];
  bool showDialog = false;

  MessageListViewModel(this.roomName) : super([]) {
    getMessageList();
  }

  void getMessageList() {
    socket = io(
      'http://10.0.2.2:3000',
      OptionBuilder().setTransports(['websocket']).enableForceNew().build(),
    );

    socket.emit('join room', [roomName, nickName]);

    socket.on('chat message', (data) {
      print('메시지 수신 $data');
      if (data is List) {
        try {
          final messages = data.map((messageData) {
            return MessageModel.fromJson(
                roomName, Map<String, dynamic>.from(messageData));
          }).toList();
          messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          state = [...state, ...messages];
        } catch (e) {
          print('메시지 변환 실패 $e');
        }
      } else {
        try {
          final message = MessageModel.fromJson(roomName, data);
          messageList.add(message);
          state = [...state, message];
        } catch (e) {
          print('실패 $e');
        }
      }
      Future.delayed(const Duration(milliseconds: 100), () {
        ///로딩 완료 후 스크롤 최하단 배치하기
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    });

    socket.onDisconnect((_) => print('Socket 연결 해제됨'));
  }

  void sendMessage(String text) {
    socket.emit('chat message', {
      'type': 'message',
      'text': text,
      'roomName': roomName,
      'userId': socket.id,
      'nickName': nickName
    });
  }

  void changeNickname(String inputNickName) {
    nickName = inputNickName;
    state = [...state];
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
