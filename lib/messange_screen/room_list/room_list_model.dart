class RoomListModel {
  final String roomName;
  final String lastMsg;
  final DateTime lastTime;

  RoomListModel({
    required this.roomName,
    required this.lastMsg,
    required this.lastTime,
  });

  factory RoomListModel.fromJson(String roomName, Map<String, dynamic> json) {
    return RoomListModel(
      roomName: roomName,
      lastMsg: json['lastMsg'] as String,
      lastTime: DateTime.parse(json['lastTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'lastTime': lastTime.toIso8601String(),
    };
  }
}
