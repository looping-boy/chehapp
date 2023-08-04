import 'package:chehapp/components/CustomAppBar.dart';
import 'package:chehapp/pages/Home.dart';
import 'package:chehapp/pages/SendChat.dart';
import 'package:chehapp/pages/SnakeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'MainPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  // final channel = IOWebSocketChannel.connect('wss://chehapp-e6007e815983.herokuapp.com');
  // static AudioCache player = AudioCache();
  // static String audioFile = 'notification.mp3';

  Color menuColor = (Colors.grey[500])!;

  final CarouselSliderController controller = CarouselSliderController();

  List<Color> change = [(Colors.grey[400])!, (Colors.grey[400])!];

  void animGradient(Color color) {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        change = [(Colors.grey[400])!, color];
      });
    });
  }

  Widget nextPage = const SendChat();

  void buttonIndexChange(int buttonIndex) {
    if (buttonIndex == 0) {
      setState(() { nextPage = const SendChat(); });
      animGradient((Colors.grey[900])!);
    }
    else if (buttonIndex == 1) {
      setState(() { nextPage = const SnakeGame(); });
      animGradient((Colors.grey[100])!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: CustomAppBar(carouselSliderController: controller),
      body: Home(),
    );
  }

  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text('WebSocket Client'),
  //       ),
  //       body: Center(
  //         child: StreamBuilder(
  //           stream: channel.stream,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               String message = snapshot.data;
  //               player.play(audioFile);
  //
  //               // Process the received message as needed
  //               return Text('Received message from server: $message');
  //             } else if (snapshot.hasError) {
  //               return Text('Error: ${snapshot.error}');
  //             } else {
  //               return CircularProgressIndicator();
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void sendIMUData() async {
  //   while (true) {
  //       channel.sink.add("Cheh");
  //       print('Sending data');
  //       await Future.delayed(Duration(milliseconds: 1000));
  //   }
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => animGradient(menuColor));

    // animOpacity();
    // animTitle();
    // player.load(audioFile);

    // sendIMUData();
  }

  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }
}
