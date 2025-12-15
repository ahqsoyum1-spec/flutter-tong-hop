


import 'package:flutter_exercises_collection/bai_tap/bai8/models/address.dart';
import 'package:flutter_exercises_collection/bai_tap/bai8/models/company.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String image;
  final String birthDate;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.image,
    required this.birthDate,
    required this.address,
    required this.company,
  });

  // Factory để chuyển JSON thành Object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      image: json['image'],
      birthDate: json['birthDate'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }
}