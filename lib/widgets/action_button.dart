import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final double radius;
  final Color backgroundColor;
  final bool hasShadow;
  final BoxShape shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  const ActionButton({
    Key? key,
    this.radius = 20.0,
    this.backgroundColor = Colors.white,
    this.hasShadow = true,
    this.shape = BoxShape.circle,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        boxShadow: [
          hasShadow
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                )
              : BoxShadow()
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
