import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

class HomeSummaryCard extends StatelessWidget {

  const HomeSummaryCard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<TransactionViewModel>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 150,
      decoration: BoxDecoration(
        color: MyAppColors.darkPrimaryColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Balance",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: MyAppColors.secondaryColor2),),
                  Text("Rs. ${vm.totalExpenses + vm.totalIncome}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: MyAppColors.secondaryColor2),),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 children: [
                   Row(
                     children:  [
                       const    CircleAvatar(
                           radius: 12,
                         child: Icon(Icons.arrow_downward,size: 15,),
                       ),
                       const SizedBox(width: 5,),
                       Text("Income",style: TextStyle(color: MyAppColors.secondaryColor2),)
                     ],
                   ),
                 const SizedBox(height: 2,),
                 Text("Rs. ${vm.totalIncome}",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: MyAppColors.secondaryColor2),)
                 ],
               ),
               Column(
                 children: [
                   Row(
                     children:  [
                       const    CircleAvatar(
                         radius: 12,
                         child: Icon(Icons.arrow_upward,size: 15,),
                       ),
                       const SizedBox(width: 5,),
                       Text("Expense",style: TextStyle(color: MyAppColors.secondaryColor2),)
                     ],
                   ),
                   const SizedBox(height: 2,),
                   Text("Rs. ${vm.totalExpenses}",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: MyAppColors.secondaryColor2),)
                 ],
               ),
             ],
            ),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
