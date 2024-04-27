import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DetailEducation extends StatelessWidget {
  final String judul;
  final String gambar;
  final DateTime tanggalUpload;
  final String deskripsi;

  const DetailEducation({
    super.key,
    required this.judul,
    required this.gambar,
    required this.tanggalUpload,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Artikel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFF0F6ECD),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              _buildImage(),
              const SizedBox(height: 20),
              // Judul
              Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              // Tanggal Upload
              Text(
                'Tanggal Upload: ${tanggalUpload.day}/${tanggalUpload.month}/${tanggalUpload.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Deskripsi
              Text(
                deskripsi,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    try {
      final imageData = base64.decode(gambar);
      return Image.memory(
        imageData,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return const Placeholder();
    }
  }
}