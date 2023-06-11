import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/extensions/time_of_day_extension.dart';
import 'package:rewire_app/ui/home/home_notifier.dart';
import 'package:intl/intl.dart';

class RelapseView extends ConsumerStatefulWidget {
  const RelapseView({
    super.key,
  });

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
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateTime = DateTime.now();

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
                    title: Text(
                      timeOfDay.format(context),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      final now = TimeOfDay.now();
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: timeOfDay,
                      );
                      print(now.inMinute());
                      print(selectedTime?.inMinute());
                      if (selectedTime == null) return;
                      if (selectedTime > now) {
                        SnackbarWidget.showError(
                          context,
                          'Waktu yang dipilih tidak boleh lebih dari waktu yang sekarang',
                        );
                        return;
                      }
                      timeOfDay = selectedTime;
                      setState(() {});
                    },
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
                    title: Text(
                      DateFormat('EE, dd MMM').format(dateTime),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      final now = DateTime.now();
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(now.year - 1),
                        lastDate: now,
                      );
                      if (selectedDate == null) return;
                      dateTime = selectedDate;
                      setState(() {});
                    },
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
              ref.read(homeNotifier.notifier).saveRelapseHistory(
                    dateTime.copyWith(
                      hour: timeOfDay.hour,
                      minute: timeOfDay.minute,
                      second: 0,
                    ),
                  );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
