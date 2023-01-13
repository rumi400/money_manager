import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function() onTap;
  final Widget icon;
  final Color? backgroundColor;
  const CircleButton({Key? key, required this.onTap, required this.icon, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      child: IconButton(
        onPressed: onTap,
        icon: icon,
        splashRadius: 20,
      ),
    );
  }
}
