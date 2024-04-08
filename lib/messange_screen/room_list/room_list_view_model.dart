import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomListViewModel extends StateNotifier<List<RoomListModel>> {
  RoomListViewModel() : super([]) {
    getRoomList();
  }
  Socket? socket;

  void getRoomList() async {
    try {
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
        print('룸 리스트화면 수신 $data');
        final Map<String, dynamic> roomsData = Map<String, dynamic>.from(data);
        final roomList = roomsData.entries.map((entry) {
          final roomData = Map<String, dynamic>.from(entry.value);
          return RoomListModel.fromJson(entry.key, roomData);
        }).toList();
        state = roomList;
      });

      socket!.onDisconnect((_) {
        print('Disconnected');
      });
    } catch (e) {
      print('Error fetching room list: $e');
    }
  }
}
