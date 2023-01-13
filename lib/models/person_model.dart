
import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String? id;
  final String? name;
  final String? email;
  final String? password;

  Person({this.id, this.password, this.name, this.email,});
 factory Person.fromSnapshot(DocumentSnapshot snapshot){
   return Person(
     id: snapshot.id,
     name: snapshot.get("name"),
     email: snapshot.get("email"),
     password: snapshot.get("password"),
   );
 }

 Map<String,dynamic> toSnapshot(){
   Map<String, dynamic> data = {
     "name":name,
     "email":email,
     "password": password
   };
   return data;
 }
}