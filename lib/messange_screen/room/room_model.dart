class MessageModel {
  final String userId;
  final String text;
  final String roomName;
  final String nickName;
  final DateTime? createdAt;

  MessageModel(
      {required this.userId,
      required this.text,
      required this.roomName,
      required this.nickName,
      this.createdAt});
  factory MessageModel.fromJson(String roomName, Map<String, dynamic> json) {
    return MessageModel(
      roomName: roomName,
      userId: json['userId'] as String,
      text: json['text'] as String,
      nickName: json['nickName'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'userId': userId,
      'text': text,
      'nickName': nickName,
      'createdAt': createdAt
    };
  }
}