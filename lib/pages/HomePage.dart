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

  final shadowLight = const TextStyle(
      shadows: [
        BoxShadow(
            blurRadius: 20.0,
            offset: Offset(-10.0, -10.0),
            color: Color(0x55ffffff)),
        BoxShadow(
            blurRadius: 20.0,
            offset: Offset(10.0, 10.0),
            color: Color(0x44000000))
      ]);

  final shadowStrong = const TextStyle(
      shadows: [
        BoxShadow(
            blurRadius: 20.0,
            offset: Offset(-10.0, -10.0),
            color: Color(0xffffffff)),
        BoxShadow(
            blurRadius: 20.0,
            offset: Offset(10.0, 10.0),
            color: Color(0xff000000))
      ]);

  List functionalities = [
    ["Join The Room", "lib/icons/user.png", false],
    ["Snake Cheh", "lib/icons/gamepad.png", true],
  ];

  void switchChanged(bool value, int index) {
    setState(() {
      functionalities[index][2] = value;

    });
  }



  Alignment align = const Alignment(12, 0);
  void animTitle() {
    setState(() {
    align = Alignment.centerLeft;
  });
    Future.delayed(const Duration(milliseconds: 200), () {
      animBar();
      Future.delayed(const Duration(milliseconds: 150), () {
        animText();
      });
    });
  }

  Alignment alignBar = const Alignment(12, 0);
  void animBar() { setState(() { alignBar = Alignment.centerLeft; }); }

  Alignment alignText = const Alignment(12, 0);
  void animText() { setState(() { alignText = Alignment.centerLeft; }); }

  double opacity = 0;

  void animOpacity() {
    setState(() {
      opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
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
                  Container(
                    width: 75.0,
                    height: 75.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: (Colors.grey[900])!,
                          width: 4.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: AnimatedOpacity(
                            duration: const Duration(seconds: 1),
                            curve: Curves.decelerate,
                            opacity: opacity,
                            child: Image.asset(
                              "lib/icons/cheh.png",
                              height: 45,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[900],
                    ),

                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: AnimatedContainer(
                  alignment: align,
                  onEnd: () => { },
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to the",
                          style: shadowStrong.merge(
                              TextStyle(fontSize: 20, color: Colors.grey[700])),),
                        Text(
                          "CHEH APP",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 72,
                              textStyle: shadowLight
                          ),
                        ),
                      ]),
                ),

            ),
            const SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 8.0),
              child: AnimatedContainer(
                alignment: alignBar,
                onEnd: () => { },
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
                child: Container(
                  height: 2.0,
                  width: 250.0,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),

            AnimatedContainer(
              alignment: alignText,
              onEnd: () => { animOpacity() },
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Try our features below :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[900],
                  ),),
              ),
            ),

            Expanded(
                child: GridView.builder(
                    itemCount: functionalities.length,
                    padding: const EdgeInsets.all(25),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 0.6
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
    // animTitle();
    WidgetsBinding.instance.addPostFrameCallback((_) => animTitle());

    // player.load(audioFile);

    // sendIMUData();
  }

  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }
}
