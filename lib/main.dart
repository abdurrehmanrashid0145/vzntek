import 'package:flutter/material.dart';
import 'coming_soon.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ComingSoonApp());
}

class ComingSoonApp extends StatelessWidget {
  const ComingSoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VznTek Coming Soon',
      theme: ThemeData.dark(), // optional
      home: const ComingSoonPage(),
    );
  }
}
