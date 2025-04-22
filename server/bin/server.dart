import 'package:server/interfaces/web_socket_server.dart';
import 'package:server/web_socket_server_impl.dart';
import 'package:shared/models/room.dart';

final Map<String, Room> rooms = {};

void main() async {
  WebSocketServer server = WebSocketServerImpl(
    port: 3000,
    onConnect: (socket) {
      socket.add('Hello, client!');
    },
    onMessage: (socket, message) {
      print(socket);
      print('Received message: $message');
    },
    onDisconnect: (socket) {
      print('Client disconnected');
    },
  );

  await server.start();
}
