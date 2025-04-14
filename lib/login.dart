import 'package:flutter/material.dart';
import 'signup.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Eğer global kullanıcı deposunda kullanıcı yoksa sabit bir kullanıcı tanımla
    if (UserStorage.registeredUser == null) {
      UserStorage.registeredUser = UserModel(
        username: "1",
        email: "1",
        password: "1",
      );
    }
  }

  void _checkLogin() {
    final registeredUser = UserStorage.registeredUser;
    if (registeredUser != null &&
        emailController.text.trim() == registeredUser.email &&
        passwordController.text == registeredUser.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş başarılı!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-posta veya şifre hatalı!'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 750),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chef.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // E-posta TextField
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.black), // Yazıyı siyah yapıyoruz
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-Posta',
                      labelStyle: const TextStyle(color: Colors.black), // Etiket siyah
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black), // Odaklandığında siyah
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Şifre TextField
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black), // Yazıyı siyah yapıyoruz
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      labelStyle: const TextStyle(color: Colors.black), // Etiket siyah
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black), // Odaklandığında siyah
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Butonları yan yana koymak için Row widget'ı kullanalım
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Giriş Yap Butonu
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _checkLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            side: BorderSide(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            'Giriş Yap',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Kayıt Ol Butonu
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            side: BorderSide(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
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
