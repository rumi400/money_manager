import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/login_viewModel.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import '/widgets/widgets.dart';
import 'views.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    var loginVm = context.read<LoginViewModel>();
    var vm = context.read<TransactionViewModel>();
    vm.getExpenses();
    loginVm.getUserData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TransactionViewModel>();
    var loginVm = context.read<LoginViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  MyAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                       const Text(
                          "Good Afternoon",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "${loginVm.person?.name}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    actions: const [
                      AppBarActionButton(
                          icon: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ))
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: HomeSummaryCard(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: SwitchButton(
                isFirstSelected: vm.isFirstSelected,
                onSelected: (val) {
                  vm.setIsFirstSelected(val);
                  if (val == true) {
                    vm.setCategory("Expense");
                  } else {
                    vm.setCategory("Income");
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ElevatedButton(
                    //     onPressed: () {
                    //       vm.dateFilter(DateFilter.daily);
                    //     },
                    //     style: ButtonStyle(
                    //         shape: MaterialStatePropertyAll(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(8)))),
                    //     child: const Text(" Day ")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //
                    //       vm.dateFilter(DateFilter.weekly);
                    //     },
                    //     style: ButtonStyle(
                    //         shape: MaterialStatePropertyAll(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(8)))),
                    //     child: const Text("Week")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       vm.dateFilter(DateFilter.monthly);
                    //     },
                    //     style: ButtonStyle(
                    //         shape: MaterialStatePropertyAll(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(8)))),
                    //     child: const Text("Month")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       vm.dateFilter(DateFilter.yearly);
                    //     },
                    //     style: ButtonStyle(
                    //         shape: MaterialStatePropertyAll(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(8)))),
                    //     child: const Text("Year")),,
                    SizedBox(
                      height: 60,
                      width:MediaQuery.of(context).size.width *0.44,
                      child: TextFieldWidget(

                        controller: vm.startDateController,
                        hintText: "Start Date",
                        leading: const Icon(Icons.calendar_month),
                        keyboardType: TextInputType.number,
                        readonly: true,
                        onTap: ()
                        {
                          vm.setSelectedStartDate(context);
                        },
                      ),
                    ),
                   const SizedBox(width: 10,),
                    SizedBox(
                      height: 60,
                      width:MediaQuery.of(context).size.width *0.44,
                      child: TextFieldWidget(

                        controller: vm.endDateController,
                        hintText: "End Date",
                        leading: const Icon(Icons.calendar_month),
                        keyboardType: TextInputType.number,
                        readonly: true,
                        onTap: ()
                        {
                          vm.setSelectedEndDate(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width * 0.85,
                child: const PieChartTransaction()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transaction History",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StatisticView()));
                      },
                      child: const Text("See All"))
                ],
              ),
            ),

            // const SizedBox(height: 10,),
            vm.chartDataExpenses.isEmpty && vm.chartDataIncome.isEmpty
                ? const Center(
                    child: Text("No Transaction Found"),
                  )
                : ListView.builder(
                    itemCount: vm.isFirstSelected ?  vm.chartDataExpenses.length : vm.chartDataIncome.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      var data = vm.isFirstSelected ?  vm.chartDataExpenses : vm.chartDataIncome;
                      Widget leading =  CircleAvatar(
                          backgroundColor:vm.isFirstSelected ? Colors.red : Colors.green,
                          child: Icon(
                            vm.isFirstSelected ? Icons.account_balance_wallet : Icons.monetization_on,
                            color: Colors.white,
                          ));
                      Widget text = vm.isFirstSelected ? const Text(
                         "- ",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ):
                      const Text(
                        "+ ",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
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
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
