import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/widgets/app_drawer.dart';

class myPlace extends StatefulWidget {
  const myPlace({super.key});

  @override
  State<myPlace> createState() => _myPlaceState();
}

class _myPlaceState extends State<myPlace> {
    Color bgcolor = Colors.white;
    String bgcolorstring = 'white';
    List<Color> lst = [
    Colors.pink, Colors.white, Colors.green, Colors.blue, Colors.red
  ];

  List<String> lststring = [
    'pink','white','green','blue','red'
  ] ;

  void _changeColor(){
    var rand = Random();
    var randnum = rand.nextInt(lst.length);
    setState(() {
      bgcolor = lst[randnum];
      bgcolorstring = lststring[randnum];
    });
  }

void _resetColor() {
    setState(() {
      bgcolor = Colors.white;
      bgcolorstring = 'white';
    });
  }

  Widget mybody() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: bgcolor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Màu hiện tại:",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: bgcolor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                bgcolorstring.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: _changeColor,
                  icon: const Icon(Icons.palette),
                  label: const Text("Thay đổi"),
                  backgroundColor: Colors.teal,
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _resetColor,
                  child: const Icon(Icons.refresh),
                  backgroundColor: Colors.grey.shade700,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 5: Change color'),
        backgroundColor: Colors.blue[100],
      ),
      // QUAN TRỌNG: Gọi lại AppDrawer ở đây
      drawer: const AppDrawer(), 
      body: mybody(),
    );
  }
}
