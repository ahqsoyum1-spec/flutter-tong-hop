import 'package:flutter/material.dart';
import 'dart:async';

class mycountdown extends StatefulWidget {
  const mycountdown({super.key});

  @override
  State<mycountdown> createState() => _MyCountdownState();
}

class _MyCountdownState extends State<mycountdown> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;

  int _initialSeconds = 0;
  int _currentSeconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    final input = int.tryParse(_controller.text);
    if (input == null || input <= 0) {
      _showToast('Vui lòng nhập một số giây hợp lệ.');
      return;
    }

    setState(() {
      _initialSeconds = input;
      _currentSeconds = input;
      _isRunning = true;
      _isPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
        });
        _showToast('Đã hết giờ!');
      }
    });
  }

  void _pauseTimer() {
    if (_isRunning && !_isPaused) {
      _timer?.cancel();
      setState(() {
        _isPaused = true;
      });
    }
  }

  void _resumeTimer() {
    if (_isRunning && _isPaused) {
      setState(() {
        _isPaused = false;
      });
      _startTimer();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _initialSeconds = 0;
      _currentSeconds = 0;
      _isRunning = false;
      _isPaused = false;
      _controller.clear();
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String get _timeFormatted {
    final minutes = (_currentSeconds % 3600) ~/ 60;
    final seconds = _currentSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _initialSeconds > 0 ? _currentSeconds / _initialSeconds : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 4: Hẹn giờ đếm ngược'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Display
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1 - progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isRunning ? Colors.blue : Colors.grey,
                    ),
                  ),
                  Center(
                    child: Text(
                      _timeFormatted,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: _isRunning ? Colors.blue.shade700 : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Input field
            if (!_isRunning)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Nhập số giây",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning)
                  FloatingActionButton.extended(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Bắt đầu"),
                  ),
                if (_isRunning && !_isPaused)
                  FloatingActionButton.extended(
                    onPressed: _pauseTimer,
                    backgroundColor: Colors.orange,
                    icon: const Icon(Icons.pause),
                    label: const Text("Tạm dừng"),
                  ),
                if (_isRunning && _isPaused)
                  FloatingActionButton.extended(
                    onPressed: _resumeTimer,
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Tiếp tục"),
                  ),
                const SizedBox(width: 20),
                if (_isRunning)
                  FloatingActionButton(
                    onPressed: _resetTimer,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.stop),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
