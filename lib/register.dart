import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text fields' controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  final List<String> jenisKelaminItems = ['Laki-laki', 'Perempuan'];
  String _selectedJenisKelamin =
      'Laki-laki'; // State untuk menyimpan nilai dropdown

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
                    controller: _namaController,
                    decoration: InputDecoration(
                      hintText: 'Nama',
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
                  DropdownButtonFormField<String>(
                    value: _selectedJenisKelamin,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJenisKelamin = newValue ?? '';
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Jenis Kelamin',
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
                    items: jenisKelaminItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
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
                      child: Text('Register'),
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
      // Data yang ingin Anda simpan
      String nama = _namaController.text;
      String jenisKelamin = _selectedJenisKelamin;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Validasi data sebelum disimpan ke Firestore (optional)
      if (nama.isEmpty ||
          email.isEmpty ||
          jenisKelamin.isEmpty ||
          password.isEmpty) {
        print('Harap isi semua kolom');
        return;
      }

      // Validasi dropdown untuk jenis kelamin
      if (_selectedJenisKelamin.isEmpty) {
        print('Harap pilih jenis kelamin');
        return;
      }

      // Registrasi pengguna dengan Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan data pengguna ke Firestore
      String userId = userCredential.user?.uid ?? '';
      await _users.doc(userId).set({
        'nama': nama,
        'jenisKelamin': jenisKelamin,
      });

      // Ambil token otentikasi
      String? authToken = await userCredential.user?.getIdToken();
      if (authToken != null) {
        // Simpan token otentikasi ke Firestore
        await _users.doc(userId).update({
          'authToken': authToken,
        });
      }

      // Berhasil menyimpan data
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
                MaterialPageRoute(builder: (context) => const login()),
              );
            },
          )
        ],
      ).show();
    } catch (e) {
      // Error ketika menyimpan data
      print('Error saat menyimpan data ke Firestore: $e');
    }
    return;
  }
}
