import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewire_app/ui/home/home_notifier.dart';
import 'package:rewire_app/ui/home/view/relapse_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...ref
                .watch(homeNotifier)
                .relapseHistory
                .value
                .map((e) => Text(e.toString())),
            Text(
              '0',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 80,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Hari',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            const _StreakDetail(
              title: 'Streak Sekarang : ',
              subtitle: '0h 8j 45m 8d',
            ),
            const SizedBox(
              height: 8,
            ),
            const _StreakDetail(
              title: 'Streak Terlama : ',
              subtitle: '0h 8j 45m 8d',
            ),
            const SizedBox(
              height: 16,
            ),
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
