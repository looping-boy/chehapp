import 'dart:math';

import 'package:chehapp/components/CustomAppBar.dart';
import 'package:chehapp/pages/SendChat.dart';
import 'package:chehapp/pages/SnakeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../components/CustomAppBar2.dart';
import '../components/MenuItems.dart';
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

  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    // _maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onPanUpdate: (details) {
          _offset = Offset(0, _offset.dy + details.delta.dy);
          if (_offset.dy < _MyHomePageState._minHeight) {
            _offset = Offset(0, _MyHomePageState._minHeight);
          } else if (_offset.dy > _MyHomePageState._maxHeight) {
            _offset = Offset(0, _MyHomePageState._maxHeight);
          }

          changeBlurAndOpacity();

          setState(() {});
        },
        onPanEnd: _handlePanEnd,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
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
            CustomAppBar2(offset: _offset, opacity: _opacity, onChehClicked: openOrCloseMenu),
            MenuItems(offset: (_offset.dy - _minHeight) / (_maxHeight - _minHeight),),
            SafeArea(child: Text(((_offset.dy - _minHeight) / (_maxHeight - _minHeight)).toString())),
          ],
        ),
      ),
    );
  }

  String test = "Test";

  void changeBlurAndOpacity() {
    _blurValue = pow((_offset.dy - _minHeight) / (_maxHeight - _minHeight), 1 / 3) * 20;
    double t = (_offset.dy - _minHeight) / (_maxHeight - _minHeight);
    _opacity = pow(t, 1 / 1.5).toDouble();
  }

  void openOrCloseMenu() {
    double snapHeight = _isOpen ? _minHeight : _maxHeight;
    _animation = Tween<double>(begin: _offset.dy, end: snapHeight).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _isOpen = !_isOpen;
  }

  void _handlePanEnd(_) {
    double snapHeight;

    if (_offset.dy < (_maxHeight - _minHeight) / 2 + _minHeight) {
      snapHeight = _minHeight;
      _isOpen = false;
    } else {
      snapHeight = _maxHeight;
      _isOpen = true;
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
      duration: const Duration(milliseconds: 200),

    );
    _animation = Tween<double>(begin: _offset.dy, end: _offset.dy).animate(_animationController)
      ..addListener(() {
        setState(() {
          _offset = Offset(0, _animation.value);
          changeBlurAndOpacity();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
