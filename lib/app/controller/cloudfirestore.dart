import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMasjid(String namamasjid, String alamat, String lokasi,
      num koorlatitude, num koorlongtitude) async {
    CollectionReference masjid =
        FirebaseFirestore.instance.collection('masjid');
    return masjid
        .add({
          'namamasjid': namamasjid,
          'alamat': alamat,
          'lokasi': lokasi,
          'latitude': koorlatitude,
          'longtitude': koorlongtitude
        })
        .then((value) => print("Tempat ditambah"))
        .catchError((error) => print("Failed to add masjid: $error"));
  }
}
