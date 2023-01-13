
import 'package:flutter/material.dart';

class ExpenseViewModel extends  ChangeNotifier {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  

}