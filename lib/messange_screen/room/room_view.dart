import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomView extends StatefulWidget {
  final String roomName;
  const RoomView({Key? key, required this.roomName}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<RoomView> {
  late Socket socket;
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    socket = io(
      'http://10.0.2.2:3000',
      OptionBuilder().setTransports(['websocket']).enableForceNew().build(),
    );
    socket.emit('join room', widget.roomName);
    socket.on('chat message', (data) {
      print("메시지 수신 $data");
      setState(() {
        messages.add(data['msg']);
      });
    });

    socket.onDisconnect((_) {
      print('Socket 연결 해제됨');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
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
                  socket.emit('chat message',
                      {'msg': _controller.text, 'room': widget.roomName});
                  _controller.clear();
                }
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
