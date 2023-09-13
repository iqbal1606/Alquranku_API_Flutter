import 'package:alquran/controller/ayat_controller.dart';
import 'package:alquran/model/ayat.dart';
import 'package:alquran/model/surah.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// ignore: depend_on_referenced_packages
// import 'package:audioplayers/audioplayers.dart';
// For Iconify Widget

class Detailsurah extends StatefulWidget {
  final int surahNumber;
  final Surah surah;

  Detailsurah({
    super.key,
    required this.surahNumber,
    required this.surah,
  });

  @override
  _DetailsurahState createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  // ignore: prefer_final_fields
  AyatController _ayatController = AyatController();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playMusic() async {
    try {
      await audioPlayer.setAsset(
          'assets/music/alfatiha.mp3'); // Ganti dengan path musik Anda
      await audioPlayer.play();
    } catch (e) {
      print("Error: $e");
    }
  }

  void stopMusic() async {
    try {
      await audioPlayer.stop();
    } catch (e) {
      print("Error: $e");
    }
  }

  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // String namaLatin = widget.surah.namaLatin ?? "";

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          toolbarHeight: 184,
          backgroundColor: const Color(0xFF759DA6),
          flexibleSpace: Stack(
            children: <Widget>[
              Align(
                alignment:
                    Alignment.centerRight, // Atur posisi gambar di rata kanan
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 16.0,
                    top: 30.0,
                  ), // Sesuaikan nilai margin sesuai keinginan
                  height: 184,
                  width: 280,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/masjid.png'), // Ganti 'assets/images/masjid.png' dengan path gambar yang Anda inginkan
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0, bottom: 1.0),
                      child: Text(
                        widget.surah.namaLatin ?? "",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      // Tambahkan Padding pada teks "7 Juli 2023"
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        '(${widget.surah.arti})',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      // Tambahkan Padding pada teks "7 Juli 2023"
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        '${widget.surah.tempatTurun}.${widget.surah.jumlahAyat} ayat',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<Ayat>?>(
          // Gunakan fungsi fetchAyatList dari _ayatController
          future: _ayatController.fetchAyatList(widget.surahNumber),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            }

            final ayats = snapshot.data!;

            return ListView.builder(
              itemCount: ayats.length,
              itemBuilder: (context, index) {
                final ayat = ayats[index];
                return GestureDetector(
                  onTap: () {
                    print("Ini ayat ke-${ayat.nomorAyat}");
                    // Aksi yang ingin dilakukan saat ayat di-tap
                  },
                  child: Card(
                    color: containerColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ayat ${ayat.nomorAyat ?? ""}'),
                          Text(ayat.teksArab ?? ''),
                          Text(ayat.teksLatin ?? ''),
                          Text(ayat.teksIndonesia ?? ''),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 80,
          child: Container(
            color: const Color(
                0xFF759DA6), // Ganti dengan warna latar belakang yang diinginkan
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1.0),
                topRight: Radius.circular(1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.surah.namaLatin ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.surah.arti ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        stopMusic();
                      } else {
                        playMusic();
                      }
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                  ),
                  // Indikator musik yang berjalan
                  Container(
                    width: 200,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                      width: isPlaying ? 200 : 0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
