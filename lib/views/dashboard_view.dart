import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';
import 'package:money_manager/viewModels/dashboard_viewModel.dart';
import 'package:money_manager/viewModels/type_viewModel.dart';
import 'package:money_manager/views/add_expense_view.dart';

import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
   const DashboardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (_, viewModel, __) {
        return Scaffold(
            body: viewModel.pages[viewModel.index],
            bottomNavigationBar: BottomNavigationBar(

              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyAppColors.primaryColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              currentIndex: viewModel.index,
              iconSize: 30,
              onTap: (val)
              {
                viewModel.setIndex(val);
              },
              items:  const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon:Icon(Icons.account_balance_wallet_outlined), label: ''),
                BottomNavigationBarItem(icon: Text(''), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
              ],
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              var vm = context.read<TypeViewModel>();
              vm.getTypes(cat: "Expense");
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExpenseView()));
            },
            child: const Icon(Icons.add, size: 32,),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      }
    );
  }
}



