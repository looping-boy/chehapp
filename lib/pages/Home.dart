import 'dart:ui';

import 'package:flutter/material.dart';

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
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  late PageController pageController;
  late Animatable<Gradient> background;

  Color colorGradient = Colors.blue[400]!;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    setBackground();
    pageController = PageController();
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
    _initialize();
    super.reassemble();
  }

  Widget nextPage = const SendChat();

  void buttonIndexChange(int buttonIndex) {
    if (buttonIndex == 0) {
      setState(() {
        colorGradient = Colors.blue[400]!;
        nextPage = const SendChat();
        setBackground();
      });
    } else if (buttonIndex == 1) {
      setState(() {
        colorGradient = Colors.green[400]!;
        nextPage = const SnakeGame();
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
          final color =
              pageController.hasClients ? pageController.page! / 3 : .0;

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
