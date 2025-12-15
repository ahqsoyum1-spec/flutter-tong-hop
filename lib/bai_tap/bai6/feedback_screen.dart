
import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/widgets/app_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  static const String routeName = '/ex11_feedback';

  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _contentController = TextEditingController();

  double _rating = 4.0;



  @override

  void dispose() {

    _nameController.dispose();

    _contentController.dispose();

    super.dispose();

  }



  void _submitFeedback() {

    if (_formKey.currentState!.validate()) {

      FocusScope.of(context).unfocus(); // Hide keyboard

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(

              'Cảm ơn ${_nameController.text} đã đánh giá ${_rating.toInt()} sao!'),

          backgroundColor: Colors.green,

          behavior: SnackBarBehavior.floating,

        ),

      );

    }

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Gửi phản hồi'),

        centerTitle: true,

      ),

      drawer: const AppDrawer(),

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(16.0),

          child: Card(

            elevation: 8.0,

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(16.0),

            ),

            child: Padding(

              padding: const EdgeInsets.all(24.0),

              child: Form(

                key: _formKey,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Text(

                      "Chúng tôi rất mong nhận được phản hồi của bạn!",

                      textAlign: TextAlign.center,

                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(

                            fontWeight: FontWeight.bold,

                          ),

                    ),

                    const SizedBox(height: 8),

                    Text(

                      "Vui lòng cho chúng tôi biết trải nghiệm của bạn.",

                      textAlign: TextAlign.center,

                      style: Theme.of(context).textTheme.bodyMedium,

                    ),

                    const SizedBox(height: 32),

                    TextFormField(

                      controller: _nameController,

                      decoration: InputDecoration(

                        labelText: 'Họ tên',

                        prefixIcon: const Icon(Icons.person_outline),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(12),

                        ),

                      ),

                      validator: (val) =>

                          (val == null || val.isEmpty) ? 'Vui lòng nhập họ tên' : null,

                    ),

                    const SizedBox(height: 20),

                    _buildRatingBar(),

                    const SizedBox(height: 20),

                    TextFormField(

                      controller: _contentController,

                      maxLines: 5,

                      decoration: InputDecoration(

                        labelText: 'Nội dung góp ý',

                        alignLabelWithHint: true,

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(12),

                        ),

                      ),

                      validator: (val) => (val == null || val.isEmpty)

                          ? 'Vui lòng nhập nội dung'

                          : null,

                    ),

                    const SizedBox(height: 30),

                    ElevatedButton.icon(

                      onPressed: _submitFeedback,

                      icon: const Icon(Icons.send),

                      label: const Text('Gửi phản hồi',

                          style: TextStyle(

                              fontSize: 16, fontWeight: FontWeight.bold)),

                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.symmetric(vertical: 16),

                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(12),

                        ),

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }



  Widget _buildRatingBar() {

    return Column(

      children: [

        Text(

          "Bạn đánh giá trải nghiệm này như thế nào?",

          style: Theme.of(context).textTheme.titleMedium,

        ),

        const SizedBox(height: 8),

        RatingBar.builder(

          initialRating: _rating,

          minRating: 1,

          direction: Axis.horizontal,

          allowHalfRating: false,

          itemCount: 5,

          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),

          itemBuilder: (context, _) => const Icon(

            Icons.star,

            color: Colors.amber,

          ),

          onRatingUpdate: (rating) {

            setState(() {

              _rating = rating;

            });

          },

        ),

      ],

    );

  }

}
