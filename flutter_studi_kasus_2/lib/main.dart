import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final rmData = <String, String>{};

  MainApp({super.key}) {
    rmData['name'] = "Rumah Makan Padang Jaya";
    rmData['email'] = "rmpadangjy@gmail.com";
    rmData['phone'] = "08953363185264";
    rmData['image'] = "padangjaya.jpg";
    rmData['address'] = "Jl. kelengan Kecil 1, No. 36B";
    rmData['desc'] = "Menyediakan semua masakan padang terenak di indonesia dan dunia dengan harga yang terjangkau";
    rmData['listMenu1'] = "Nasi Padang";
    rmData['listMenu2'] = "Rendang";
    rmData['listMenu3'] = "Sate Padang";
    rmData['listMenu4'] = "Gulai";
    rmData['listMenu5'] = "Sambalado";
    rmData['jamBuka'] = "08.00";
    rmData['jamTutup'] = "21.00";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi RM Padang Jaya",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi rmData"),),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,

                decoration: const BoxDecoration(color: Colors.black),
                child: Text(
                  rmData['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Image(image: AssetImage('assets/${rmData["image"] ?? 'padangjaya.jpg'}')),
              const SizedBox(height: 10),
              Row(
                children: [
                  btnContact(Icons.phone, Colors.deepPurple),
                  btnContact(Icons.mark_email_read, Colors.blueAccent),
                  btnContact(Icons.location_city_rounded, Colors.green),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              teksKotak(Colors.black38, 'Deskripsi'),
              const SizedBox(
                height: 10,
              ),
              Text(
                rmData['desc'] ?? '',
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Menu Makanan',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textNoContainer(rmData['listMenu1'] ?? ''),
              textNoContainer(rmData['listMenu2'] ?? ''),
              textNoContainer(rmData['listMenu3'] ?? ''),
              textNoContainer(rmData['listMenu4'] ?? ''),
              textNoContainer(rmData['listMenu5'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              teksKotak(Colors.black38, 'Alamat'),
              const SizedBox(
                height: 10,
              ),
              textAttribute('Alamat', rmData['address'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              teksKotak(Colors.black38, 'Jam Operasional'),
              const SizedBox(
                height: 10,
              ),
              textAttribute('Jam Buka', rmData['jamBuka'] ?? ''),
              textAttribute('Jam Tutup', rmData['jamTutup'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }
  Expanded btnContact(IconData icon, var color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(icon),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: color,
            foregroundColor: Colors.white),
      ),
    );
  }
  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            '- $judul ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(
          '- ',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          teks,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
  Row textNoContainer(String teks) {
    return Row(
      children: [
        Text(
          ': ',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          teks,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
  Container teksKotak(Color bgColor, String teks) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
  Future launch(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil : $uri');
    }
  }
}
