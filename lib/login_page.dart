import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_page.dart';
import 'admin_page.dart'; // Halaman khusus admin
import 'main.dart'; // Untuk GlobalDrawer

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Harap isi email dan password.');
      return;
    }

    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Validasi apakah admin
      final isAdmin = email == 'bismillah@gmail.com';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          isAdmin ? const AdminPageWithDrawer() : const ChatPageWithDrawer(),
        ),
      );
    } catch (e) {
      _showError('Gagal Login: $e');
    }
  }

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Harap isi email dan password.');
      return;
    }

    try {
      // Cek apakah email sudah terdaftar
      final List<String> methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        _showError('Akun sudah dibuat. Silakan login.');
        return;
      }

      // Buat akun baru
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showMessage('Akun berhasil dibuat. Anda masuk sebagai pengguna.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPageWithDrawer(),
        ),
      );
    } catch (e) {
      _showError('Gagal Mendaftar: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Daftar')),
      drawer: const GlobalDrawer(currentPage: 'LoginPage'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _register,
              child: const Text('Daftar Akun Baru'),
            ),
          ],
        ),
      ),
    );
  }
}
