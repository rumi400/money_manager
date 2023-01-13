import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';

class AppBarActionButton extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const AppBarActionButton({Key? key, required this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: OutlinedButton(
        style:  ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(MyAppColors.secondaryColor),
        ),
        onPressed: onTap,
        child: icon
      ),
    );
  }
}
