import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:posyandu_app/main.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:posyandu_app/components/navbottom.dart';
import 'package:posyandu_app/model/database_helper.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? loggedInUser = User(email: '', password: '');
  final LocalDatabase localDb = LocalDatabase();
  bool isSwitched = true;

  @override
  void initState() {
    super.initState();
    _fetchLoggedInUser();
  }

  Future<void> _fetchLoggedInUser() async {
    loggedInUser = await localDb.getUserByEmail(widget.user.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F6ECD),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            if (loggedInUser != null) {
              Get.offUntil(MaterialPageRoute(builder: (context) => NavigationButtom(user: loggedInUser!)), (route) => route.isFirst);
            }
          },
        ),
        titleSpacing: 0,
      ),
      body:
          loggedInUser == null ? _buildLoadingIndicator() : _buildProfileBody(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProfileBody() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0F6ECD),
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.namaIbu ?? 'Tidak tersedia',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.user.nikIbu ?? 'Tidak tersedia',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildEditButton(),
          const SizedBox(height: 20),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            
          },
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text(
            'Edit',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F6ECD),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            _showLogoutConfirmation();
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            'Logout',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F6ECD),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Konfirmasi',
      desc: 'Apakah Anda yakin ingin logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Get.offAll(() => const LoginPage());
      },
    ).show();
  }
}