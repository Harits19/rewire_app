import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewire_app/enum/bot_nav_enum.dart';
import 'package:rewire_app/models/bot_nav_model.dart';
import 'package:rewire_app/ui/bottom_navigation/bottom_navigation_notifier.dart';
import 'package:rewire_app/ui/home/home_page.dart';
import 'package:rewire_app/ui/statistic/statistic_page.dart';

class BottomNavigationPage extends ConsumerStatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationPageState();
}

class _BottomNavigationPageState extends ConsumerState<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(bottomNavigationNotifier);

    return Scaffold(
      body: selectedPage.value.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage.index,
        onTap: (index) {
          ref.watch(bottomNavigationNotifier.notifier).state =
              BotNavEnum.values[index];
        },
        items: [
          ...BotNavEnum.values.map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.value.iconData),
              label: e.value.label,
            ),
          ),
        ],
      ),
    );
  }
}

extension BotNavEnumExtension on BotNavEnum {
  BotNavModel get value {
    switch (this) {
      case BotNavEnum.home:
        return BotNavModel(
          label: 'Home',
          iconData: Icons.home,
          body: const HomePage(),
        );
      case BotNavEnum.statistic:
        return BotNavModel(
          label: 'Statistic',
          iconData: Icons.bar_chart,
          body: const StatisticPage(),
        );
      default:
        throw UnimplementedError();
    }
  }
}
