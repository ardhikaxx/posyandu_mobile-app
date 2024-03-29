import 'package:flutter/material.dart';

class Grafik extends StatefulWidget {
  const Grafik({super.key});

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grafik',
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
            // Action when back arrow is pressed
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
                'Grafik Pertumbuhan dan Perkembangan Anak',
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
