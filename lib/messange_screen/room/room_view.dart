import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/messange_screen/room/message_widget.dart';
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

  ScrollController scrollController = ScrollController();
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
      body: Container(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageWidget(messageData: messages[index]);
                  },
                ),
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ref
                        .read(roomViewModelProvider(widget.roomName).notifier)
                        .sendMessage(_controller.text);
                    _controller.clear();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                  }
                },
                child: const Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
