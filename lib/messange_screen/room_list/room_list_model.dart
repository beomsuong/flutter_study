class RoomListModel {
  final String lastMsg;
  final String roomName;

  RoomListModel({required this.roomName, required this.lastMsg});

  // JSON에서 Message 객체로 변환하는 fromJson 생성자
  factory RoomListModel.fromJson(Map<String, dynamic> json) {
    return RoomListModel(
      roomName: json['roomName'] as String,
      lastMsg: json['lastMsg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMsg': lastMsg,
      'roomName': roomName,
    };
  }
}
