import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_model.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view_model.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이터널리턴 채팅방"),
      ),
      body: const Column(
        children: <Widget>[RoomListView()],
      ),
    );
  }
}
