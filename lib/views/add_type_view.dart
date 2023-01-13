import 'package:flutter/material.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/viewModels/viewModels.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class AddTypeView extends StatefulWidget {
  const AddTypeView({Key? key}) : super(key: key);

  @override
  State<AddTypeView> createState() => _AddTypeViewState();
}

class _AddTypeViewState extends State<AddTypeView> {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TypeViewModel>();
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
                  title: const Text("Add Type"),
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
                        icon: const Icon(
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
                              if(val == true)
                              {
                                vm.setCategory("Expense");
                              }
                              else
                              {
                                vm.setCategory("Income");
                              }
                              setState(() {

                              });
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFieldWidget(
                            leading: const Icon(Icons.category),
                            controller: vm.titleController,
                            hintText: "Enter Type Name Here",
                            labelText: 'Type Name',
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: (){
                               if(vm.update == true){
                                 vm.updateType(context);
                               }
                               else{
                                 vm.saveType(context);
                               }
                              },
                              child: vm.update == true ? const Text("Update Type")  : const Text("Save Type"),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          vm.types.isEmpty ? const Center(child: Text("No Types Record Found"),):
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                border:  TableBorder(
                                  verticalInside:  BorderSide(color: MyAppColors.primaryColor),
                                  horizontalInside:  BorderSide(color: MyAppColors.primaryColor),
                                  left:  BorderSide(color: MyAppColors.primaryColor),
                                  top: BorderSide(color: MyAppColors.primaryColor),
                                  right: BorderSide(color: MyAppColors.primaryColor),
                                  bottom:  BorderSide(color: MyAppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                columns: const [
                                  DataColumn(label: Text("#")),
                                  DataColumn(label: Text("Type Name")),
                                  DataColumn(label: Text("Type Category")),
                                  DataColumn(label: Text("Edit")),
                                  DataColumn(label: Text("Delete")),
                                ],
                                rows: vm.types.map((e) {
                                  // print(_expenseController.expenses.length);
                                  return DataRow(
                                      cells: [
                                        DataCell(Text("${vm.types.indexOf(e)+1}")),
                                        DataCell(Text(e.title.toString())),
                                        DataCell(Text(e.category.toString())),
                                        DataCell(IconButton(
                                          onPressed: () async
                                          {
                                            vm.loadData(e);
                                          },
                                          splashRadius: 20,
                                          icon: const Icon(Icons.edit,color: Colors.green,),
                                        )),
                                        DataCell(IconButton(

                                          onPressed: ()async
                                          {
                                            await vm.deleteType(context, e.id.toString());
                                          },
                                          splashRadius: 20,
                                          icon: const Icon(Icons.delete,color: Colors.red,),
                                        ))

                                      ]);
                                }).toList()
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}
