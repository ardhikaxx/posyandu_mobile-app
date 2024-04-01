import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_app/components/navbottom.dart';
import 'package:posyandu_app/model/database_helper.dart';
import 'package:posyandu_app/model/user.dart';

class Imunisasi extends StatefulWidget {
  final User user;
  const Imunisasi({super.key, required this.user});

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  late User? loggedInUser = User(email: '', password: '');
  final LocalDatabase localDb = LocalDatabase();
  final TextEditingController _searchController = TextEditingController();

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
        title: const Text(
          'Imunisasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F6ECD),
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0F6ECD),
          ),
          onPressed: () {
            Get.offUntil(MaterialPageRoute(builder: (context) => NavigationButtom(user: loggedInUser!)), (route) => route.isFirst);
          },
        ),
        titleSpacing: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Center(
              child: Text(
                'Riwayat Imunisasi pada Anak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF0F6ECD)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF0F6ECD),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
