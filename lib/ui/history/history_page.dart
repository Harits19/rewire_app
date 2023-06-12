import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rewire_app/ui/home/home_notifier.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runSpacing: 4,
            children: [
              ...ref.watch(homeNotifier).relapseHistory.value.map(
                    (e) => Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            _Detail(
                              title: 'Start',
                              value: DateFormat('EEEE, dd MMMM yyyy')
                                  .add_jms()
                                  .format(e.start),
                            ),
                            _Detail(
                              title: 'End',
                              value: DateFormat('EEEE, dd MMMM yyyy')
                                  .add_jms()
                                  .format(e.end),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Text(
          ' : $value',
        ),
      ],
    );
  }
}
