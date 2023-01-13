import 'package:flutter/material.dart';
import 'package:money_manager/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../viewModels/transaction_viewModel.dart';
import '../views/views.dart';

class WalletCard extends StatelessWidget {
  final double? width;
  final double? height;
  const WalletCard({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TransactionViewModel>();
    return Container(
      width:width ?? MediaQuery.of(context).size.width * 0.90,
      height: height ?? MediaQuery.of(context).size.height *0.60,
      decoration: BoxDecoration(
          color: MyAppColors.secondaryColor2,
          borderRadius: BorderRadius.circular(18)
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Text("Total Income",style: TextStyle(fontSize:15,color: MyAppColors.secondaryColor3),),
                const SizedBox(height: 10,),
                Text("Rs. ${vm.totalIncome}",style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                vm.incomes.isEmpty ? const Center(child:  Text("No Income Found"),) :
                Expanded(
                  child: ListView.builder(
                      itemCount: vm.incomes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index)
                      {
                        return ListTile(
                          leading: DateWidget(
                            date: vm.incomes[index].date!,
                          ),
                          title: Text("${vm.incomes[index].title}"),
                          subtitle: Text("${vm.incomes[index].type}"),
                          trailing: Text("${vm.incomes[index].amount}"),
                          onTap: (){
                            vm.loadData(vm.incomes[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpenseView()));
                          },
                          onLongPress: (){
                            vm.deleteExpense(context, vm.incomes[index].id!);
                          },
                        );
                      }

                  ),
                )
              ]
          )
      ),
    );
  }
}
