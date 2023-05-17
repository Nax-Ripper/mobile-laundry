import 'package:flutter/material.dart';
import 'dart:math' as math;


class FlippingPageRoute<T> extends PageRouteBuilder<T> {
  FlippingPageRoute({required WidgetBuilder builder})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final forwardAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));
            final reverseAnimation = animation.drive(Tween(begin: 1.0, end: 0.0));
            final rotateAnimation = animation.drive(Tween(begin: 0.0, end: -0.5));

            return Stack(
              children: [
                Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(forwardAnimation.value * math.pi / 2),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.5,
                      child: child,
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(reverseAnimation.value * math.pi / 2),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: child,
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(0.0, 0.0, -150.0)
                    ..rotateX(rotateAnimation.value * math.pi),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            );
          },
        );
}
