import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/widgets/app_drawer.dart';

class mycount extends StatefulWidget {
  const mycount({super.key});

  @override
  State<mycount> createState() => _MyCounterAppState();
}

class _MyCounterAppState extends State<mycount> {
  int counter = 0;             
  Color numberColor = Colors.black;

  void _increase() {
    setState(() {
      counter++;
      numberColor = Colors.green; 
    });
  }

  void _decrease() {
    setState(() {
      counter--;
      numberColor = Colors.red; 
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
      numberColor = Colors.black; 
    });
  }


  Widget myBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Giá trị hiện tại",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                "$counter",
                key: ValueKey<int>(counter),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrease Button
              FloatingActionButton.extended(
                onPressed: _decrease,
                backgroundColor: Colors.redAccent,
                icon: const Icon(Icons.remove),
                label: const Text("Giảm"),
              ),
              const SizedBox(width: 20),

              // Reset Button
              IconButton(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                iconSize: 32,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 20),

              // Increase Button
              FloatingActionButton.extended(
                onPressed: _increase,
                backgroundColor: Colors.green,
                icon: const Icon(Icons.add),
                label: const Text("Tăng"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 3: Đếm số'),
        backgroundColor: Colors.blue[100],
      ),
      // QUAN TRỌNG: Gọi lại AppDrawer ở đây
      drawer: const AppDrawer(), 
      body: myBody(),
    );
  }
}
