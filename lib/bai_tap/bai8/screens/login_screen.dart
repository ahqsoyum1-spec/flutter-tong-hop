import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercises_collection/bai_tap/bai8/screens/profile_screen.dart' as ex8;
import 'package:flutter_exercises_collection/widgets/app_drawer.dart';
import '../models/user.dart';


// ================== LOGIN SCREEN ==================
class LoginScreen extends StatefulWidget {
  static const String routeName = '/ex8_login'; // Tên route login

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: "emilys"); // User mẫu
  final _passwordController = TextEditingController(text: "emilyspass"); // Pass mẫu
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final inputUser = _usernameController.text;
      final inputPass = _passwordController.text;
      setState(() => _isLoading = true);

      final dio = Dio();
      try {
        // 1. Gọi API Login lấy Token
        final resp = await dio.post("https://dummyjson.com/auth/login",
            data: {
              "username": inputUser,
              "password": inputPass,
              "expiresInMins": 30
            },
            options: Options(contentType: Headers.jsonContentType));

        if (resp.statusCode == 200) {
          final String accessToken = resp.data['accessToken'];
          
          // 2. Gọi API lấy thông tin User bằng Token
          final meResponse = await dio.get(
            'https://dummyjson.com/auth/me',
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
          );
          
          User user = User.fromJson(meResponse.data);

          if (!mounted) return;
          
          // 3. Chuyển trang (Sử dụng routeName tĩnh)
          Navigator.pushNamed(
            context, 
            ex8.ProfileScreen.routeName, // Sửa thành route của bài 8
            arguments: user
          );
        }
      } on DioException catch (e) {
        String message = "Đã có lỗi xảy ra";
        if (e.response != null) {
          message = e.response?.data['message'] ?? "Sai tài khoản hoặc mật khẩu";
        } else {
          message = "Lỗi kết nối mạng: ${e.message}";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bài 8: API Login")),
      drawer: const AppDrawer(), // Thêm Drawer để quay về menu chính
      backgroundColor: Colors.white,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Đăng nhập API",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sử dụng tài khoản dummyjson để tiếp tục",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Nhập username" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Nhập password" : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text("LOGIN", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Hint: Use 'emilys' / 'emilyspass'",
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}