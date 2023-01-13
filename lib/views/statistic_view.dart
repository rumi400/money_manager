import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/widgets.dart';
import 'views.dart';

class StatisticView extends StatelessWidget {
  const StatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TransactionViewModel>();
    vm.getExpenses();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar2(
              centerTitle: true,
              leading: IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Statistics",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Consumer<TransactionViewModel>(builder: (_, vm, __) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: SwitchButton(
                  onSelected: (val) {
                    vm.setIsFirstSelected(val);
                    if (val == true) {
                      vm.setCategory("Expense");
                    } else {
                      vm.setCategory("Income");
                    }
                  },
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     style: ButtonStyle(
                  //         shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8)))),
                  //     child: const Text(" Day ")),
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     style: ButtonStyle(
                  //         shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8)))),
                  //     child: const Text("Week")),
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     style: ButtonStyle(
                  //         shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8)))),
                  //     child: const Text("Month")),
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     style: ButtonStyle(
                  //         shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8)))),
                  //     child: const Text("Year")),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.44,
                    child: TextFieldWidget(
                      controller: vm.startDateController,
                      hintText: "Start Date",
                      leading: const Icon(Icons.calendar_month),
                      keyboardType: TextInputType.number,
                      readonly: true,
                      onTap: () {
                        vm.setSelectedStartDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.44,
                    child: TextFieldWidget(
                      controller: vm.endDateController,
                      hintText: "End Date",
                      leading: const Icon(Icons.calendar_month),
                      keyboardType: TextInputType.number,
                      readonly: true,
                      onTap: () {
                        vm.setSelectedEndDate(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const PieChartTransaction(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Top Records",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            vm.chartDataExpenses.isEmpty && vm.chartDataIncome.isEmpty
                ? const Center(
                    child: Text("No Transaction Found"),
                  )
                : ListView.builder(
                    itemCount: vm.isFirstSelected
                        ? vm.chartDataExpenses.length
                        : vm.chartDataIncome.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = vm.isFirstSelected
                          ? vm.chartDataExpenses
                          : vm.chartDataIncome;
                      Widget leading = CircleAvatar(
                          backgroundColor:
                              vm.isFirstSelected ? Colors.red : Colors.green,
                          child: Icon(
                            vm.isFirstSelected
                                ? Icons.account_balance_wallet
                                : Icons.monetization_on,
                            color: Colors.white,
                          ));
                      Widget text = vm.isFirstSelected
                          ? const Text(
                              "- ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              "+ ",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            );
                      return ListTile(
                        leading: leading,
                        title: Text(data[index].title.toString()),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Rs. ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              text,
                              Text(
                                data[index].amount.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          vm.loadData(vm.transactions[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddExpenseView()));
                        },
                        onLongPress: () {
                          vm.deleteExpense(
                              context, vm.transactions[index].id.toString());
                        },
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
