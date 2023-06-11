import 'dart:math';

extension DurationExtension on Duration {
  String toCompactText() {
    final day = inDays;
    final hour = inHours % 24;
    final minute = inMinutes % 60;
    final second = inSeconds % 60;
    return '${day}h ${hour}j ${minute}m ${second}d';
  }
}

extension ListDurationExtension on List<Duration> {
  Duration biggest() {
    return Duration(seconds: this.map((e) => e.inSeconds).reduce(max));
  }
}
