import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/views/views.dart';
import '/utils/utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  openScreen()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => _user == null ? const LoginView() : const DashboardScreen()));
  }

  startTimer() async
  {
    Future.delayed(const Duration(seconds: 3), openScreen);
  }

  @override
  void initState() {
    _user = _auth.currentUser;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          decoration:   BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyAppColors.secondaryColor,
                MyAppColors.primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(height: 20,),
              const Text("Money Manager", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,),),
              const SizedBox(height: 8,),
               SizedBox(
                width: size.width * 0.40,
                  child: const  LinearProgressIndicator()
              )
            ],
          ),
        ),
    );
  }
}
