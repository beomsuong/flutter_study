import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room/room_list_view_model.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';

class RoomView extends ConsumerStatefulWidget {
  final String roomName;

  const RoomView({Key? key, required this.roomName}) : super(key: key);

  @override
  _RoomViewState createState() => _RoomViewState();
}

class _RoomViewState extends ConsumerState<RoomView> {
  final TextEditingController _controller = TextEditingController();

  final roomViewModelProvider = StateNotifierProvider.family<
      MessageListViewModel,
      List<MessageModel>,
      String>((ref, roomName) => MessageListViewModel(roomName));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(roomViewModelProvider(widget.roomName));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
