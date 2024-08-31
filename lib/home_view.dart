import 'dart:math';

import 'package:example07/polygon.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;
  late AnimationController _radiusController;
  late Animation<double> _radiousAnimation;
  late Animation<double> _rotationAnimation;
  late AnimationController _rotationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_sidesController);

    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _radiousAnimation = Tween(
      begin: 20.0,
      end: 400.0,
    ).chain(CurveTween(curve: Curves.bounceInOut)).animate(
          _radiusController,
        );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    _rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * pi,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _sidesController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _sidesController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _sidesController,
            _radiusController,
            _rotationController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value)
                ..rotateY(_rotationAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              child: CustomPaint(
                painter: Polygon(sides: _sidesAnimation.value),
                child: SizedBox(
                  width: _radiousAnimation.value,
                  height: _radiousAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
