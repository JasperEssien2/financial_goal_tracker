import 'package:financial_goal_tracker/presentation/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TargetAmountCard extends StatelessWidget {
  const TargetAmountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: FittedBox(
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
                    text: "500,000",
                    style: textStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.2),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.arrow_downward_rounded,
                    size: 10,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "80.75%",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class TargetPieChart extends StatelessWidget {
  const TargetPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return CardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Progress", style: captionTextStyle),
          const SizedBox(height: 12),
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  centerSpaceColor: AppColor.primaryContainer,
                  sections: [
                    PieChartSectionData(
                      value: 70,
                      radius: 50,
                      color: colorScheme.primary,
                      titleStyle: labelTextStyle,
                      title: "70%",
                    ),
                    PieChartSectionData(
                      value: 30,
                      showTitle: false,
                      color: colorScheme.secondary,
                      titleStyle: labelTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
      color: Color(0xff677676),
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    final colorScheme = Theme.of(context).colorScheme;

    return CardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Monthly Stats", style: captionTextStyle),
          const SizedBox(height: 12),
          Flexible(
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        return Text(
                          meta.formattedValue,
                          style: labelTextStyle,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        return Text(
                          meta.formattedValue,
                          style: labelTextStyle,
                        );
                      },
                    ),
                  ),
                ),
                maxY: 40,
                gridData: FlGridData(
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: 20, color: colorScheme.primary),
                    BarChartRodData(toY: 40, color: colorScheme.secondary),
                  ]),
                  BarChartGroupData(
                    x: 20,
                    barRods: [
                      BarChartRodData(toY: 20, color: colorScheme.primary),
                      BarChartRodData(toY: 40, color: colorScheme.secondary),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        height: height * 0.25,
        child: child,
      ),
    );
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
