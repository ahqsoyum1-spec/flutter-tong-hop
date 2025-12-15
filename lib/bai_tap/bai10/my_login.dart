import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<MyLogin> {
  String username = "";
  String password = "";
  String errorUser = "";
  String errorPass = "";
  bool showPass = false;

  void handleLogin() async {
    setState(() {
      errorUser = "";
      errorPass = "";
    });

    if (username.isEmpty) {
      setState(() => errorUser = "Vui lòng nhập tên người dùng");
      return;
    }

    if (password.isEmpty) {
      setState(() => errorPass = "Vui lòng nhập mật khẩu");
      return;
    } else if (password.length < 6) {
      setState(() => errorPass = "Mật khẩu phải ≥ 6 ký tự");
      return;
    }

    final url = Uri.parse("https://dummyjson.com/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
          "expiresInMins": 30,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        setState(() {
          errorPass = data["message"] ?? "Sai tên đăng nhập hoặc mật khẩu";
        });
        return;
      }
      if (!mounted) return;
      // Thành công → chuyển sang trang Profile
      Navigator.pushNamed(context, "profile", arguments: data);
    } catch (e) {
      setState(() {
        errorPass = "Không thể kết nối đến server";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf0ff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25),
              color: Colors.lightBlue,
              child: const Center(
                child: Text(
                  "Form Đăng nhập",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 70),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) => username = value,
                    decoration: InputDecoration(
                      labelText: "Tên người dùng",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (errorUser.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        errorUser,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 25),

                  TextField(
                    onChanged: (value) => password = value,
                    obscureText: !showPass,
                    decoration: InputDecoration(
                      labelText: "Mật khẩu",
                      prefixIcon: const Icon(Icons.lock, color: Colors.black87),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  if (errorPass.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        errorPass,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 35),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: handleLogin,
                      icon: const Icon(Icons.login),
                      label: const Text("Đăng nhập"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(160, 48), // QUAN TRỌNG
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
