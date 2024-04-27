import 'dart:convert';

import 'package:flutter/material.dart';

class CardArtikel extends StatelessWidget {
  final String judul;
  final String gambar;
  final DateTime tanggalUpload;
  final Function onTap;

  const CardArtikel({
    super.key,
    required this.judul,
    required this.gambar,
    required this.tanggalUpload,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FE),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 317,
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: _buildImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Tanggal Upload: ${tanggalUpload.day}/${tanggalUpload.month}/${tanggalUpload.year}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
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