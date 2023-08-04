import 'dart:ui';

import 'package:flutter/material.dart';

class GradientTween extends Tween<Gradient> {
  GradientTween({Gradient? begin, Gradient? end}) : super(begin: begin, end: end);

  @override
  Gradient lerp(double t) {
    if (begin == null || end == null) return begin ?? end!;

    if (begin is LinearGradient && end is LinearGradient) {
      final LinearGradient beginGradient = begin as LinearGradient;
      final LinearGradient endGradient = end as LinearGradient;

      final lerpColors = List<Color>.generate(
        beginGradient.colors.length,
            (index) => Color.lerp(beginGradient.colors[index], endGradient.colors[index], t)!,
      );

      return LinearGradient(
        begin: Alignment.lerp(beginGradient.begin as Alignment?, endGradient.begin as Alignment?, t)!,
        end: Alignment.lerp(beginGradient.end as Alignment?, endGradient.end as Alignment?, t)!,
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

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    background = TweenSequence<Gradient>([
      TweenSequenceItem(
        weight: 1.0,
        tween: GradientTween(
          begin: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.deepPurple[400]!],
          ),
          end: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.yellow[300]!],
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
    pageController = PageController();
  }

  @override
  void reassemble() {
    pageController.dispose();
    _initialize();
    super.reassemble();
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
        child: PageView(
          controller: pageController,
          children: [
            Center(child: Text("Orange", style: TextStyle(fontSize: 30, color: Colors.white))),
            Center(child: Text("Purple", style: TextStyle(fontSize: 30, color: Colors.white))),
            Center(child: Text("Lime", style: TextStyle(fontSize: 30, color: Colors.white))),
            Center(child: Text("Blue", style: TextStyle(fontSize: 30, color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
