import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomListViewModel extends StateNotifier<List<RoomListModel>> {
  RoomListViewModel() : super([]) {
    getRoomList();
  }
  Socket? socket;

  void getRoomList() {
    socket?.disconnect();
    socket = io(
      'http://10.0.2.2:3000',
      OptionBuilder().setTransports(['websocket']).enableForceNew().build(),
    );

    socket!.onConnect((_) {
      print('Connected');
      socket!.emit('room list');
    });

    socket!.on('room list', (data) {
      final roomList = List<RoomListModel>.from(
        data.map((item) => RoomListModel.fromJson(item)),
      );
      print("방 $roomList");
      state = roomList;
    });

    socket!.onDisconnect((_) {
      print('Disconnected');
    });
  }
}
