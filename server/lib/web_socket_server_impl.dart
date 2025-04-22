import 'dart:convert';
import 'dart:io';

import 'package:server/interfaces/web_socket_server.dart';
import 'package:shared/models/message.dart';

typedef OnMessage = void Function(WebSocket socket, Message message);
typedef OnConnect = void Function(WebSocket socket);
typedef OnDisconnect = void Function(WebSocket socket);

class WebSocketServerImpl implements WebSocketServer {
  final int port;
  final OnMessage onMessage;
  final OnConnect onConnect;
  final OnDisconnect onDisconnect;

  final List<WebSocket> _clients = [];

  late HttpServer _server;

  WebSocketServerImpl({
    required this.port,
    required this.onMessage,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    print('Server started on port $port');

    await for (HttpRequest request in _server) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        final WebSocket socket = await WebSocketTransformer.upgrade(request);
        _clients.add(socket);
        onConnect(socket);

        socket.listen(
          (data) {
            try {
              final decoded = jsonDecode(data);
              if (decoded is Map<String, dynamic>) {
                onMessage(socket, Message.fromJson(decoded));
              }
            } catch (e) {
              print('Invalid message: $data');
            }
          },
          onDone: () {
            _clients.remove(socket);
            onDisconnect(socket);
          },
          onError: (err) {
            print('WebSocket error: $err');
            _clients.remove(socket);
            onDisconnect(socket);
          },
        );
      }
    }
  }

  @override
  void broadcast(String message) {
    for (WebSocket client in _clients) {
      client.add(message);
    }
  }
}
