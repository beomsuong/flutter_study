class MessageModel {
  final String type;
  final String? userId;
  final String text;
  final String roomName;
  final String? nickName;
  final DateTime? createdAt;
  final int? numberOfPeople;
  MessageModel(
      {required this.type,
      this.userId,
      required this.text,
      required this.roomName,
      this.nickName,
      this.createdAt,
      this.numberOfPeople});
  factory MessageModel.fromJson(String roomName, Map<String, dynamic> json) {
    return MessageModel(
      type: json['type'],
      roomName: roomName,
      userId: json['userId'],
      text: json['text'],
      nickName: json['nickName'],
      createdAt: DateTime.parse(json['createdAt']),
      numberOfPeople: json['numberOfPeople'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'roomName': roomName,
      'userId': userId,
      'text': text,
      'nickName': nickName,
      'createdAt': createdAt,
      'numberOfPeople': numberOfPeople,
    };
  }
}
