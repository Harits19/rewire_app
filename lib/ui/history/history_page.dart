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
                        title: Text(
                          DateFormat('EEEE, dd MMMM yyyy').add_jms().format(e),
                          textAlign: TextAlign.center,
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
