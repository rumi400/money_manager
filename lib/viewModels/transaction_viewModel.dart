
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/chat_data_model.dart';
import 'package:money_manager/models/expense_model.dart';
import 'package:money_manager/services/firebase_service.dart';
import 'package:money_manager/utils/utils.dart';

class TransactionViewModel extends  ChangeNotifier {

  static final String _today = Common.getFormattedDate(DateTime.now());
  final titleController = TextEditingController();
  final passwordController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController(text: _today);
  final startDateController = TextEditingController(text: _today);
  final endDateController = TextEditingController(text: _today);

  final searchController = TextEditingController();

  final descController = TextEditingController();
  File? _image;
  double _totalExpenses = 0;
  bool _update = false;
  bool _isFirstSelected = true;
  bool uploading = false;
  String _imageUrl = '';

  List<ChartData> _chartDataExpenses = [];

  List<ChartData> get chartDataExpenses => _chartDataExpenses;
  List<ChartData> _chartDataIncome = [];

  List<ChartData> get chartDataIncome => _chartDataIncome;

  String _id = "";

  bool get update => _update;
  bool get isFirstSelected => _isFirstSelected;

  double get  totalExpenses => _totalExpenses;

  double _totalIncome = 0;

  double get  totalIncome => _totalIncome;

  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  List<Transaction> _expenses = [];

  List<Transaction> get expenses => _expenses;

  List<Transaction> _incomes = [];

  List<Transaction> get incomes => _incomes;

  List<Transaction> _expenseChartData = [];

  List<Transaction> get expenseChartData => _expenseChartData;

  List<Transaction> _incomeChartData = [];

  List<Transaction> get incomeChartData => _incomeChartData;

  String _category = 'Expense';

  String get category => _category;

  File? get image => _image;
  DateTime _selectedDate = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final List<String> _types = ['Fuel', 'Utility','Food', 'Outing', 'Grocery', 'Health'];

  final List<String> _expenseTypes = ['Expenses', 'Income'];
  String _type = "Select Expense Type";
  String _statisticType = "Select Statistics";

  String get type => _type;
  String get statisticType => _statisticType;
  List<String> get items => _types;
  List<String> get expenseItems => _expenseTypes;
  DateTime get selectedData => _selectedDate;

  setCategory(String val){
    _category = val;
    if(val == "Expense")
      {
        setType("Select Expense Type");
        _isFirstSelected = true;
      }
    else
      {
        setType("Select Income Type");
        _isFirstSelected = false;
      }
    notifyListeners();
  }

  setImage(XFile? image)
  {
    File file = File(image!.path);
    _image = file;
    notifyListeners();
  }

  setSelectedDate(BuildContext context) async
  {
    _selectedDate = await Common.showMyDatePicker(context);
    dateController.text = Common.getFormattedDate(_selectedDate);
  }
  setSelectedStartDate(BuildContext context) async
  {
    _startDate = await Common.showMyDatePicker(context);
    startDateController.text = Common.getFormattedDate(_startDate);
    dateFilter();
  }

  setSelectedEndDate(BuildContext context) async
  {
    _endDate = await Common.showMyDatePicker(context);
    endDateController.text = Common.getFormattedDate(_endDate);
    dateFilter();
  }

  setIsFirstSelected(bool val)
  {
    _isFirstSelected = val;
    notifyListeners();
  }

  setStatisticType(String val)
  {
    _statisticType = val;
    notifyListeners();
  }


  setType(String val)
  {
    _type = val;
    notifyListeners();
  }
  _fileUpload(BuildContext context) async{
    uploading = true;
    notifyListeners();
    if(_image != null){
      _imageUrl = (await FirebaseService.uploadFile(context: context, file: _image!))!;
    }
  }
  saveExpense(BuildContext context) async
  {
    if(_validate(context))
      {
        await _fileUpload(context);
        Transaction expense = Transaction(
          type: _type,
          title: titleController.text.trim(),
          amount: double.parse(amountController.text.trim()),
          date: _selectedDate,
          description:  descController.text.trim(),
          imageUrl:_imageUrl,
          category: _category,

        );
        var x = await FirebaseService.addData(
            context: context,
            collection: "Transactions",
            doc: expense.toSnapshot()
        );
        if(x== true)
          {
            Common.showNotification(
                context: context,
                title: "Data Saved",
                content: "$category Record Successfully Saved",
                messageType: MessageType.success
            );
            uploading = false;
            notifyListeners();
            clearData();
          }
      }
  }

  updateExpense(BuildContext context) async
  {
    if(_validate(context))
    {
      await _fileUpload(context);
      Transaction expense = Transaction(
        type: _type,
        title: titleController.text.trim(),
        amount: double.parse(amountController.text.trim()),
        date: _selectedDate,
        description:  descController.text.trim(),
        imageUrl: _imageUrl,
        category: _category,

      );
      var x = await FirebaseService.updateData(
          context: context,
          collection: "Transactions",
          doc: expense.toSnapshot(),
          docId: _id
      );
      if(x== true)
      {
        Common.showNotification(
            context: context,
            title: "Data Updated",
            content: "$category Record Successfully Updated",
            messageType: MessageType.success
        );
        uploading = false;
        notifyListeners();
        clearData();
      }
    }
  }

  deleteExpense(BuildContext context, String id) async
  {
    Common.showMyDialog(
        context: context,
        onPressed: () async{
          var x = await FirebaseService.deleteData(
              context: context,
              collection: "Transactions",
              docId: id
          );
          if (x == true) {
            Common.showNotification(
                context: context,
                title: "Data Deleted",
                content: "$category Record Successfully Deleted",
                messageType: MessageType.success
            );
            notifyListeners();
          }
        }
    );
  }
  clearData()
  {
    _type = "Select Expense Type";
    titleController.clear();
    amountController.clear();
    dateController.text = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    descController.clear();
    _update = false;
    _id="";
     _image = null;
    notifyListeners();
  }

  _validate(BuildContext context)
  {
    bool check = true;
    if(_type == "Select $category Type")
      {
        Common.showNotification(
            context: context,
            title: "Data Required",
            content: "Please Select $category Type",
            messageType: MessageType.error
        );
        check = false;
      }else if(titleController.text.isEmpty){
          Common.showNotification(
              context: context,
              title: "Data Required",
              content: "Expense Name is Required",
              messageType: MessageType.error
          );
          check = false;
    }else if(amountController.text.isEmpty){
      Common.showNotification(
          context: context,
          title: "Data Required",
          content: "Expense Amount is Required",
          messageType: MessageType.error
      );
      check = false;
    }

    return check;
  }

  getExpenses() async
  {
    var list  = await FirebaseService.getDocuments(collection: "Transactions",);
    _transactions = list.map((e) {
      return Transaction.fromSnapshot(e);
    } ).toList();
    _calculateSum();
    getChartData(_transactions);
    notifyListeners();
  }

  dateFilter()
  {
    List<Transaction> temp = [];


    temp = _transactions.where((element) => _dateMatch(_startDate, element.date!)).toList();
    getChartData(temp);
    notifyListeners();

  }

  bool _dateMatch(DateTime startDate, DateTime endDate)
  {
    bool exist = false;
    var duration = _endDate.difference(startDate);
    for(int i = 0; i <= duration.inDays; i++)
    {
      if(Common.getFormattedDate(startDate.add(Duration(days: i))) == Common.getFormattedDate(endDate))
        {
          exist = true;
        }
    }
    return exist;
  }


  _calculateSum()
  {
    _totalExpenses = 0;
    _totalIncome = 0;
    _expenses.clear();
    _incomes.clear();
    for(var i in _transactions)
      {
        if(i.category == "Expense")
          {
            _totalExpenses += i.amount ?? 0;
            _expenses.add(i);
          }
        else
          {
            _totalIncome += i.amount ?? 0;
            _incomes.add(i);
          }
      }
  }

  loadData(Transaction t)
  {
    titleController.text = t.title.toString();
    amountController.text = t.amount.toString();
    dateController.text = Common.getFormattedDate(t.date!);
    _selectedDate = t.date!;
    descController.text = t.description.toString();
    _update = true;
    _id = t.id.toString();
    _category = t.category;
    //todo:
    _imageUrl = t.imageUrl.toString();
    print(t.category);
    if(t.category == "Expense")
      {
        _isFirstSelected = true;
      }
    else
      {
        _isFirstSelected = false;
      }
    _type = t.type.toString();
    notifyListeners();
  }

  getChartData(List<Transaction> trans) async
  {
    List<String> titlesExpenses = [];
    List<double> valuesExpenses = [];
    List<String> titlesIncome = [];
    List<double> valuesIncome = [];
    for(var i in trans)
      {
        if(i.category == "Expense")
          {
           if(titlesExpenses.contains(i.type))
             {
               var x = titlesExpenses.indexOf(i.type.toString());
               valuesExpenses[x] += i.amount ?? 0;
             }
           else
             {
               titlesExpenses.add(i.type.toString());
               valuesExpenses.add(i.amount ?? 0);
             }
          }
        else
        {
          if(titlesIncome.contains(i.type))
          {
            var x = titlesIncome.indexOf(i.type.toString());
            valuesIncome[x] += i.amount ?? 0;
          }
          else
          {
            titlesIncome.add(i.type.toString());
            valuesIncome.add(i.amount ?? 0);
          }
        }

        _chartDataExpenses.clear();
        _chartDataIncome.clear();
        for(int i = 0; i < titlesExpenses.length; i++)
          {
            _chartDataExpenses.add(ChartData(title: titlesExpenses[i], amount: valuesExpenses[i]));
          }
        for(int i = 0; i < titlesIncome.length; i++)
        {
          _chartDataIncome.add(ChartData(title: titlesIncome[i], amount: valuesIncome[i]));
        }
      }

  }
}


enum DateFilter{
  daily,
  weekly,
  monthly,
  yearly
}
