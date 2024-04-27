import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posyandu_app/components/navbottom.dart';
import 'package:posyandu_app/login.dart';
import 'package:posyandu_app/model/user.dart';

class AuthController {
  static late String _token;

  static void setToken(String token) {
    _token = token;
  }

  static String getToken() {
    return _token;
  }

  static Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      const String apiUrl = "http://192.168.1.9:8000/api/auth/login";
      final response = await http.post(Uri.parse(apiUrl),
          body: {'email_orang_tua': email, 'password_orang_tua': password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final token = jsonData['data']['token'] as String;
        setToken(token);
        await tokenRequest(context, token);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> tokenRequest(BuildContext context, String token) async {
    try {
      final responseData = await http.get(
        Uri.parse("http://192.168.1.9:8000/api/auth/me"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final userData = UserData.fromJson(jsonGet['data']
            as Map<String, dynamic>);
        _showMessageDialog(context, userData.namaIbu, userData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> logout(BuildContext context, String token) async {
    try {
      const String apiUrl = "http://192.168.1.9:8000/api/auth/logout";
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $_token',
      });
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        print('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> register(BuildContext context, {
    required String nikIbu,
    required String namaIbu,
    required String nikAyah,
    required String namaAyah,
    required String alamat,
    required String telepon,
    required String email,
    required String golDarah,
    required String tempatLahir,
    required String tanggalLahir,
    required String password,
  }) async {
    try {
      const String apiUrl = "http://192.168.1.9:8000/api/auth/register";
      final response = await http.post(Uri.parse(apiUrl), body: {
        'nik_ibu': nikIbu,
        'nama_ibu': namaIbu,
        'nik_ayah': nikAyah,
        'nama_ayah': namaAyah,
        'alamat': alamat,
        'telepon': telepon,
        'email_orang_tua': email,
        'gol_darah_ibu': golDarah,
        'tempat_lahir_ibu': tempatLahir,
        'tanggal_lahir_ibu': tanggalLahir,
        'password_orang_tua': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessDialog(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        _showErrorDialog(context);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog(context);
    }
  }

  static void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Berhasil',
      desc: 'Akun Anda telah berhasil didaftarkan!',
    ).show();
  }

  static void _showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Gagal',
      desc: 'Maaf, terjadi kesalahan saat melakukan registrasi.',
    ).show();
  }
}

void _showMessageDialog(BuildContext context, String data, UserData userData) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Login Successful',
    desc: 'Welcome, $data!',
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => NavigationButtom(userData: userData)),
    );
  });
}