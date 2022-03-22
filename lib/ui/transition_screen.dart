import 'dart:async';
import 'dart:math' as math;
import 'package:amalia_musica/constants/colors.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class TransitionScreen extends StatefulWidget {
  const TransitionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 6,
      ),
    );
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.rosaBase,
        body: AnimatedBuilder(
          animation: _animationController,
          child: Image.asset('assets/images/2.jpg'),
          builder: (BuildContext context, Widget? child) {
            final animation = Tween(begin: 0.0, end: 1.0,).animate(_animationController);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ));
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 50);
    return Timer(_duration, _cloudAnimation);
  }

  navigate() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: const HomeScreen(),
          );
        },
        transitionDuration: const Duration(seconds: 3)));
  }

  _cloudAnimation() {
    _animationController.forward().whenComplete(navigate);
  }
}
