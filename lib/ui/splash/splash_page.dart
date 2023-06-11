import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/services/shared_pref_service.dart';
import 'package:rewire_app/ui/bottom_navigation/bottom_navigation_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetUtil.checkWidget(() async {
      await ref.read(sharedPrefService).init();
      context.popAll(const BottomNavigationPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SplashPage'),
      ),
    );
  }
}
