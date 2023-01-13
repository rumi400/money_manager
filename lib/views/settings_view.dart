import 'package:flutter/material.dart';
import 'package:money_manager/services/firebase_service.dart';
import 'package:money_manager/utils/common.dart';
import 'package:money_manager/views/add_type_view.dart';
import 'package:money_manager/views/change_password_view.dart';
import 'package:money_manager/views/splash_view.dart';
import 'package:money_manager/views/views.dart';
import 'package:money_manager/widgets/myAppbar.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../viewModels/type_viewModel.dart';
import '../widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child:  Stack(
              children: [
                MyAppBar(
                  centerTitle: true,
                  title:const Text("Settings"),

                  leading:  IconButton(
                      splashRadius: 20,
                      onPressed: (){

                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                        color: MyAppColors.secondaryColor2,
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          ListTile(

                            contentPadding: const EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                            leading: const Icon(Icons.category_outlined),
                            title: const Text("Type Management"),
                            onTap: (){
                              var vm = context.read<TypeViewModel>();
                              vm.getTypes();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTypeView()));
                            },
                          ),
                          ListTile(

                            contentPadding: const EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                            leading: const Icon(Icons.manage_accounts),
                            title: const Text("Account"),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordView()));
                            },
                          ),
                          ListTile(

                            contentPadding: const EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                            leading: const Icon(Icons.info_outline_rounded),
                            title: const Text("About Us"),
                            onTap: (){
                              aboutDialog(context: context,);
                            },
                          ),
                          ListTile(

                            contentPadding: const EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                            leading: const Icon(Icons.logout),
                            title: const Text("Sign Out"),
                            onTap: () async{
                              var x = await  FirebaseService.signOut();
                              if(x == true){

                                Common.signOutDialog(context: context,
                                    onPressed: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));

                                    }
                                    );
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

 aboutDialog({required BuildContext context,}) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(12),
          title:  CircleAvatar(
            radius: 40,
            child: Image.asset("assets/images/logo.png",width: 50,height: 50,),
          ),
          content: SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("About Us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text("This app is an expense or income manager app, which manges your daily base expenses records. You can add any type of your record regarding to your monthly expenditure",style: TextStyle(fontSize: 14,),),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Close")),
          ],
        );
      });
}
