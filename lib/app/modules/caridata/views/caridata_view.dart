import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/caridata_controller.dart';

class CaridataView extends GetView<CaridataController> {
  const CaridataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        title: Text(
          'Cari Data',
          style: TextStyle(color: Colors.grey[350]),
        ),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
        child: ListView(
          children: [
            TextJudul(
              text: 'Nama Masjid',
            ),
            textfield(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(5),
                      overlayColor: MaterialStatePropertyAll(Colors.grey[400]),
                      fixedSize:
                          MaterialStatePropertyAll(Size(double.infinity, 65)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.grey[200])),
                  onPressed: () {},
                  child: Text(
                    'CARI',
                    style: TextStyle(color: Colors.grey[700]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class textfield extends StatelessWidget {
  const textfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '',
        labelStyle: TextStyle(color: Colors.grey[700]), // Warna teks label
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Colors.grey[300]!), // Warna border saat tidak di-focus
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: Colors.grey), // Warna border saat di-focus
        ),
      ),
    );
  }
}

class TextJudul extends StatelessWidget {
  TextJudul({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16, // Ukuran font teks
          fontWeight: FontWeight.bold, // Berat font teks
          color: Colors.grey[600], // Warna teks
        ),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
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
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: <String>[
              'Mulyoagung',
              'Sumbersekar',
              'Landungsari',
              'Kalisongo',
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
    );
  }
}
