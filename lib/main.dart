import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/dashboard_viewModel.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:money_manager/viewModels/login_viewModel.dart';
import 'package:money_manager/viewModels/type_viewModel.dart';
import 'package:provider/provider.dart';
import '/views/views.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => TypeViewModel()),

      ],
      child: MaterialApp(
        title: 'Money Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.teal,
        ),
        home:  const SplashView()
      ),
    );
  }
}
