import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final Function()? onPressed;
  final Text? title;
  final Text? subtitle;
  final int? index;
  final Widget? icon;
  final Widget? leading;

  const MyListTile({Key? key, this.onPressed, this.title, this.subtitle, this.index, this.icon, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 0),
      child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
          leading: leading ,
          title: title,
          subtitle: subtitle,
          trailing: icon,
          onTap:onPressed
      ),
    );
  }
}
