import 'package:flutter/material.dart';
import './login.dart';
import './register.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
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
            mainAxisAlignment:
                MainAxisAlignment.start, // Letakkan di bawah tengah
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "AYO BACA Al'QURAN",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Rasulullah SAW bersabda, Bacalah Alquran, maka sesungguhnya ia akan datang di hari kiamat memberi syafaat kepada pembacanya",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 346,
                        height: 41,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              // DetailPage adalah halaman yang dituju
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(
                                    0xFF32DCE2)), // Ganti kode hex sesuai keinginan Anda
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )),
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 346,
                        height: 41,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              // DetailPage adalah halaman yang dituju
                              MaterialPageRoute(builder: (context) => login()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF32DCE2)),
                          ),
                          child: const Text(
                            'login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
