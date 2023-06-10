import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rand = Random();
    final dummyValue = List.generate(4, (index) {
      return Offset(index.toDouble(), rand.nextInt(6).toDouble());
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: BarChart(
            BarChartData(
              barGroups: [
                ...dummyValue.map(
                  (e) => BarChartGroupData(
                    x: e.dx.toInt(),
                    barRods: [
                      BarChartRodData(
                        toY: e.dy,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
