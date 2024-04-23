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

  static Future<void> login(BuildContext context, String email, String password) async {
    try {
      const String apiUrl = "http://192.168.43.59:8000/api/auth/login";
      final response = await http.post(Uri.parse(apiUrl),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final token = jsonData['data']['token'] as String;
        setToken(token);
        // ignore: use_build_context_synchronously
        await tokenRequest(context, token);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> tokenRequest(BuildContext context, String token) async {
    try {
      final responseData = await http.get(
        Uri.parse("http://192.168.43.59:8000/api/auth/me"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final userData = UserData(
          id: jsonGet['data']['id'],
          email: jsonGet['data']['email'],
          nikIbu: jsonGet['data']['nikIbu'],
          namaIbu: jsonGet['data']['namaIbu'],
          tempatLahir: jsonGet['data']['tempat_lahir'],
          tanggalLahir: jsonGet['data']['tanggal_lahir'],
          alamat: jsonGet['data']['alamat'],
          telepon: jsonGet['data']['telepon'],
        );
        // ignore: use_build_context_synchronously
        _showMessageDialog(context, jsonGet['data']['namaIbu'] as String, userData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> logout(BuildContext context, String token) async {
    try {
      const String apiUrl = "http://192.168.43.59:8000/api/auth/logout";
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $_token',
      });
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
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

  // static Future<void> register(BuildContext context) async {

  // }
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
      MaterialPageRoute(builder: (context) => NavigationButtom(userData: userData)),
    );
  });
}