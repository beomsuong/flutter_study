///메세지 물풍선 위젯
import 'package:flutter/material.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.messageData}) : super(key: key);
  final MessageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            messageData.nickName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      messageData.text,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Text(DateFormat(
                  "a HH시 mm분",
                ).format(messageData.createdAt as DateTime)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
