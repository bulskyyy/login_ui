import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ Background pattern
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 💳 Card form di tengah layar
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 380, // ⬅️ Batas lebar form agar tidak terlalu besar
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Selamat datang kembali!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Silakan masuk dengan akun Anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 📧 Email
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 🔒 Password
                      TextField(
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          hintText: 'Masukkan kata sandi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 🧩 Remember Me + Lupa Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                activeColor: const Color(0xFF1E5BAA),
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('Ingat saya'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // 🔥 NAVIGASI KE HALAMAN LUPA PASSWORD
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Lupa Kata Sandi?',
                              style: TextStyle(color: Color(0xFF1E5BAA)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // 🚪 Tombol Masuk
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E5BAA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            print('🔥 TOMBOL MASUK DIKLIK!'); // Debug
                            // Navigasi ke Home Screen setelah login
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}