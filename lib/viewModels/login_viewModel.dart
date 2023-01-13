import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/models.dart';
import 'package:money_manager/services/services.dart';
import 'package:money_manager/utils/common.dart';
import 'package:money_manager/views/dashboard_view.dart';

class LoginViewModel extends ChangeNotifier
{
  final newUserNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  final passwordController3 = TextEditingController();
  bool _showPassword = false;
  bool _showPassword2 = false;
  bool check = false;
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  Person? person;

  bool get showPassword => _showPassword;
  bool get showPassword2 => _showPassword2;
  setShowPassword(bool val)
  {
    _showPassword = !val;
    notifyListeners();
  }

  setShowPassword2(bool v)
  {
    _showPassword2 = !v;
    notifyListeners();
  }
  login(BuildContext context) async
  {
    if(_formKey.currentState!.validate())
      {
        loading = true;
        notifyListeners();
        var user = await FirebaseService.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        if(user != null)
          {

            loading = false;
            var exist = await FirebaseService.checkExist(context: context, collection: "Users",where: "email",whereValue: emailController.text.trim());
            if(exist == false){
              person = Person(
                name: "guest",
                email: emailController.text.trim(),
                password: passwordController.text.trim(),

              );
              var x = await FirebaseService.setData(context: context, collection: "Users", doc: person!.toSnapshot(), docId: emailController.text.trim());
            }
            emailController.clear();
            passwordController.clear();
            notifyListeners();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
          }
      }
  }
  clearData(){
    newUserNameController.clear();
    passwordController2.clear();
    passwordController3.clear();
    notifyListeners();
  }

  getUserData(BuildContext context) async{
   var auth = FirebaseAuth.instance;
    var email = auth.currentUser?.email.toString();
    if(email != null){
      var doc = await FirebaseService.getOneDoc(context: context, collection: "Users",where: 'email',whereValue: email);

      if(doc != null)
        {
          person = Person.fromSnapshot(doc);
        }
      notifyListeners();
    }
  }

  bool validatePass(BuildContext context){
    check = true;
    if(newUserNameController.text.trim().isEmpty){
      Common.showNotification(
          context: context,
          title: "Data Required",
          content: "Please Enter User-Name",
          messageType: MessageType.error
      );
      check = false;
    }else if(passwordController2.text.isEmpty){
      Common.showNotification(
          context: context,
          title: "Data Required",
          content: "Please Enter Password",
          messageType: MessageType.error
      );
      check = false;
    }
    else if(passwordController3.text.isEmpty){
      Common.showNotification(
          context: context,
          title: "Data Required",
          content: "Please Confirm Password",
          messageType: MessageType.error
      );
      check = false;
    }else if(passwordController3.text.trim() != passwordController2.text.trim()) {
      Common.showNotification(
          context: context,
          title: "Password not Matched",
          content: "Please Match the confirm Password with the new Password",
          messageType: MessageType.error
      );
      check = false;
    }
    return check;
  }


  updatePassword(BuildContext context,String id) async {
    if(validatePass(context)){
      person = Person(
        name: newUserNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController2.text.trim(),
      );
      var x = await FirebaseService.updateUserData(
          context: context,
          collection: "Users",
          doc: person!.toSnapshot(),
          docId: id);

      print(id);
      print(person!.toSnapshot());

      FirebaseAuth.instance.currentUser?.updatePassword(passwordController2.text.trim());

      if(x== true){
        Common.showNotification(
            context: context,
            title: "Data Updated",
            content: "UserName And Password is Updated",
            messageType: MessageType.success);

      }
    }

  }
}