// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../constants/route_names.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Ky Anh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'ahqsoyum1@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/place1.jpg', // Assuming you have a placeholder image
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/place2.jpg'), // Assuming you have a background
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Item về trang chủ
          _buildMenuItem(context, 'Trang chủ', Icons.home, RouteNames.home),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Bài tập',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
            ),
          ),
          // Danh sách bài tập
          _buildMenuItem(context, 'Bài tập 1: Login Form', Icons.login, RouteNames.exercise1),
          _buildMenuItem(context, 'Bài tập 2: Register Form', Icons.person_add, RouteNames.exercise2),
          _buildMenuItem(context, 'Bài tập 3: Timner', Icons.timer, RouteNames.exercise3),
          _buildMenuItem(context, 'Bài tập 4: Counter', Icons.add, RouteNames.exercise4),
          _buildMenuItem(context, 'Bài tập 5: Random screen color', Icons.color_lens, RouteNames.exercise5),
          _buildMenuItem(context, 'Bài tập 6: Feedback Screen', Icons.feedback, RouteNames.exercise6),
          _buildMenuItem(context, 'Bài tập 7: BMI Screen', Icons.calculate, RouteNames.exercise7),
          // _buildMenuItem(context, 'Bài tập 7: News API detail', Icons.newspaper, RouteNames.exercise7_news_detail),
          _buildMenuItem(context, 'Bài tập 8: API Login profile', Icons.account_circle, RouteNames.exercise8_login),
          _buildMenuItem(context, 'Bài tập 9: API Tin tức', Icons.article, RouteNames.exercise9),
          _buildMenuItem(context, 'Bài tập 10: API Product', Icons.shopping_bag, RouteNames.exercise10),
        ],
      ),
    );
  }

  // Hàm helper để tạo item cho gọn code
  Widget _buildMenuItem(BuildContext context, String title, IconData icon, String routeName) {
    // Kiểm tra xem đang ở route nào để highlight (nếu muốn - nâng cao)
    final bool isSelected = ModalRoute.of(context)?.settings.name == routeName;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey.shade700),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
        onTap: () {
          // Đóng Drawer trước
          Navigator.pop(context);
          
          if (ModalRoute.of(context)?.settings.name != routeName) {
            Navigator.pushNamed(context, routeName);
          }
        },
      ),
    );
  }
}