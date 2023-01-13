import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';
import 'package:money_manager/viewModels/login_viewModel.dart';
import 'package:money_manager/views/change_password_view.dart';
import 'package:money_manager/widgets/circle_button.dart';
import 'package:money_manager/widgets/input_field.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Consumer<LoginViewModel>(
            builder: (_, viewModel, __) {
              return Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    Image.asset("assets/images/login.png"),
                    const SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Login Here", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 20,),
                    InputField(
                      controller: viewModel.emailController,
                      hintText: "Enter Email Here",
                      labelText: "Email",
                      leading: const Icon(Icons.alternate_email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val)
                      {
                        if(val == "")
                        {
                          return "Please Enter Email";
                        }
                        else if(!val!.contains("@") || !val.contains("."))
                          {
                            return "Invalid Email";
                          }
                        return null;
                      },
                    ),
                    InputField(
                      controller: viewModel.passwordController,
                      hintText: "Enter Password Here",
                      labelText: "Password",
                      leading: const Icon(Icons.lock),
                      keyboardType: TextInputType.text,
                      isPassword: viewModel.showPassword,
                      trailing: CircleButton(
                        onTap: (){
                          viewModel.setShowPassword(viewModel.showPassword);
                        },
                        icon: Icon(viewModel.showPassword ?  Icons.visibility : Icons.visibility_off, color: MyAppColors.primaryColor,),
                      ),
                      validator: (val)
                      {
                        if(val!.isEmpty)
                        {
                          return "Please Enter Password";
                        }
                        else if(val.length < 6)
                        {
                          return "Password should be at least 6 length";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordView()));
                          },
                          child: const Text("Forget Password?")
                      ),
                    ),
                    const SizedBox(height: 12,),
                    viewModel.loading == true ? const Center(child: CircularProgressIndicator(),) :
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: ElevatedButton(
                        onPressed: (){
                          viewModel.login(context);

                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
