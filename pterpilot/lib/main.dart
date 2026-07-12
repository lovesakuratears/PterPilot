import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'pages/home_scaffold.dart';
import 'providers/app_providers.dart';

void main() {
  runApp(const ProviderScope(child: PterPilotApp()));
}

class PterPilotApp extends ConsumerWidget {
  const PterPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'PterPilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: const HomeScaffold(),
    );
  }
}
