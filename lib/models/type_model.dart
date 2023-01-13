
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionType
{
  final String? title;
  final String? category;
  final String? id;

  TransactionType({this.id, required this.title,required this.category,});

  factory TransactionType.fromSnapshot(DocumentSnapshot snapshot){
    return TransactionType(
      category: snapshot.get("category"),
      title: snapshot.get("title"),
      id: snapshot.id
    );
  }
  Map<String, dynamic> toSnapshot(){

    Map<String, dynamic> data = {
      "category" : category,
      "title" :title,
    };
    return data;
  }
}