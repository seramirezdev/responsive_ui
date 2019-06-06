import 'package:flutter/material.dart';
import 'package:responsive_ui/widgets/app_bottom_bar.dart';
import 'package:responsive_ui/widgets/profile_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.90;
  double expandedHeightFactor = 0.55;
  double screenHeight = 0;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (!isAnimationCompleted) {
        _controller.fling(velocity: -1);
      } else {
        _controller.fling(velocity: 1);
      }
      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  imageWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactorAnimation.value,
            child: ProfilePageView()),
        GestureDetector(
          onTap: () {
            onBottomPartTap();
          },
          onVerticalDragUpdate: _handleVerticalUpdate,
          onVerticalDragEnd: _handleVerticalEnd,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.06 - _heightFactorAnimation.value,
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)))),
          ),
        )
      ],
    );
  }

  _handleVerticalUpdate(DragUpdateDetails udpateDetails) {
    double fractionDragged = udpateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - 5 * fractionDragged;
  }

  _handleVerticalEnd(DragEndDetails endDetails) {
    if (_controller.value >= 0.5) {
      _controller.fling(velocity: 1);
    } else {
      _controller.fling(velocity: -1);
    }
    isAnimationCompleted = !isAnimationCompleted;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return imageWidget();
        },
      ),
      bottomNavigationBar: AppBottomBar(),
    );
  }
}
