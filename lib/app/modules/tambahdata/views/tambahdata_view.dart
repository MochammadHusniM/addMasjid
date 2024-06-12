import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tugas/app/controller/cloudfirestore.dart';
import 'package:tugas/app/modules/caridata/views/caridata_view.dart';

class TambahdataView extends StatefulWidget {
  TambahdataView({super.key});

  @override
  _TambahdataViewState createState() => _TambahdataViewState();
}

class _TambahdataViewState extends State<TambahdataView> {
  TextEditingController masjid = TextEditingController();
  TextEditingController alamat = TextEditingController();
  String lokasi = '';
  TextEditingController koorlatitude = TextEditingController();
  TextEditingController koorlongtitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextJudul(
                text: 'Masjid',
              ),
              CustomTextField(
                controller: masjid,
              ),
              TextJudul(
                text: 'Alamat',
              ),
              CustomTextField(
                controller: alamat,
              ),
              TextJudul(text: 'Lokasi'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),
                      value: lokasi.isNotEmpty ? lokasi : null,
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.add,
                            size: 50,
                            color: Colors.grey[700],
                          ),
                          Text(
                            'Pilih Lokasi',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      icon:
                          Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          lokasi = newValue ?? '';
                        });
                      },
                      items: <String>[
                        'Gadingkulon',
                        'Kalisongo',
                        'Karangwidoro',
                        'Kucur',
                        'Landungsari',
                        'Mulyoagung',
                        'Petungsewu (Petung Sewu)',
                        'Selorejo',
                        'Sumbersekar',
                        'Tegalweru',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[700],
                              ),
                              Text(
                                value,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              TextJudul(text: 'Koordinat Latitude (Garis Lintang)'),
              CustomTextField(controller: koorlatitude),
              TextJudul(text: 'Koordinat Longtitude (Garis Bujur)'),
              CustomTextField(controller: koorlongtitude),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(5),
                    overlayColor: WidgetStatePropertyAll(Colors.grey[400]),
                    fixedSize:
                        WidgetStatePropertyAll(Size(double.maxFinite, 65)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                  ),
                  onPressed: () async {
                    num latitude = num.parse(koorlatitude.text);
                    num longtitude = num.parse(koorlongtitude.text);
                    await Firestore().addMasjid(
                        masjid.text, alamat.text, lokasi, latitude, longtitude);
                    masjid.clear();
                    alamat.clear();
                    koorlatitude.clear();
                    koorlongtitude.clear();
                    Get.snackbar('Berhasil Menambah', 'Masjid Telah di Simpan');
                    setState(() {
                      lokasi = '';
                    });
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '',
        labelStyle: TextStyle(color: Colors.grey[700]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

class TextJudul extends StatefulWidget {
  final String text;

  TextJudul({required this.text});

  @override
  State<TextJudul> createState() => _TextJudulState();
}

class _TextJudulState extends State<TextJudul> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
