import 'package:client/app_constants.dart';
import 'package:client/splendor_game_page.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final channel = WebSocketChannel.connect(Uri.parse(AppConstants.localhost));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplendorGamePage(channel: channel),
    );
  }
}
