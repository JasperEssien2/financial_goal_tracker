import 'dart:math';

import 'package:financial_goal_tracker/data/dart_export.dart';
import 'package:financial_goal_tracker/presentation/datacontroller_provider.dart';
import 'package:financial_goal_tracker/presentation/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TargetAmountCard extends StatelessWidget {
  const TargetAmountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      childBuilder: (response) {
        final double target = response.target;
        final double completionPercentage = response.completePercentage;

        final bool isBelow = completionPercentage <= 50;
        final Color color = (isBelow ? Colors.red : Colors.greenAccent);
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Target", style: captionTextStyle),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  text: "\$",
                  style: textStyle,
                  children: [
                    TextSpan(
                      text: "$target",
                      style: textStyle.copyWith(fontSize: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isBelow
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      size: 10,
                      color: color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      completionPercentage.toStringAsFixed(2),
                      style: TextStyle(color: color),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class TargetPieChart extends StatelessWidget {
  const TargetPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return CardWidget(
      childBuilder: (response) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Progress", style: captionTextStyle),
            const SizedBox(height: 12),
            Flexible(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      centerSpaceColor: AppColor.primaryContainer,
                      sections: [
                        PieChartSectionData(
                          value: _completionPercentage(response),
                          radius: 50,
                          color: colorScheme.primary,
                          titleStyle: labelTextStyle,
                          title:
                              "${response.completePercentage.toStringAsFixed(2)}%",
                        ),
                        PieChartSectionData(
                          value: _remainderPercentage(response),
                          showTitle: false,
                          color: colorScheme.secondary,
                          titleStyle: labelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _completionPercentage(EntryResponse entryResponse) {
    return ((entryResponse.totalCredit - entryResponse.totalDebit) /
        entryResponse.target);
  }

  double _remainderPercentage(EntryResponse entryResponse) {
    return ((entryResponse.target - entryResponse.totalCredit) /
        entryResponse.target);
  }
}

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
      color: Color(0xff677676),
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    final colorScheme = Theme.of(context).colorScheme;

    return CardWidget(
      childBuilder: (response) {
        final chartData = response.chartData;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Monthly Stats", style: captionTextStyle),
            const SizedBox(height: 12),
            Flexible(
              child: chartData.isEmpty
                  ? const Center(
                      child: Text("No data to show"),
                    )
                  : BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (val, meta) {
                                return Text(
                                  chartData[val.toInt()].date,
                                  style: labelTextStyle,
                                );
                              },
                            ),
                          ),
                        ),
                        maxY: max(
                          chartData
                              .map((e) => e.barChartValue.credit)
                              .reduce(max),
                          chartData
                              .map((e) => e.barChartValue.debit)
                              .reduce(max),
                        ),
                        gridData: FlGridData(
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        barGroups: chartData
                            .map(
                              (e) => BarChartGroupData(
                                x: chartData.indexOf(e),
                                barRods: [
                                  BarChartRodData(
                                    toY: e.barChartValue.credit,
                                    color: colorScheme.primary,
                                  ),
                                  BarChartRodData(
                                    toY: e.barChartValue.debit,
                                    color: colorScheme.secondary,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.childBuilder,
  });

  final Widget Function(EntryResponse response) childBuilder;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: context.entryDataController,
        builder: (context, _) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              height: height * 0.25,
              child: context.entryDataController.isLoading ||
                      context.entryDataController.data == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : childBuilder(context.entryDataController.data!),
            ),
          );
        });
  }
}

const captionTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const textStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
