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
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(homeNotifier.notifier).reset();
      }),
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
            _StreakDetail(
              title: 'Streak Sekarang : ',
              duration: ref.watch(homeNotifier).streak,
            ),
            const SizedBox(
              height: 8,
            ),
            _StreakDetail(
              title: 'Streak Terlama : ',
              duration: ref.watch(homeNotifier).longestStreak,
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
    required this.duration,
  });

  final String title;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final day = duration.inDays;
    final hour = duration.inHours % 24;
    final minute = duration.inMinutes % 60;
    final second = duration.inSeconds % 60;

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
              '${day}h ${hour}j ${minute}m ${second}d',
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
