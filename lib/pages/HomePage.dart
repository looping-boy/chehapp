import 'package:chehapp/components/CustomAppBar.dart';
import 'package:chehapp/pages/SendChat.dart';
import 'package:chehapp/pages/SnakeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../components/CustomAppBar2.dart';
import 'Home.dart';
import 'dart:ui';
import 'MainPage.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  Color menuColor = (Colors.grey[500])!;

  final CarouselSliderController controller = CarouselSliderController();

  List<Color> change = [(Colors.grey[400])!, (Colors.grey[400])!];

  double screenWidth = 0;
  double screenHeight = 0;

  static double _minHeight = 186, _maxHeight = 600;
  Offset _offset = Offset(0, _minHeight);
  bool _isOpen = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  double _blurValue = 0;
  GlobalKey _backdropFilterKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // AnimatedBuilder(
          //   animation: _animationController,
          //   child: Home(),
          //   builder: (context, child) => BackdropFilter(
          //         filter: ui.ImageFilter.blur(
          //           sigmaX: 8.0,
          //           sigmaY: 8.0,
          //         ),
          //         child: child,
          //   )
          //   ,
          // ),
          Home(),
          IgnorePointer(
            ignoring: true,
            child: Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _blurValue, sigmaY: _blurValue),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Container(color: Colors.transparent),
                    ),
                  ),
            ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(
          //     sigmaX: 20.0,
          //     sigmaY: 20.0,
          //   ),
          //   child: Home(),
          // ),
          GestureDetector(
            onPanUpdate: (details) {
              _offset = Offset(0, _offset.dy + details.delta.dy);
              if (_offset.dy < _MyHomePageState._minHeight) {
                _offset = Offset(0, _MyHomePageState._minHeight);
                _isOpen = false;
              } else if (_offset.dy > _MyHomePageState._maxHeight) {
                _offset = Offset(0, _MyHomePageState._maxHeight);
                _isOpen = true;
              }
              _blurValue = (_offset.dy - _minHeight) / (_maxHeight - _minHeight) * 20;

              setState(() {});
            },
            onPanEnd: _handlePanEnd,
            child: AnimatedContainer(
              duration: Duration.zero,
              curve: Curves.easeOut,
              height: _offset.dy,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.0), spreadRadius: 5, blurRadius: 10)
                  ]),
              child: CustomAppBar2(),
            ),
          ),
          SafeArea(child: Text(_offset.dy.toString())),
        ],
      ),
    );
  }

  void _handlePanEnd(DragEndDetails details) {
    double snapHeight;

    if (_offset.dy < (_maxHeight - _minHeight) / 2 + _minHeight) {
      snapHeight = _minHeight;
      // _isOpen = false;
    } else {
      snapHeight = _maxHeight;
      // _isOpen = true;
    }

    _animation = Tween<double>(begin: _offset.dy, end: snapHeight).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(begin: _offset.dy, end: _offset.dy).animate(_animationController)
      ..addListener(() {
        setState(() {
          _offset = Offset(0, _animation.value);
          _blurValue = (_offset.dy - _minHeight) / (_maxHeight - _minHeight) * 20;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();

  }
}
