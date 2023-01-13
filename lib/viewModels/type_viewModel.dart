
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_manager/models/models.dart';

import '../services/firebase_service.dart';
import '../utils/common.dart';

class  TypeViewModel  extends ChangeNotifier {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String _id = "";
  bool update = false;
  bool _isFirstSelected = true;

  List<TransactionType> _types = [];


  String _type = "Select Expense Type";

  String get type => _type;
  bool get isFirstSelected => _isFirstSelected;

  List<TransactionType> get types => _types;

  String _category = 'Expense';

  String get category => _category;

  setCategory(String val) {
    _category = val;
    notifyListeners();
  }

  setIsFirstSelected(bool val)
  {
    _isFirstSelected = val;
    notifyListeners();
  }

  setType(String val) {
    _type = val;
    notifyListeners();
  }

  _validate(BuildContext context) {
    bool check = true;
    if (titleController.text.trim().isEmpty) {
      Common.showNotification(
          context: context,
          title: "Data Required",
          content: "Please Enter Type Name",
          messageType: MessageType.error
      );
      check = false;
    }
    return check;
  }

  getTypes({String? cat}) async {
    List<QueryDocumentSnapshot<Object?>> list = [];
    if(cat != null)
      {
        list = await FirebaseService.getDocuments(collection: "Types", where: "category", whereValue: cat);
      }
    else{
      list = await FirebaseService.getDocuments(collection: "Types");
    }
    print(list.length);
    _types = list.map((e) {
      return TransactionType.fromSnapshot(e);
    }).toList();
    notifyListeners();
  }

  saveType(BuildContext context) async {
    if (_validate(context)) {
      TransactionType expense = TransactionType(
        title: titleController.text.trim(),
        category: _category,
      );
      var x = await FirebaseService.addData(
          context: context,
          collection: "Types",
          doc: expense.toSnapshot()
      );
      if (x == true) {
        Common.showNotification(
            context: context,
            title: "Data Saved",
            content: "$category Record Successfully Saved",
            messageType: MessageType.success
        );
        clearData();
        getTypes();

      }
    }
  }
  updateType(BuildContext context) async {
      if (_validate(context)) {
        TransactionType expense = TransactionType(
            title: titleController.text.trim(),
            category: category
        );
        var x = await FirebaseService.updateData(
            context: context,
            collection: "Types",
            doc: expense.toSnapshot(),
            docId: _id
        );
        if(x == true){
          Common.showNotification(
              context: context,
              title: "Data Updated",
              content: "$category Record Successfully Updated",
              messageType: MessageType.success
          );
          clearData();
          getTypes();
        }
      }
    }

  deleteType(BuildContext context, String id) async
  {
    Common.showMyDialog(
        context: context,
        onPressed: () async{
          var x = await FirebaseService.deleteData(
              context: context,
              collection: "Types",
              docId: id
          );
          if (x == true) {
            Common.showNotification(
                context: context,
                title: "Data Deleted",
                content: "$category Record Successfully Deleted",
                messageType: MessageType.success
            );
            getTypes();
            notifyListeners();
          }
        }
    );
  }

  clearData()
  {
    _category = "Expense";
    titleController.clear();
    _isFirstSelected = true;
    _id="";
    update = false;
    notifyListeners();
  }

  loadData(TransactionType t){
    titleController.text = t.title.toString();
    _category = t.category.toString();
    update = true;
    if(t.category.toString() == "Expense"){
      setIsFirstSelected(true);
    }else
      {
        setIsFirstSelected(false);
      }
    notifyListeners();
  }

}