import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_model.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view_model.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final roomListViewModelProvider =
      StateNotifierProvider<RoomListViewModel, List<RoomListModel>>((ref) {
    return RoomListViewModel();
  });

  @override
  Widget build(BuildContext context) {
    final roomList = ref.watch(roomListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅방 예시"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: roomList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(roomList[index].roomName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
