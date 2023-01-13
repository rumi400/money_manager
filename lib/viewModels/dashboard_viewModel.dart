import 'package:flutter/material.dart';

import '../views/views.dart';

class DashboardViewModel extends ChangeNotifier
{
  final pages = [
    const HomeView(),
    const TransactionView(),
    const HomeView(),
    const WalletView(),
    const SettingsView(),
  ];
  int _index = 0;
   int get index => _index;
   setIndex(int val) {
     _index = val;
     notifyListeners();
   }
}