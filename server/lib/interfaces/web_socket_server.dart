abstract interface class WebSocketServer {
  Future<void> start();
  void broadcast(String message);
}
