import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GraphPage extends HookConsumerWidget {
  const GraphPage({super.key});

  static final List<String> days = <String>['月', '火', '水', '木', '金', '土', '日'];

  static final List<double> weeklyData = <double>[30, 45, 28, 60, 90, 55, 40];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    Widget getBottomTitle(double value, TitleMeta meta) {
      final String day = days[value.toInt()];
      return SideTitleWidget(
        meta: meta,
        child: Text(
          day,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (BarChartGroupData group, int groupIndex,
                      BarChartRodData rod, int rodIndex) =>
                  BarTooltipItem(
                '${days[group.x]}: ${rod.toY.toInt()}万円',
                (theme.textTheme.bodySmall ?? const TextStyle())
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitle,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(show: false),
          barGroups:
              weeklyData.asMap().entries.map((MapEntry<int, double> entry) {
            final int index = entry.key;
            final double value = entry.value;
            return BarChartGroupData(x: index, barRods: <BarChartRodData>[
              BarChartRodData(toY: value, width: 20, color: Colors.blueAccent),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
