import 'package:flutter/material.dart';
import 'package:init_flutter/ui/home/view/relapse_view.dart';
import 'package:init_flutter/ui/views/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '0',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 80,
                  ),
            ),
            Gap.v8,
            Text(
              'Hari',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gap.v16,
            const _StreakDetail(
              title: 'Streak Sekarang : ',
              subtitle: '0h 8j 45m 8d',
            ),
            Gap.v8,
            const _StreakDetail(
              title: 'Streak Terlama : ',
              subtitle: '0h 8j 45m 8d',
            ),
            Gap.v16,
            TextButton(
              onPressed: () {
                RelapseView.dialog(
                  context,
                  child: const RelapseView(),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text(
                'Relapse',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StreakDetail extends StatelessWidget {
  const _StreakDetail({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
