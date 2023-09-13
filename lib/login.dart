import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './home.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginState();
}

class _LoginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 100),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey[100]?.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey[100]?.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 100,
                  ),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        sweatAlert(context);
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sweatAlert(BuildContext context) async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Validasi data sebelum login
      if (email.isEmpty || password.isEmpty) {
        print('Harap isi semua kolom');
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Login berhasil, simpan token otentikasi ke Shared Preferences
      String? authToken = await userCredential.user?.getIdToken();
      if (authToken != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('authToken', authToken);
      }

      // ignore: use_build_context_synchronously
      Alert(
        context: context,
        type: AlertType.success,
        title: "Register berhasil",
        desc: "Silahkan Login",
        buttons: [
          DialogButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                // DetailPage adalah halaman yang dituju
                MaterialPageRoute(builder: (context) => const Myhome()),
              );
            },
          )
        ],
      ).show();
    } catch (e) {
      // Error ketika login
      print('Error saat login: $e');
    }
    return;
  }
}
