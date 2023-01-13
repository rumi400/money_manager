
import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/viewModels.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class AddExpenseView extends StatelessWidget {
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TransactionViewModel>();
    var typeVM = context.watch<TypeViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
        height: MediaQuery.of(context).size.height ,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(
                centerTitle: true,
                title: Text("Add ${vm.category}"),
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
                      icon: Icon(
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
                      children: [
                        SwitchButton(
                          isFirstSelected: vm.isFirstSelected,
                          onSelected: (val)
                          {
                            print(val);
                            if(val == true)
                            {
                              vm.setCategory("Expense");
                              typeVM.getTypes(cat: "Expense");
                            }
                            else
                            {
                              vm.setCategory("Income");
                              typeVM.getTypes(cat: "Income");
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        ExpansionTileWidget(
                          leading: const Icon(Icons.category),
                          title: vm.type,
                          items: typeVM.types.map((e) => e.title.toString()).toList(),
                          callBack: (val)
                          {
                            vm.setType(val);
                          },
                        ),
                        TextFieldWidget(
                          leading: const Icon(Icons.account_balance_wallet),
                          controller: vm.titleController,
                          hintText: "Enter ${vm.category} Name Here",
                          labelText: '${vm.category} Name',
                        ),
                        TextFieldWidget(
                          leading: const Icon(Icons.monetization_on),
                          controller: vm.amountController,
                          hintText: "Enter ${vm.category} Amount Here",
                          labelText: '${vm.category} Amount',
                          keyboardType: TextInputType.number,
                        ),
                        TextFieldWidget(
                          leading: const Icon(Icons.calendar_month),
                          controller: vm.dateController,
                          hintText: "Select ${vm.category} Date",
                          labelText: '${vm.category} Date',
                          keyboardType: TextInputType.number,
                          readonly: true,
                          onTap: ()
                          {
                            vm.setSelectedDate(context);
                          },
                        ),
                        TextFieldWidget(
                          leading: const Icon(Icons.description),
                          controller: vm.descController,
                          hintText: "Enter ${vm.category} Description Here",
                          labelText: '${vm.category} Description',
                        ),
                        ImageSelector(
                          onSelectImage: (image)
                          {
                            vm.setImage(image);
                          },
                        ),
                        const SizedBox(height: 10,),
                        vm.image == null ? const SizedBox.shrink() :
                        SizedBox(
                            width: 200,
                            height : 100,
                            child: Image.file(vm.image!)
                        ),
                        const SizedBox(height: 10,),
                        vm.uploading ? const Center(child: CircularProgressIndicator(),):
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: (){
                              if(vm.update)
                              {
                                vm.updateExpense(context);
                              }
                              else
                              {
                                vm.saveExpense(context);
                              }
                            },
                            child:  Text( vm.update ? "Update ${vm.category}" : "Save ${vm.category}"),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      )
    );
  }
}
