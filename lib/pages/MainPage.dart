import 'package:chehapp/components/SmartHomeButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void IntCallback(int index);

class MainPage extends StatefulWidget {
  final IntCallback buttonIndex;

  const MainPage({super.key, required this.buttonIndex});

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

  bool startAnimation = false;
  double screenWidth = 0;

  void animTitle() {
    Future.delayed(const Duration(milliseconds: 150), () {
    animWalkie();
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
    });
  }

  bool animWalke = false;
  void animWalkie() {
    setState(() {
      animWalke = true;
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

  void setButtonIndex(int buttonIndex) {
    widget.buttonIndex(buttonIndex);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedContainer(
            alignment: Alignment.centerLeft,
            onEnd: () => {},
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(animWalke ? 0 : screenWidth, 0, 0),
            curve: Curves.decelerate,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Try our new features below :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 10.0),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FractionColumnWidth(.6),
                        1: FractionColumnWidth(.1),
                        2: FractionColumnWidth(.3),
                      },
                      children: [
                        TableRow(children: [
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  // boxShadow: shadow,
                                  border: Border.all(
                                      color: (Colors.grey[800])!, width: 4),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey[900]!,
                                          width: 4.0,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey[200],
                                          backgroundImage: const AssetImage(
                                            "lib/icons/walkie.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Walkie",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.fill,
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    // boxShadow: shadow,
                                    border: Border.all(
                                        color: (Colors.grey[800])!, width: 4),
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(24)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: const Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    "Push To Talk",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),

                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(
                horizontalPadding, 0, horizontalPadding, 8.0),
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
                "Access to the games :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[900],
                ),
              ),
            ),
          ),
          SizedBox(
              height: 400,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: functionalities.length,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {setButtonIndex(index)},
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 300 + (index * 150)),
                        transform: Matrix4.translationValues(
                            startAnimation ? 0 : screenWidth, 0, 0),
                        child: SmartHomeButton(
                          smartButtonName: functionalities[index][0],
                          iconPath: functionalities[index][1],
                          powerOn: functionalities[index][2],
                          onChanged: (value) => switchChanged(value, index),
                        ),
                      ),
                    );
                  })),
        ],
      ),
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
