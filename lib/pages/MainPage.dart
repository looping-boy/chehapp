import 'package:chehapp/components/SmartHomeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void IntCallback(int index);

class MainPage extends StatefulWidget {


  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  // final channel = IOWebSocketChannel.connect('wss://chehapp-e6007e815983.herokuapp.com');
  // static AudioCache player = AudioCache();
  // static String audioFile = 'notification.mp3';

  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  List functionalities = [
    ["Cheh Room", "lib/icons/user.png", false],
    ["Snake Cheh", "lib/icons/gamepad.png", true],
  ];

  void switchChanged(bool value, int index) {
    setState(() {
      functionalities[index][2] = value;
    });
  }

  final shadowLight = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x55ffffff)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0x44000000))
  ]);

  final shadowStrong = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0xffffffff)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0xff000000))
  ]);

  Alignment align = const Alignment(20, 0);
  bool startAnimation = false;
  double screenWidth = 0;

  void animTitle() {
    setState(() {
      align = Alignment.centerLeft;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      animBar();
      Future.delayed(const Duration(milliseconds: 150), () {
        animText();
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() {
            startAnimation = true;
          });
        });
      });
    });
  }

  Alignment alignBar = const Alignment(20, 0);

  void animBar() {
    setState(() {
      alignBar = Alignment.centerLeft;
    });
  }

  Alignment alignText = const Alignment(20, 0);

  void animText() {
    setState(() {
      alignText = Alignment.centerLeft;
    });
  }

  void setCarousel(int buttonIndex) {
    // widget.buttonIndex(buttonIndex);
    // widget.carouselSliderController.nextPage(const Duration(milliseconds: 300));
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.height;
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: AnimatedContainer(
              alignment: align,
              onEnd: () => {},
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Welcome to the",
                    style: shadowStrong
                        .merge(TextStyle(fontSize: 20, color: Colors.grey[700])),
                  ),
                ),
                Text(
                  "CHEH APP",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 72, textStyle: shadowLight),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 8.0),
            child: AnimatedContainer(
              alignment: alignBar,
              onEnd: () => {},
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
            onEnd: () => {},
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
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
                height: 400,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    itemCount: functionalities.length,
                    padding: const EdgeInsets.all(25),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          setCarousel(index)
                        },
                        child: AnimatedContainer(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 300 + (index * 150)),
                          transform: Matrix4.translationValues(
                              0, startAnimation ? 0 : screenWidth, 0),
                          child: SmartHomeButton(
                            smartButtonName: functionalities[index][0],
                            iconPath: functionalities[index][1],
                            powerOn: functionalities[index][2],
                            onChanged: (value) => switchChanged(value, index),
                          ),
                        ),
                      );
                    })),
          )
        ],
      );

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => animTitle());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
