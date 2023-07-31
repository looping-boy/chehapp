import 'dart:math';

// import 'package:audioplayers/audio_cache.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
// import 'package:audioplayers/audioplayers.dart';



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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final channel = IOWebSocketChannel.connect('wss://chehapp-e6007e815983.herokuapp.com');
  // final audioPlayer = AudioPlayer();
  static AudioCache player = AudioCache();
  static String audioFile = 'notification.mp3';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Client'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String message = snapshot.data;
                // player.load(audioFile);
                // AssetsAudioPlayer.newPlayer().open(
                //   Audio(audioFile),
                //   showNotification: true,
                // );
                player.play(audioFile);

                // Process the received message as needed
                return Text('Received message from server: $message');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  void sendIMUData() async {
    while (true) {
        channel.sink.add("Cheh");
        print('Sending data');
        await Future.delayed(Duration(milliseconds: 1000));
    }
  }
  @override
  void initState() {
    super.initState();
    player.load(audioFile);

    sendIMUData();
  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}