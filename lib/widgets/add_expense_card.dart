import 'package:flutter/material.dart';

import '../utils/colors.dart';
class AddExpenseCard extends StatelessWidget {
  final Widget child;

  const AddExpenseCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      // height:  MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          color: MyAppColors.secondaryColor2,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
       child: child
      ),
    );
  }
}
