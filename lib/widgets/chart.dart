

import 'package:money_manager/utils/colors.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

import 'indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartTransaction extends StatefulWidget {
  const PieChartTransaction({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {

  int touchedIndex = -1;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var exp = context.watch<TransactionViewModel>();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(exp),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: exp.isFirstSelected ?  exp.chartDataExpenses.map((e) {
              x ++;
              return Column(
                children: [
                  Indicator(
                      color: colors[x % exp.chartDataExpenses.length],
                      text: e.title.toString(),
                      isSquare: true
                  ),
                  const SizedBox(height: 5,),
                ],
              );
            }).toList():
            exp.chartDataIncome.map((e) {
              x ++;
              return Column(
                children: [
                  Indicator(
                      color: colors[x % exp.chartDataIncome.length],
                      text: e.title.toString(),
                      isSquare: true
                  ),
                  const SizedBox(height: 5,),
                ],
              );
            }).toList()
            ,
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
  int x = -1;
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.purple, Colors.orange];
  List<PieChartSectionData> showingSections(TransactionViewModel exp) {

    if(exp.isFirstSelected)
      {
        return exp.chartDataExpenses.map((e) {
          x++;
          final isTouched = exp.chartDataExpenses.indexOf(e) == touchedIndex;
          final fontSize = isTouched ? 12.0 : 9.0;
          final radius = isTouched ? 70.0 : 50.0;
          return PieChartSectionData(
            color: colors[x % exp.chartDataExpenses.length],
            value: e.amount,
            title: isTouched ? e.amount.toString() : "${((e.amount / exp.totalExpenses) * 100).toStringAsFixed(2)} %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        }).toList();
      }
    else
      {
        return exp.chartDataIncome.map((e) {
          x++;
          final isTouched = exp.chartDataIncome.indexOf(e) == touchedIndex;
          final fontSize = isTouched ? 12.0 : 9.0;
          final radius = isTouched ? 70.0 : 50.0;
          return PieChartSectionData(
            color: colors[x % exp.chartDataIncome.length],
            value: e.amount,
            title: isTouched ? e.amount.toString() : "${((e.amount / exp.totalIncome) * 100).toStringAsFixed(2)} %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        }).toList();
      }
  }
}