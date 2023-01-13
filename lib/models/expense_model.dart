
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String? id;
  final String? type;
  final String? title;
  final double? amount;
  final DateTime? date;
  final String? description;
  final String? imageUrl;
  final String category;


  Transaction({required this.category, this.id, this.type, this.title, this.amount, this.date, this.description, this.imageUrl});
  factory Transaction.fromSnapshot(DocumentSnapshot snapshot){
    return Transaction(
      id: snapshot.id,
      type: snapshot.get("type"),
      category: snapshot.get("category"),
      title: snapshot.get("title"),
      amount: snapshot.get("amount"),
      date: DateTime.parse(snapshot.get("date")),
      description: snapshot.get("description"),
      imageUrl: snapshot.get("imageUrl"),
    );
  }

  Map<String, dynamic> toSnapshot(){

    Map<String, dynamic> data = {

      "type" : type,
      "category" : category,
      "title" :title,
      "amount": amount,
      "date" : DateFormat("yyyy-MM-dd").format(date!),
      "description" : description,
      "imageUrl" : imageUrl,

    };
    return data;
  }

}