// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài tập Drawer Flutter')),
      drawer: const AppDrawer(), // Gọi Drawer đã tách file ở đây
      body: const Center(
        child: Text(
          'Tap dấu 3 gạch để Chọn bài tập.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}