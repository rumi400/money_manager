import 'dart:math';

import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';

class ExpansionTileWidget extends StatelessWidget {

  final String title;
  final List<String> items;
  final Function(String) callBack;
  final Widget? leading;
  const ExpansionTileWidget({Key? key, required this.title,  required this.items, required this.callBack, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyAppColors.primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(5)
      ),
      child: ExpansionTile(
        leading: leading,
        title: Text(title),
       // key : Key(title.toString()),
        children: items.map((i)
        {
          return ListTile(
            title: Text(i),
            onTap: (){
              callBack(i);
            },
          );
        }
        ).toList(),
      ),
    );
  }
}
