import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;

  const DateWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat("dd").format(date),style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold) ,),
        CircleAvatar(

          radius: 11,
       child: Text(DateFormat("MMM").format(date),style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
        ),
        Text(DateFormat("yyyy").format(date),style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold) ,),
      ],
    );
  }
}
