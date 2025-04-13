// signup.dart
import 'package:flutter/material.dart';


// user_model.dart
class UserModel {
  final String username;
  final String email;
  final String password;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
  });
}

class UserStorage {
  static UserModel? registeredUser;
}


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      // Yeni kullanıcı modeli oluşturuluyor
      UserModel newUser = UserModel(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Global saklama alanına kaydet
      UserStorage.registeredUser = newUser;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kayıt başarılı!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      // Giriş sayfasına geri dön
      Navigator.pop(context);
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Kullanıcı adı gerekli';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'E-posta gerekli';
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Geçerli bir e-posta girin';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Şifre gerekli';
    if (value.length < 6) return 'Şifre en az 6 karakter olmalı';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chef.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    validator: _validateUsername,
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      labelText: 'E-Posta',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text('Kayıt Ol'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
