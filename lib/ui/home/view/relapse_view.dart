import 'package:flutter/material.dart';

class RelapseView extends StatelessWidget {
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
