class RoomListModel {
  final String roomName;
  final String lastMsg;
  final DateTime lastTime;
  final int? numberOfPeople;

  RoomListModel({
    required this.roomName,
    required this.lastMsg,
    required this.lastTime,
    this.numberOfPeople,
  });

  factory RoomListModel.fromJson(String roomName, Map<String, dynamic> json) {
    return RoomListModel(
        roomName: roomName,
        lastMsg: json['lastMsg'] as String,
        lastTime: DateTime.parse(json['lastTime']),
        numberOfPeople: json['numberOfPeople']);
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'lastTime': lastTime.toIso8601String(),
      'numberOfPeople': numberOfPeople,
    };
  }
}
