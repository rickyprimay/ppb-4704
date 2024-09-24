import 'package:intl/intl.dart';

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat('yyyy-MM-dd');
enum TipeJabatan {kabag, manajer, direktur}

const int UMR = 2900000;

class Karyawan {
  String nama;
  String npp;
  String? alamat;
  int _gaji = UMR;
  int thnMasuk;

  Karyawan(this.nama, this.npp, this.thnMasuk, {int gaji = UMR}) {
    this.gaji = gaji;
  }

  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama Datang terlambat");
    } else {
      print("$nama datang tepat waktu");
    }
  }

  String deskripsi() {
    String teks = """===================
    NPP: $npp
    Nama: $nama
    Gaji: ${numFormat.format(gaji)}""";

    if (alamat != null) {
      teks += " Alamat: $alamat";
    }
    return teks;
  }

  int get tunjangan => ((2023 - thnMasuk) < 5) ? 50000 : 100000;

  int get gaji => _gaji + tunjangan;

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh di bawah UMR, gaji diatur ke UMR.");
    } else {
      _gaji = gaji;
    }
  }
}

class StafBiasa extends Karyawan {
  StafBiasa(super.nama, super.npp, super.thnMasuk);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan => 50000; 
}



class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.nama, super.npp, super.thnMasuk, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 10) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
  } else {
    print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  } 
  
  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.manajer) {
      return 2500000;
    } else {
      return 5000000;
    }
  }
  
  @override
  String deskripsi(){
    String teks = super.deskripsi();
    teks += "Jabatan : $jabatan";
    return teks;
  }
}
List<Map<String, dynamic>> dummyData() {
  List<Map<String, dynamic>> data = [
    {
      "npp": "A123",
      "nama": "Lars Bak",
      "thn_masuk": 2017,
      "jabatan": TipeJabatan.direktur,
      "alamat": "Semarang Indonesia"
    },
    {
      "npp": "A345",
      "nama": "Kasper Lund",
      "thn_masuk": 2018,
      "jabatan": TipeJabatan.manajer,
      "alamat": "Semarang Indonesia"
    },
    {
      "npp": "B231",
      "nama": "Guido Van Rossum",
      "alamat": "California Amerika"
    },
    {
      "npp": "B355",
      "nama": "Rasmus Lerdorf",
      "thn_masuk": 2015,
      "alamat": "Bandung Indonesia"
    },
    {
      "npp": "B355",
      "nama": "Dennis MacAlistair Ritchie",
      "jabatan": TipeJabatan.kabag,
      "alamat": "Semarang Indonesia"
    }
  ];
  return data;
}

List<Karyawan> genData(var listData) {
  List<Karyawan> data = [];

  for (var dtPegawai in listData) {
    Karyawan pegawai;
    if (dtPegawai.containsKey('jabatan')) {
      pegawai = Pejabat(
        dtPegawai['nama'],
        dtPegawai['npp'],
        dtPegawai['thn_masuk'] ?? 2020,
        dtPegawai['jabatan'],
      );
    } else {
      pegawai = StafBiasa(
        dtPegawai['nama'],
        dtPegawai['npp'],
        dtPegawai['thn_masuk'] ?? 2020,
      );
    }

    if (dtPegawai.containsKey('alamat')) {
      pegawai.alamat = dtPegawai['alamat'];
    }

    data.add(pegawai);
  }

  return data;
}
