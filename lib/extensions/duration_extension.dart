extension DurationExtension on Duration {
  String compactText() {
    final day = this.inDays;
    final hour = this.inHours % 24;
    final minute = this.inMinutes % 60;
    final second = this.inSeconds % 60;
    return '${day}h ${hour}j ${minute}m ${second}d';
  }


}
