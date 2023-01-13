import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/widgets.dart';
import 'views.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90,
          child: Stack(
            children: [
              MyAppBar(
                centerTitle: true,
                title: const Text("Expense"),
                leading: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<TransactionViewModel>(builder: (_, vm, __) {
                    vm.getExpenses();
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.70,
                      decoration: BoxDecoration(
                          color: MyAppColors.secondaryColor2,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Total Expenses",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyAppColors.secondaryColor3),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rs. ${vm.totalExpenses}",
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                vm.expenses.isEmpty
                                    ? const Center(
                                        child: Text("No Expenses Found"),
                                      )
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.44,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            itemCount: vm.expenses.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: DateWidget(
                                                  date:
                                                      vm.expenses[index].date!,
                                                ),
                                                title: Text(
                                                    "${vm.expenses[index].title}"),
                                                subtitle: Text(
                                                    "${vm.expenses[index].type}"),
                                                trailing: Text(
                                                    "${vm.expenses[index].amount}"),
                                                onTap: () {
                                                  vm.loadData(
                                                      vm.expenses[index]);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddExpenseView()));
                                                },
                                              );
                                            }),
                                      )
                              ])),
                    );
                  }))
            ],
          ),
        ),
      ],
    ));
  }
}
