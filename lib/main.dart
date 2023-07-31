import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';


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
  final channel = IOWebSocketChannel.connect('wss://cube-app-ded2c0470b54.herokuapp.com/');

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
    int i = 0;

    Map<String, double> currentRotation = {
      'gyro_x': 0.0,
      'gyro_y': 0.0,
      'gyro_z': 0.0,
    };

    while (true) {
      Map<String, double> targetRotation = {
        'gyro_x': Random().nextDouble() * 2 - 1.0,
        'gyro_y': Random().nextDouble() * 2 - 1.0,
        'gyro_z': Random().nextDouble() * 2 - 1.0,
      };

      // Initialize the gyroscope stream
      gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          // Update the currentRotation dictionary with gyroscope data
          currentRotation['gyro_x'] = event.x;
          currentRotation['gyro_y'] = event.y;
          currentRotation['gyro_z'] = event.z;
        });
      });

      // int duration = 30;
      // for (int frame = 0; frame < duration; frame++) {
      //   double t = frame / duration;
      //   Map<String, double> easedRotation = {};
      //   for (String axis in ['gyro_x', 'gyro_y', 'gyro_z']) {
      //     easedRotation[axis] = (currentRotation[axis]! + (targetRotation[axis]! - currentRotation[axis]!) * t);
      //   }
      //
      //   // Convert to JSON and send to the server
        String message = json.encode(currentRotation);
        channel.sink.add(message);
        print('Sending data $i');
      //   i++;
      //
      //   // Wait for some time before sending the next frame
        await Future.delayed(Duration(milliseconds: 20));
      // }
      //
      // // Update the current rotation to the target rotation after the transition
      // currentRotation = targetRotation;
    }
  }
  @override
  void initState() {
    super.initState();
    sendIMUData();
  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}