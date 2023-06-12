import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:intl/intl.dart';
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
    final isSmallData = relapseHistory.length > 3;
    // print(dateRange);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24.0).add(const EdgeInsets.only(top: 40)),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: isSmallData
                ? context.mSize.width / 3 * relapseHistory.length
                : context.mSize.width,
            child: BarChart(
              BarChartData(
                maxY: relapseHistory
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
                        relapseHistory[groupIndex].duration.toCompactText(),
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
                      reservedSize: 96,
                      getTitlesWidget: (value, meta) {
                        final item = relapseHistory[value.toInt()];
                        String format(DateTime date) {
                          return DateFormat('dd MMM yy \n')
                              .add_jms()
                              .format(date);
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${format(item.start)}\n-\n${format(item.end)}',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      showTitles: true,
                    ),
                  ),
                ),
                barGroups: [
                  ...List.generate(
                    relapseHistory.length,
                    (index) {
                      final date = relapseHistory[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: date.duration.inSeconds.toDouble(),
                            color: index == (relapseHistory.length - 1)
                                ? Colors.red
                                : null,
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
