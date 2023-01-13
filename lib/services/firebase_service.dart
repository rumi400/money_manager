
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_manager/utils/common.dart';

class FirebaseService
{

  static final  FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<User?> signInWithEmailAndPassword({required email, required password}) async
  {
    try
        {
          UserCredential? uc = await _auth.signInWithEmailAndPassword(email: email, password: password);
          if(uc.user != null)
            {
              return uc.user;
            }
          else
            {
              return null;
            }
        }
        on FirebaseAuthException  catch(e){
        if(e.code == "user-disabled")
          {
            //todo: show snack bar
          }
        else if(e.code == "wrong-password")
          {
            //todo: show snack bar
          }
        else if(e.code == "invalid-email")
          {
            //todo: show snack bar
          }
        else if(e.code == "user-not-found")
          {
            return signUpWithEmailAndPassword(email: email, password: password);
          }
        return null;
        }
  }

  static Future<bool> signOut() async {
    await _auth.signOut();
    return true;
  }

  static Future<User?> signUpWithEmailAndPassword({required email, required password}) async
  {
    try
        {
          UserCredential? uc = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          if(uc.user != null)
          {
            return uc.user;
          }
          else
          {
            return null;
          }
        }
    on FirebaseAuthException catch(e)
    {
      if(e.code == "email-already-in-use")
        {
          return signInWithEmailAndPassword(email: email, password: password);
        }
      else if(e.code == "invalid-email")
        {
          //todo: show snack bar
        }
      else if(e.code == 'weak-password')
        {
          //todo: show snack bar
        }
      else if(e.code == "operation-not-allowed")
        {

        }
      return null;
    }
  }

  static Future<bool> addData({required BuildContext context,required String collection, required Map<String,dynamic> doc}) async {
    try{
      await FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").add(doc);
     return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }

  static Future<bool> setData({required BuildContext context,required String collection, required Map<String,dynamic> doc, required String docId}) async {
    try{
      await FirebaseFirestore.instance.collection(collection).doc(docId).set(doc);
      return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }

  static Future<bool> updateData({required BuildContext context,required String collection, required Map<String,dynamic> doc, required String docId}) async {
    try{
      await FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").doc(docId).update(doc);
      return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }

  static Future<bool> addUserData({required BuildContext context, required String collection, required Map<String,dynamic> doc, required String docId}) async{
    try{
      await FirebaseFirestore.instance.collection(collection).add(doc);
      return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }
  static Future<bool> updateUserData({required BuildContext context,required String collection, required Map<String,dynamic> doc, required String docId}) async {
    try{
      await FirebaseFirestore.instance.collection(collection).doc(docId).update(doc);
      return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }

  static Future<bool> deleteData({required BuildContext context,required String collection, required String docId}) async {
    try{
      await FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").doc(docId).delete();
      return true;
    }
    on FirebaseException catch (e){
      Common.showSnackBar(context: context, message: e.message.toString());
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots({required BuildContext context,required String collection})
  {
    return FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").snapshots();
  }

  static Future<List<QueryDocumentSnapshot>> getDocuments({required String collection, String? where, String? whereValue}) async
  {
    List<QueryDocumentSnapshot> snapshots = [];
    if(where == null && whereValue == null)
      {
        var x = await FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").get();
        snapshots = x.docs;
      }
    else
      {
        var x = await FirebaseFirestore.instance.collection("Users/${_auth.currentUser?.email}/$collection").where(where.toString(), isEqualTo: whereValue).get();
        snapshots = x.docs;
      }
    return snapshots;
  }

  static Future<String?> uploadFile({required BuildContext context, required File file}) async
  {
    if(file.existsSync() == false){
      return null;
    }
    String imageUrl = "";
    String fileName = path.basename(file.path);
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = reference.putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => print("File Uploaded"));
    print(snapshot.state);
    if(snapshot.state == TaskState.success){
      await reference.getDownloadURL().then((value) => imageUrl = value);
    }
   return imageUrl;
  }

  static Future<bool> checkExist({required BuildContext context,required String collection, String? where, String? whereValue})async{
    bool exist = false;
    var docs = await getDocuments(collection: collection, where: where, whereValue: whereValue);
    if(docs.isEmpty){
      exist = false;
    }else{
      exist = true;
    }
    return exist;
  }

  static Future<QueryDocumentSnapshot<Object?>?> getOneDoc({required BuildContext context,required String collection, String? where, String? whereValue}) async
  {
    var x = await FirebaseFirestore.instance.collection(collection).where(where.toString(), isEqualTo: whereValue).get();
    var docs = x.docs;
    print(docs.length);
    if(docs.isNotEmpty) {
      return docs.first;
    }
  }
}