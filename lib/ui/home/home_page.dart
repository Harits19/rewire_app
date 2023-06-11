import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/extensions/duration_extension.dart';
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
    final hWatch = ref.watch(homeNotifier);

    ref.listen(
      homeNotifier.select((value) => value.relapseHistory),
      (previous, next) {
        if (next.isLoading) {
          LoadingWidget.dialog(context);
        } else if (previous != null && previous.isLoading) {
          WidgetUtil.safePop(context);
        }
        if (next.hasError) {
          SnackbarWidget.showError(context, next.error);
        }
      },
    );

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
              hWatch.streak.inDays.toString(),
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
              duration: hWatch.streak,
            ),
            const SizedBox(
              height: 8,
            ),
            _StreakDetail(
              title: 'Streak Terlama : ',
              duration: hWatch.longestStreak,
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
              duration.compactText(),
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
