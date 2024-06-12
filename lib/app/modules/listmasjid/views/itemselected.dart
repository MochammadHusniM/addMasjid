import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugas/app/modules/listmasjid/controllers/listmasjid_controller.dart';
import 'package:tugas/app/routes/app_pages.dart';

class Itemselected extends GetView<ListmasjidController> {
  Itemselected(this._selectItem, {Key? key}) : super(key: key) {
    _controllerNamamasjid =
        TextEditingController(text: _selectItem['namamasjid']);
    _controllerAlamat = TextEditingController(text: _selectItem['alamat']);
    lokasi = _selectItem['lokasi'];
    _latitude = TextEditingController(text: _selectItem['latitude'].toString());
    _longtitude =
        TextEditingController(text: _selectItem['longtitude'].toString());
    _reference =
        FirebaseFirestore.instance.collection('masjid').doc(_selectItem['id']);
  }

  final Map _selectItem;
  late DocumentReference _reference;
  late TextEditingController _controllerNamamasjid;
  late TextEditingController _controllerAlamat;
  late String lokasi;
  late TextEditingController _latitude;
  late TextEditingController _longtitude;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit an item'),
          actions: [
            IconButton(
              onPressed: () {
                // Delete the item
                _reference.delete();
                Get.back(); // Go back after deletion
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Nama Masjid',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    TextFormField(
                      controller: _controllerNamamasjid,
                      decoration: InputDecoration(
                          hintText: 'Nama Masjid',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the mosque name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Alamat',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    TextFormField(
                      controller: _controllerAlamat,
                      decoration: InputDecoration(
                          hintText: 'Lokasi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
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
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.grey[700]),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              lokasi = newValue ?? '';
                              // setState(() {
                              //   lokasi = newValue ?? '';
                              // });
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Latitude',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    TextFormField(
                      controller: _latitude,
                      decoration: InputDecoration(
                          hintText: 'Lokasi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Latitude',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    TextFormField(
                      controller: _longtitude,
                      decoration: InputDecoration(
                          hintText: 'Longtitude',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(5),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.grey[300]),
                          shadowColor: WidgetStatePropertyAll(Colors.grey),
                          overlayColor:
                              WidgetStatePropertyAll(Colors.lightGreen),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                          fixedSize: WidgetStatePropertyAll(
                              Size(double.maxFinite, 60))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String namamasjid = _controllerNamamasjid.text;
                          String alamat = _controllerAlamat.text;
                          String lokasix = lokasi;
                          num latutideC = num.parse(_latitude.text);
                          num longtutideC = num.parse(_longtitude.text);

                          // Create the Map of data to update
                          Map<String, dynamic> dataToUpdate = {
                            'namamasjid': namamasjid,
                            'alamat': alamat,
                            'lokasi': lokasix,
                            'latitude': latutideC,
                            'longtitude': longtutideC
                          };

                          // Call update()
                          await _reference.update(dataToUpdate);
                          Get.back();
                          Get.back();
                          Get.back();

                          // Go back after update
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
