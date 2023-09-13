import 'package:alquran/controller/surah_controller.dart';
import 'package:alquran/detail_surah.dart';
import 'package:flutter/material.dart';
import 'model/surah.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Myhome> {
  late Future<List<Surah>> _futureSurahs;
  final SurahController _surahController = SurahController();
  @override
  void initState() {
    super.initState();
    _futureSurahs = _surahController.fetchSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 265,
          backgroundColor: const Color(0xFF759DA6),
          flexibleSpace: Stack(
            children: <Widget>[
              Align(
                alignment:
                    Alignment.centerRight, // Atur posisi gambar di rata kanan
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 150,
                      right: 16.0), // Sesuaikan nilai margin sesuai keinginan
                  height: 194,
                  width: 296,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/masjid.png'), // Ganti 'assets/images/masjid.png' dengan path gambar yang Anda inginkan
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 90.0, right: 20.0, bottom: 1.0),
                    child: Text(
                      'Pacitan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    // Tambahkan Padding pada teks "7 Juli 2023"
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '7 Juli 2023',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Asalamualaikum Ikhwan',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: 5), // Jarak antara teks dan ikon
                            Icon(
                              Icons.waving_hand,
                              size: 15,
                              color: Color(
                                0xFFFFD74A, // Atur warna ikon sesuai kebutuhan
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Iqbal Hario Syahputra',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFFFFD74A),
            labelColor: Color(0xFFFFD74A),
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "Surah",
              ),
              Tab(
                text: "Juz",
              ),
              Tab(
                text: "Saved",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder<List<Surah>>(
              future: _futureSurahs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final surahs = snapshot.data!;
                  return ListView.builder(
                    itemCount: surahs.length,
                    itemBuilder: (context, index) {
                      final surah = surahs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailsurah(
                                surahNumber: surah.nomor!,
                                surah: surah,
                              ),
                            ),
                          );
                          // print("Navigating to surah number: ${surah.nomor}");
                        },
                        child: Card(
                          child: ListTile(
                            leading: Text('Surah ${surah.nomor.toString()}'),
                            title: Center(child: Text(surah.nama ?? '')),
                            subtitle: Center(
                                child: Text(
                                    '${surah.tempatTurun}.${surah.jumlahAyat} Ayat')),
                            trailing: Text(surah.namaLatin ?? ''),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            height: 80,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFF759DA6),
                selectedItemColor: const Color(0xFFFFD74A),
                unselectedItemColor: Colors.white,
                showUnselectedLabels: true,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profil',
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
