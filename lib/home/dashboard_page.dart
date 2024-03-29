import 'package:flutter/material.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:posyandu_app/model/database_helper.dart';

class DashboardPage extends StatefulWidget {
  final User user;
  const DashboardPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User? loggedInUser = User(email: '', password: '');
  final LocalDatabase localDb = LocalDatabase();

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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage('assets/logodashboard.png'),
              width: 350,
              height: 150,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0F6ECD),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(
                    'Selamat Datang!', // Menggunakan nama dari database
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    loggedInUser?.namaIbu ??
                        "Loading...", // Menggunakan alamat dari database
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0F6ECD),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Jadwal Imunisasi',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Kamis, 28 Maret 2024',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}