import 'package:flutter/material.dart';
import 'package:posyandu_app/model/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration.dart';
import 'package:posyandu_app/components/navbottom.dart';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:get/get.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 2.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    Timer(
      const Duration(seconds: 3),
      () {
        Get.off(() => const LoginPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1500));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F6ECD),
      body: Center(
        child: Hero(
          tag: 'logoTag',
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Image(
              image: AssetImage('assets/logo.png'),
              width: 250,
              height: 250,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMeValue = false;
  bool isPasswordVisible = false;

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      _showAwesomeDialog("Email dan password tidak diisi", DialogType.error);
      return;
    } else if (email.isEmpty) {
      _showAwesomeDialog("Email tidak diisi", DialogType.error);
      return;
    } else if (password.isEmpty) {
      _showAwesomeDialog("Password tidak diisi", DialogType.error);
      return;
    }

    var res = await LocalDatabase().login(User(
      email: email,
      password: password,
    ));

    if (res == true) {
      _showAwesomeDialog("Login berhasil", DialogType.success);

      User? loggedInUser = await LocalDatabase().getUserByEmail(email);

      if (loggedInUser != null) {
        _saveRememberMe(email);
        Future.delayed(const Duration(seconds: 2), () {
          Get.off(() => NavigationButtom(user: loggedInUser));
        });
      } else {
        _showAwesomeDialog(
          "Data pengguna tidak ditemukan.",
          DialogType.error,
        );
      }
    } else {
      _showAwesomeDialog(
        "Login gagal. Periksa kembali email dan password Anda.",
        DialogType.error,
      );
    }
  }

  void _saveRememberMe(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rememberedEmail', email);
  }

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  void _loadRememberedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('rememberedEmail') ?? '';
      rememberMeValue = emailController.text.isNotEmpty;
    });
  }

  void _showAwesomeDialog(String message, DialogType dialogType) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: 'Pesan',
      desc: message,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                child: Hero(
                  tag: 'logoTag',
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 210,
                      height: 210,
                      child: Image(
                        image: AssetImage('assets/logo2.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 15, 110, 205),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please sign in to continue.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 15, 110, 205),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF0F6ECD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF0F6ECD)),
                        ),
                        hintText: "Masukkan email anda...",
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          color: Color(0xFF0F6ECD),
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF0F6ECD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF0F6ECD)),
                        ),
                        hintText: "Masukkan password anda...",
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          color: Color(0xFF0F6ECD),
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF0F6ECD), // warna ikon
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMeValue,
                        onChanged: (value) {
                          setState(() {
                            rememberMeValue = value!;
                          });
                        },
                        activeColor: const Color(0xFF0F6ECD),
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 2.0,
                        ),
                      ),
                      const Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F6ECD), // warna teks
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Lupa Password?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F6ECD)),
                  )
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F6ECD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah memiliki akun? ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: const Text(
                      "Registrasi",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F6ECD)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}