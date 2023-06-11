import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rewire_app/extensions/datetime_extension.dart';
import 'package:rewire_app/extensions/duration_extension.dart';
import 'package:rewire_app/ui/home/home_notifier.dart';

// TODO make own flowchart

class StatisticPage extends ConsumerStatefulWidget {
  const StatisticPage({super.key});

  @override
  ConsumerState<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends ConsumerState<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    final relapseHistory = ref.watch(homeNotifier).relapseHistory.value;
    final dateRange = relapseHistory.toDateRange();
    final isSmallData = relapseHistory.length > 5;
    // print(dateRange);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24.0).add(const EdgeInsets.only(top: 40)),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: isSmallData
                ? context.mSize.width / 5 * relapseHistory.length
                : context.mSize.width,
            child: BarChart(
              BarChartData(
                maxY: dateRange
                            .map((e) => e.duration)
                            .toList()
                            .biggest()
                            .inSeconds <=
                        Duration.secondsPerDay
                    ? Duration.secondsPerDay.toDouble()
                    : null,
                gridData: FlGridData(
                  show: false,
                ),
                borderData: FlBorderData(
                  border: const Border(
                    bottom: BorderSide(),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Theme.of(context).cardColor,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        dateRange[groupIndex].duration.toCompactText(),
                        const TextStyle(),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 48,
                      getTitlesWidget: (value, meta) {
                        final item = dateRange[value.toInt()];
                        String format(DateTime date) {
                          return DateFormat('dd MMM yy').format(date);
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${format(item.start)} -\n${format(item.end)}'),
                        );
                      },
                      showTitles: true,
                    ),
                  ),
                ),
                barGroups: [
                  ...List.generate(
                    dateRange.length,
                    (index) {
                      final date = dateRange[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: date.duration.inSeconds.toDouble(),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
