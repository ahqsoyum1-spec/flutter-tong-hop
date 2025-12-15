import 'package:flutter/material.dart';
import '../models/user.dart';


class ProfileScreen extends StatelessWidget {


  static const String routeName = '/ex8_profile';





  const ProfileScreen({super.key});





  @override


  Widget build(BuildContext context) {


    final user = ModalRoute.of(context)!.settings.arguments as User;





    return Scaffold(


      appBar: AppBar(


        title: const Text("Hồ sơ người dùng"),


        elevation: 0,


      ),


      body: Column(


        children: [


          _buildHeader(context, user),


          Expanded(


            child: SingleChildScrollView(


              padding: const EdgeInsets.all(16.0),


              child: Column(


                crossAxisAlignment: CrossAxisAlignment.start,


                children: [


                  _buildSectionTitle(context, "Thông tin liên lạc"),


                  _buildInfoCard(


                    context,


                    [


                      _buildInfoTile(Icons.email_outlined, "Email", user.email),


                      _buildInfoTile(Icons.phone_outlined, "Điện thoại", user.phone),


                      _buildInfoTile(Icons.location_on_outlined, "Địa chỉ", user.address.toString()),


                    ],


                  ),


                  const SizedBox(height: 24),


                  _buildSectionTitle(context, "Chi tiết cá nhân"),


                  _buildInfoCard(


                    context,


                    [


                      _buildInfoTile(Icons.cake_outlined, "Ngày sinh", user.birthDate),


                      _buildInfoTile(Icons.work_outline, "Phòng ban", user.company.department),


                      _buildInfoTile(Icons.alternate_email, "Username", user.username),


                    ],


                  ),


                  const SizedBox(height: 32),


                  Center(


                    child: ElevatedButton.icon(


                      onPressed: () => Navigator.of(context).pop(),


                      icon: const Icon(Icons.logout),


                      label: const Text("Đăng xuất"),


                      style: ElevatedButton.styleFrom(


                        backgroundColor: Colors.redAccent,


                        shape: RoundedRectangleBorder(


                          borderRadius: BorderRadius.circular(12),


                        ),


                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),


                      ),


                    ),


                  ),


                ],


              ),


            ),


          ),


        ],


      ),


    );


  }





  Widget _buildHeader(BuildContext context, User user) {


    return Container(


      width: double.infinity,


      padding: const EdgeInsets.only(bottom: 20, top: 10),


      decoration: BoxDecoration(


        color: Theme.of(context).primaryColor,


        borderRadius: const BorderRadius.only(


          bottomLeft: Radius.circular(30),


          bottomRight: Radius.circular(30),


        ),


      ),


      child: Column(


        children: [


          CircleAvatar(


            radius: 55,


            backgroundColor: Colors.white,


            child: CircleAvatar(


              radius: 50,


              backgroundImage: NetworkImage(user.image),


            ),


          ),


          const SizedBox(height: 15),


          Text(


            "${user.firstName} ${user.lastName}",


            style: const TextStyle(


              fontSize: 24,


              fontWeight: FontWeight.bold,


              color: Colors.white,


            ),


          ),


          const SizedBox(height: 4),


          Text(


            "${user.company.title} tại ${user.company.name}",


            style: TextStyle(color: Colors.white.withOpacity(0.8)),


          ),


        ],


      ),


    );


  }





  Widget _buildSectionTitle(BuildContext context, String title) {


    return Padding(


      padding: const EdgeInsets.only(bottom: 8.0),


      child: Text(


        title.toUpperCase(),


        style: Theme.of(context).textTheme.titleMedium?.copyWith(


              fontWeight: FontWeight.bold,


              color: Theme.of(context).primaryColor,


            ),


      ),


    );


  }





  Widget _buildInfoCard(BuildContext context, List<Widget> tiles) {


    return Card(


      elevation: 2.0,


      shape: RoundedRectangleBorder(


        borderRadius: BorderRadius.circular(12.0),


      ),


      child: Column(children: tiles),


    );


  }





  Widget _buildInfoTile(IconData icon, String title, String value) {


    return ListTile(


      leading: Icon(icon, color: Colors.grey.shade600),


      title: Text(title),


      subtitle: Text(


        value,


        style: const TextStyle(


          fontWeight: FontWeight.bold,


          fontSize: 16,


          color: Colors.black87,


        ),


      ),


    );


  }


}

