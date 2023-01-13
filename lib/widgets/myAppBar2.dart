import 'package:flutter/material.dart';

class MyAppBar2 extends StatelessWidget {

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;

  const MyAppBar2({Key? key,  this.leading, this.title, this.actions, this.centerTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 40,top: 40),
        height: 150,

        width: double.maxFinite,
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
