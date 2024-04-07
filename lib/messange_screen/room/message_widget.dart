///메세지 물풍선 위젯
import 'package:flutter/material.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key, required this.messageData, required this.userId})
      : super(key: key);
  final MessageModel messageData;
  final String userId;

  @override
  Widget build(BuildContext context) {
    if (messageData.userId == userId) {
      return myMessage();
    } else if (messageData.nickName == '시스템') {
      return systemMessage();
    } else {
      return message();
    }
  }

  Padding myMessage() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(DateFormat(
                  "a HH:mm",
                ).format(messageData.createdAt as DateTime)),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding systemMessage() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Flexible(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              messageData.text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  Padding message() {
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
                  "a HH:mm",
                ).format(messageData.createdAt as DateTime)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
