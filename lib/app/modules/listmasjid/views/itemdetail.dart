import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:tugas/app/modules/listmasjid/views/itemselected.dart';
import 'package:latlong2/latlong.dart' as latLng;

class Itemdetail extends StatefulWidget {
  Itemdetail(this.itemId, {super.key}) {
    _reference = FirebaseFirestore.instance.collection('masjid').doc(itemId);
    _futureData = _reference.get();
  }

  final String itemId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;

  @override
  State<Itemdetail> createState() => _ItemdetailState();
}

class _ItemdetailState extends State<Itemdetail> {
  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    double longtitude;
    double latitude;
    return Scaffold(
      appBar: AppBar(
        title: Text('Item details'),
        actions: [
          IconButton(
            onPressed: () {
              if (data != null) {
                data!['id'] = widget.itemId;
                Get.to(Itemselected(data!));
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // Delete the item
              widget._reference.delete();
              Get.back();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: widget._futureData,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Some error occurred: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data != null) {
            DocumentSnapshot documentSnapshot = snapshot.data!;
            data = documentSnapshot.data() as Map<String, dynamic>?;

            if (data == null) {
              return Center(
                  child: Text('Document does not exist or has no data.'));
            }

            latitude = data!['latitude'].toDouble();
            longtitude = data!['longtitude'].toDouble();
            // Display the data as a table
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nama Masjid',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${data!['namamasjid']}'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Alamat',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${data!['alamat']}'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Lokasi',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${data!['lokasi']}'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Latitude',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${data!['latitude']}'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Longtitude',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${data!['longtitude']}'),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Lokasi',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: 120,
                      child: IgnorePointer(
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: latLng.LatLng(latitude, longtitude),
                            initialZoom: 19.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                  point: latLng.LatLng(latitude, longtitude),
                                  child: Icon(
                                    Icons.gps_fixed,
                                    color: Colors.red,
                                  ))
                            ]),
                            CircleLayer(
                              circles: [
                                CircleMarker(
                                  point: latLng.LatLng(latitude, longtitude),
                                  color: Colors.lightGreen.withOpacity(0.3),
                                  borderStrokeWidth: 3,
                                  borderColor: Colors.lightGreen,
                                  radius: 50, // Radius in meters
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            );
          }

          return Center(child: Text('No data found.'));
        },
      ),
    );
  }
}
