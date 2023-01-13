import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../viewModels/viewModels.dart';
import '../widgets/widgets.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  loadData(BuildContext context, LoginViewModel vm){
    vm.getUserData(context);
    if(vm.person!= null)
    {
      vm.newUserNameController.text = vm.person!.name.toString();
      vm.passwordController2.text = vm.person!.password.toString();
      vm.emailController.text = vm.person!.email.toString();
      vm.passwordController3.text = vm.person!.password.toString();
    }
  }


  @override
  Widget build(BuildContext context) {
    var vm = context.read<LoginViewModel>();
    loadData(context, vm);
    return Scaffold(
      body:  SizedBox(
        height: MediaQuery.of(context).size.height * 0.80 ,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(
                centerTitle: true,
                title: const Text("Account"),
                leading:  IconButton(
                    splashRadius: 20,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)
                ),
                actions:  [
                  AppBarActionButton(
                      onTap:(){
                       vm.clearData();
                      },
                      icon: const Icon(
                        Icons.restart_alt_sharp,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Positioned(
                top:  120,
                right: 20,
                left: 20,
                bottom: 0,
                child: AddExpenseCard(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("New UserName",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyAppColors.primaryColor),),
                        const SizedBox(height: 5,),
                        InputField(
                          controller: vm.newUserNameController,
                          hintText: "Enter New UserName Here",
                          labelText: "New UserName",
                          leading: const Icon(Icons.person),
                          keyboardType: TextInputType.text,

                        ),
                        Text("New Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyAppColors.primaryColor),),
                        const SizedBox(height: 5,),
                        InputField(
                          controller: vm.passwordController2,
                          hintText: "Enter New Password Here",
                          labelText: "New Password",
                          leading: const Icon(Icons.lock),
                          keyboardType: TextInputType.text,
                          isPassword: vm.showPassword,
                          trailing: CircleButton(
                            onTap: (){
                              vm.setShowPassword(vm.showPassword);
                            },
                            icon: Icon(vm.showPassword ?  Icons.visibility : Icons.visibility_off, color: MyAppColors.primaryColor,),
                          ),
                          validator: (val)
                          {
                            if(val!.isEmpty)
                            {
                              return "Please Enter New Password";
                            }
                            else if(val.length < 8)
                            {
                              return "Password should be at least 8 length";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text("Confirm Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyAppColors.primaryColor),),
                        const SizedBox(height: 5,),
                        InputField(
                          controller: vm.passwordController3,
                          hintText: "Confirm Password ",
                          labelText: "Confirm Password",
                          leading: const Icon(Icons.lock),
                          keyboardType: TextInputType.text,
                          isPassword: vm.showPassword2,
                          trailing: CircleButton(
                            onTap: (){
                              vm.setShowPassword2(vm.showPassword2);
                            },
                            icon: Icon(vm.showPassword2 ?  Icons.visibility : Icons.visibility_off, color: MyAppColors.primaryColor,),
                          ),
                          validator: (v)
                          {
                            if(v!.isEmpty)
                            {
                              return "Please Re-Enter Password";
                            }
                            else if(v.length < 8)
                            {
                              return "Password should be at least 8 length";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: (){
                              vm.updatePassword(context, vm.person!.email.toString());
                            },
                            child: const Text("Save Changes"),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}











