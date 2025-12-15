// exercises/exercise_12/screens/bmi_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/widgets/app_drawer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIScreen extends StatefulWidget {
  static const String routeName = '/ex12_bmi';

  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

enum Gender { male, female }



class _BMIScreenState extends State<BMIScreen> {

  Gender _selectedGender = Gender.male;

  double _height = 170;

  double _weight = 65;

  double? _bmiResult;

  String _classification = '';



  void _calculateBMI() {

    final heightInMeters = _height / 100;

    final bmi = _weight / (heightInMeters * heightInMeters);



    String classification;

    if (bmi < 18.5) {

      classification = 'Thiếu cân';

    } else if (bmi < 25) {

      classification = 'Bình thường';

    } else if (bmi < 30) {

      classification = 'Thừa cân';

    } else {

      classification = 'Béo phì';

    }



    setState(() {

      _bmiResult = bmi;

      _classification = classification;

    });

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Tính chỉ số BMI'),

        centerTitle: true,

      ),

      drawer: const AppDrawer(),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            _buildGenderSelection(),

            const SizedBox(height: 20),

            _buildHeightSlider(),

            const SizedBox(height: 20),

            _buildWeightSlider(),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: _calculateBMI,

              style: ElevatedButton.styleFrom(

                padding: const EdgeInsets.symmetric(vertical: 16),

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(12),

                ),

              ),

              child:

                  const Text('TÍNH TOÁN', style: TextStyle(fontSize: 18)),

            ),

            const SizedBox(height: 30),

            if (_bmiResult != null) _buildResultCard(),

          ],

        ),

      ),

    );

  }



  Widget _buildGenderSelection() {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(

        padding: const EdgeInsets.all(8.0),

        child: Row(

          children: [

            Expanded(

              child: _buildGenderButton(

                  context, Gender.male, "Nam", Icons.male),

            ),

            const SizedBox(width: 8),

            Expanded(

              child: _buildGenderButton(

                  context, Gender.female, "Nữ", Icons.female),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildGenderButton(

      BuildContext context, Gender gender, String label, IconData icon) {

    final isSelected = _selectedGender == gender;

    return ElevatedButton.icon(

      onPressed: () => setState(() => _selectedGender = gender),

      icon: Icon(icon, color: isSelected ? Colors.white : Theme.of(context).primaryColor),

      label: Text(label),

      style: ElevatedButton.styleFrom(

        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.white,

        foregroundColor: isSelected ? Colors.white : Colors.black,

        padding: const EdgeInsets.symmetric(vertical: 12),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      ),

    );

  }



  Widget _buildHeightSlider() {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            const Text("Chiều cao", style: TextStyle(fontSize: 18)),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Text(_height.toStringAsFixed(0),

                    style: const TextStyle(

                        fontSize: 32, fontWeight: FontWeight.bold)),

                const Text(" cm", style: TextStyle(color: Colors.grey)),

              ],

            ),

            Slider(

              value: _height,

              min: 100,

              max: 220,

              divisions: 120,

              label: _height.toStringAsFixed(0),

              onChanged: (value) => setState(() => _height = value),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildWeightSlider() {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            const Text("Cân nặng", style: TextStyle(fontSize: 18)),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Text(_weight.toStringAsFixed(1),

                    style: const TextStyle(

                        fontSize: 32, fontWeight: FontWeight.bold)),

                const Text(" kg", style: TextStyle(color: Colors.grey)),

              ],

            ),

            Slider(

              value: _weight,

              min: 30,

              max: 150,

              divisions: 240,

              label: _weight.toStringAsFixed(1),

              onChanged: (value) => setState(() => _weight = value),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildResultCard() {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            const Text("Kết quả BMI của bạn",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            SizedBox(

              height: 200,

              child: SfRadialGauge(

                axes: <RadialAxis>[

                  RadialAxis(

                    minimum: 10,

                    maximum: 40,

                    ranges: <GaugeRange>[

                      GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue),

                      GaugeRange(startValue: 18.5, endValue: 25, color: Colors.green),

                      GaugeRange(startValue: 25, endValue: 30, color: Colors.orange),

                      GaugeRange(startValue: 30, endValue: 40, color: Colors.red),

                    ],

                    pointers: <GaugePointer>[

                      NeedlePointer(value: _bmiResult!)

                    ],

                    annotations: <GaugeAnnotation>[

                      GaugeAnnotation(

                        widget: Text(

                          _bmiResult!.toStringAsFixed(1),

                          style: const TextStyle(

                              fontSize: 25, fontWeight: FontWeight.bold),

                        ),

                        angle: 90,

                        positionFactor: 0.5,

                      )

                    ],

                  )

                ],

              ),

            ),

            Text(

              _classification,

              style:

                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

            ),

          ],

        ),

      ),

    );

  }

}
