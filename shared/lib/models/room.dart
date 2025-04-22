import 'dart:io';

class Room {
  final String id;
  final List<WebSocket> sockets = [];

  Room(this.id);
}
