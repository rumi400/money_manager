import 'package:flutter/material.dart';
import 'package:money_manager/utils/colors.dart';

class SwitchButton extends StatefulWidget {

  Function(bool) onSelected;
  bool? isFirstSelected;


  SwitchButton({Key? key, required this.onSelected, this.isFirstSelected}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {

  @override
  void initState() {
    _isFirstSelected = widget.isFirstSelected ?? true;
    super.initState();
  }

  manageState()
  {
    if(widget.isFirstSelected != null)
      {
        _isFirstSelected = widget.isFirstSelected!;
      }
    setState(() {

    });
  }

  bool _isFirstSelected = true;
  @override
  Widget build(BuildContext context) {
    manageState();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isFirstSelected = true;
              });
              widget.onSelected(true);
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isFirstSelected ? MyAppColors.primaryColor :MyAppColors.secondaryColor2),
              child: Text("Expenses", style: TextStyle(color: _isFirstSelected ? MyAppColors.secondaryColor2 : MyAppColors.primaryColor),),
            ),
          ),
          InkWell(
            onTap: (){
             setState(() {
               _isFirstSelected = false;
             });
             widget.onSelected(false);
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isFirstSelected == false ? MyAppColors.primaryColor : MyAppColors.secondaryColor2),
              child: Text("Income", style: TextStyle(color: _isFirstSelected == false ? MyAppColors.secondaryColor2 : MyAppColors.primaryColor),),
            ),
          )
        ],
      ),
    );
  }
}
