import 'dart:async';
import 'dart:math' as math;
import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/ui/transition_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Widget _img;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 6,
      ),
    );
    _img = Image.asset('assets/images/inicio.jpg');
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
          child: Image.asset('assets/images/inicio.jpg'),
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
            child: const TransitionScreen(),
          );
        },
        transitionDuration: const Duration(seconds: 3)));
  }

  _cloudAnimation() {
    _animationController.forward().whenComplete(navigate);
  }
}
