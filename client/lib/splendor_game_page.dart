import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared/enum/message_type.dart';
import 'package:shared/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SplendorGamePage extends StatefulWidget {
  final WebSocketChannel channel;

  const SplendorGamePage({required this.channel});

  @override
  SplendorGamePageState createState() => SplendorGamePageState();
}

class SplendorGamePageState extends State<SplendorGamePage> {
  late String message;

  @override
  void initState() {
    super.initState();
    message = '';
    widget.channel.stream.listen((data) {
      setState(() {
        message = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Splendor Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('서버로부터 받은 메시지: $message'),
            ElevatedButton(
              onPressed: () {
                final Message message = Message(
                  type: MessageType.roomCreated,
                  message: '방 만들어라',
                  playerName: 'Jay',
                );

                widget.channel.sink.add(jsonEncode(message));
              },
              child: Text('게임 행동 전송'),
            ),
          ],
        ),
      ),
    );
  }
}
