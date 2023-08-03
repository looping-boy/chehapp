import 'package:chehapp/components/SmartHomeButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  // final channel = IOWebSocketChannel.connect('wss://chehapp-e6007e815983.herokuapp.com');
  // static AudioCache player = AudioCache();
  // static String audioFile = 'notification.mp3';

  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  List functionalities = [
    ["Send Chat", "lib/icons/user.png", false],
    ["Multi", "lib/icons/group.png", false],
    ["Snake Cheh", "lib/icons/gamepad.png", true],
    ["Info", "lib/icons/info.png", true],
  ];

  void switchChanged(bool value, int index) {
    setState(() {
      functionalities[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/icons/fourdots.png",
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  Hero(
                    tag: functionalities[0][0],
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Home",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                    Text(
                      "Testing",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 72,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Divider(
                color: Colors.grey[200],
                thickness: 1,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "All da functionalities",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[800],
                ),),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: functionalities.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(25),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2
                    ),
                    itemBuilder: (context, index) {
                      return SmartHomeButton(
                        smartButtonName: functionalities[index][0],
                        iconPath: functionalities[index][1],
                        powerOn: functionalities[index][2],
                        onChanged: (value) => switchChanged(value, index),
                      );
                    }))
          ],
        ),
      ),
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
    // player.load(audioFile);

    // sendIMUData();
  }

  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }
}
