import 'package:flutter/material.dart';
import 'package:responsive_ui/models/profile.dart';

class ProfilePageView extends StatefulWidget {
  double opacity = 0.5;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation;
  Animation _fadeAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _slideAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem<Offset>(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0)))
    ]).animate(_controller);

    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(weight: 10, tween: Tween(begin: 1, end: 0)),
      TweenSequenceItem<double>(weight: 90, tween: Tween(begin: 0, end: 1))
    ]).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
            itemCount: profiles.length,
            controller: PageController(initialPage: 0),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                _controller.reset();
                _controller.forward();
              });
            },
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    profiles[index].imagePath,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.color,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(widget.opacity),
                        Colors.white.withOpacity(0.1),
                        Colors.black.withOpacity(widget.opacity)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                  ),
                ],
              );
            }),
        Positioned(
          bottom: 60,
          left: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProfileDetails(
              index: currentIndex,
              slideAnimation: _slideAnimation,
              fadeAnimation: _fadeAnimation,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final int index;
  final Animation slideAnimation;
  final Animation fadeAnimation;

  ProfileDetails({this.index, this.slideAnimation, this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TwoLineWidget(
              firstText: profiles[index].followers.toString(),
              secondText: "followers",
              alignment: 1,
            ),
            TwoLineWidget(
              firstText: profiles[index].post.toString(),
              secondText: "posts",
              alignment: 2,
            ),
            TwoLineWidget(
              firstText: profiles[index].following.toString(),
              secondText: "following",
              alignment: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class TwoLineWidget extends StatelessWidget {
  final String firstText, secondText;
  final int alignment;

  TwoLineWidget({this.firstText, this.secondText, this.alignment});

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment cross;
    switch (alignment) {
      case 1:
        cross = CrossAxisAlignment.start;
        break;
      case 2:
        cross = CrossAxisAlignment.center;
        break;
      case 3:
        cross = CrossAxisAlignment.end;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: cross,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        Text(
          secondText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w200, fontSize: 16.0),
        ),
      ],
    );
  }
}
