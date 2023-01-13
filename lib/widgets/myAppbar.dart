
import 'package:money_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;

  const MyAppBar({Key? key,  this.leading, this.title, this.actions, this.centerTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 40,top: 30),
      height: 210,
      width: double.maxFinite,
      decoration:   BoxDecoration(
        color: MyAppColors.primaryColor,
        borderRadius: const BorderRadius.only(bottomLeft:Radius.elliptical(200,25),bottomRight: Radius.elliptical(200,25))
      ),
      child: Column(
        children: [
          SizedBox(
              height: 70,
              child: AppBar(
                centerTitle: centerTitle,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: title,
                leading: leading,
                actions: actions,
              )
          ),
        ],
      )
      // Row(
      //   children: [
      //     SizedBox(
      //       width: MediaQuery.of(context).size.width * 0.80,
      //       child: Row(
      //         mainAxisAlignment: centerTitle == false || centerTitle == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
      //         children: [
      //           leading ?? const SizedBox.shrink() ,
      //           centerTitle == false || centerTitle == null ? const SizedBox.shrink() :
      //           const SizedBox(width: 5,),
      //           title?? const SizedBox.shrink(),
      //         ],
      //       ),
      //     ),
      //     trailing ?? const SizedBox.shrink()
      //   ],
      // ),
    );
  }
}
