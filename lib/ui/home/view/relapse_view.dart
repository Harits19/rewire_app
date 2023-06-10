import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewire_app/ui/home/home_notifier.dart';

class RelapseView extends ConsumerStatefulWidget {
  const RelapseView({super.key});

  static dialog(
    BuildContext context, {
    required RelapseView child,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return child;
      },
    );
  }

  @override
  ConsumerState<RelapseView> createState() => _RelapseViewState();
}

class _RelapseViewState extends ConsumerState<RelapseView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Tetapkan waktu relapse'),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: ListTile(
                    title: const Text('05:40 PM'),
                    onTap: () {},
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text('on'),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text('10 JUN, SAB'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            child: const Text('Relapse'),
            onPressed: () {
              ref.read(homeNotifier.notifier).saveRelapseHistory();
            },
          )
        ],
      ),
    );
  }
}
