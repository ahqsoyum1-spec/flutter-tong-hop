import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/bai_tap/bai7/bmi_screen.dart';
import 'package:flutter_exercises_collection/bai_tap/bai4/mycount.dart';
import 'package:flutter_exercises_collection/bai_tap/bai3/mycountdown.dart';
import 'package:flutter_exercises_collection/bai_tap/bai5/myPlace.dart';
import 'package:flutter_exercises_collection/bai_tap/bai9/myhome.dart';
import 'package:flutter_exercises_collection/bai_tap/bai10/my_product.dart';
import 'package:flutter_exercises_collection/bai_tap/bai6/feedback_screen.dart';
import 'package:flutter_exercises_collection/bai_tap/bai1/login_screen.dart';
import 'package:flutter_exercises_collection/bai_tap/bai2/register_screen.dart';
import 'package:flutter_exercises_collection/bai_tap/bai8/screens/login_screen.dart' as Ex8Login;
import 'package:flutter_exercises_collection/bai_tap/bai8/screens/profile_screen.dart' as Ex8Profile;
import 'constants/route_names.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Cấu hình Named Routes tại đây
      initialRoute: RouteNames.home,
      routes: {
        RouteNames.home: (context) => const HomeScreen(),
        RouteNames.exercise1: (context) => const LoginScreen(), // Bài tập 1
        RouteNames.exercise2: (context) => const RegisterScreen(), // Bài tập 2
        RouteNames.exercise3: (context) => const mycountdown(), // Bài tập 2
        RouteNames.exercise4: (context) => const mycount(), // Bài tập 2
        RouteNames.exercise5: (context) => const myPlace(), // Bài tập 2
        RouteNames.exercise6: (context) => const FeedbackScreen(),
        RouteNames.exercise7: (context) => const BMIScreen(),
        // RouteNames.exercise7_news_detail: (context) => const Ex7Detail.DetailScreen(),
        // 8
        RouteNames.exercise8_login: (context) => const Ex8Login.LoginScreen(),
        RouteNames.exercise8_login_profile: (context) => const Ex8Profile.ProfileScreen(),
        
        RouteNames.exercise9: (context) => const MyHome(), // Bài tập 2
        // RouteNames.exercise7: (context) => const NewsApp(), // Bài tập 2
        RouteNames.exercise10: (context) => const MyProduct(),
  // BookingListScreen.routeName

      },
    );
  }
}