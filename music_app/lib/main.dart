import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/theme.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initShared();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignUpPage(),
      theme: AppTheme.finalDarkTheme,
    );
  }
}
