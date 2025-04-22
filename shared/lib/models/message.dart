import '../enum/message_type.dart';

class Message {
  final MessageType type;
  final String? roomId;
  final String? playerName;
  final String? message;
  final List<String>? players;

  Message({
    required this.type,
    this.roomId,
    this.playerName,
    this.message,
    this.players,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'roomId': roomId,
      'playerName': playerName,
      'message': message,
      'players': players,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: MessageType.values.firstWhere((e) => e.name == json['type']),
      roomId: json['roomId'],
      playerName: json['playerName'],
      message: json['message'],
      players: (json['players'] as List?)?.cast<String>(),
    );
  }
}
