import 'package:flutter/material.dart';

var curve = Curves.ease;
var curveTween = CurveTween(curve: curve);

class CustomerPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomerPageRoute({
    required this.child,
  }) : super(
            transitionDuration: Duration(milliseconds: 200),
            reverseTransitionDuration: Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: animation.drive(
                          Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                              .chain(curveTween)),
                      child: child,
                    ));
}
