import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/Globals.dart';
import 'MainPage.dart';
import 'SendChat.dart';
import 'SnakeGame.dart';

class GradientTween extends Tween<Gradient> {
  GradientTween({Gradient? begin, Gradient? end})
      : super(begin: begin, end: end);

  @override
  Gradient lerp(double t) {
    if (begin == null || end == null) return begin ?? end!;

    if (begin is LinearGradient && end is LinearGradient) {
      final LinearGradient beginGradient = begin as LinearGradient;
      final LinearGradient endGradient = end as LinearGradient;

      final lerpColors = List<Color>.generate(
        beginGradient.colors.length,
        (index) => Color.lerp(
            beginGradient.colors[index], endGradient.colors[index], t)!,
      );

      return LinearGradient(
        begin: Alignment.lerp(beginGradient.begin as Alignment?,
            endGradient.begin as Alignment?, t)!,
        end: Alignment.lerp(
            beginGradient.end as Alignment?, endGradient.end as Alignment?, t)!,
        colors: lerpColors,
        tileMode: t < 0.5 ? beginGradient.tileMode : endGradient.tileMode,
        transform: t < 0.5 ? beginGradient.transform : endGradient.transform,
      );
    }

    // Handle other types of gradients if needed.
    // This part might need additional implementation.

    return t < 0.5 ? begin! : end!;
  }
}

class Home extends StatefulWidget {

  Home({super.key});

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  late PageController pageController;
  late Animatable<Gradient> background;

  Color colorGradient = Colors.blue[400]!;

  double _currentPage = 0;


  @override
  void initState() {
    super.initState();
    setBackground();
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) => initializePageView());
  }

  void initializePageView() {
    _currentPage = 0;
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });

      if (_currentPage < 0.5) {
        context.read<Globals>().setPageName("Cheh App");
      } else {
        context.read<Globals>().setPageName(pageName);
      }

    });
  }

  void setBackground() {
    background = TweenSequence<Gradient>([
      TweenSequenceItem(
        weight: 1.0,
        tween: GradientTween(
          begin: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.grey[400]!],
          ),
          end: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorGradient, Colors.grey[400]!],
          ),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: GradientTween(
          begin: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.yellow[300]!],
          ),
          end: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.blue[400]!],
          ),
        ),
      ),
      // Add more pages here if needed.
    ]);
  }

  @override
  void reassemble() {
    pageController.dispose();
    setBackground();
    pageController = PageController();
    super.reassemble();
  }

  Widget nextPage = const SendChat();

  String pageName = "Cheh Room";

  void buttonIndexChange(int buttonIndex) {
    if (buttonIndex == 0) {
      setState(() {
        colorGradient = Colors.blue[400]!;
        nextPage = const SendChat();
        pageName = "Cheh Room";
        setBackground();
      });
    } else if (buttonIndex == 1) {
      setState(() {
        colorGradient = Colors.green[400]!;
        nextPage = const SnakeGame();
        pageName = "Cheh Snake";
        setBackground();
      });
    }
    pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {

          final color = pageController.hasClients ? pageController.page! / 3 : .0;

          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: background.evaluate(AlwaysStoppedAnimation(color)),
            ),
            child: child,
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: PageView(
              controller: pageController,
              children: [
                MainPage(buttonIndex: (int buttonIndex) {
                  buttonIndexChange(buttonIndex);
                }),
                nextPage
              ],
            ),
          ),
        ),
      ),
    );
  }
}
