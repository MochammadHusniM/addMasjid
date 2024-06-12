import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:tugas/app/modules/listmasjid/views/itemdetail.dart';
import 'package:latlong2/latlong.dart' as latLng;
import '../controllers/listmasjid_controller.dart';

class ListmasjidView extends GetView<ListmasjidController> {
  ListmasjidView({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  late Stream<QuerySnapshot> _stream;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('masjid');

  @override
  Widget build(BuildContext context) {
    double latitude;
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Masjid'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            // Get the data
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            // Convert the documents to Maps
            List<Map<String, dynamic>> items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();

            // Display the list
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> thisItem = items[index];
                String id = documents[index].id;
                double latitude = thisItem['latitude'].toDouble();
                double longtitude = thisItem['longtitude'].toDouble();

                // Return the widget for the list items
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      title: Text(
                        '${thisItem['namamasjid']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            '${thisItem['alamat']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${thisItem['lokasi']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 120,
                            child: IgnorePointer(
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter:
                                      latLng.LatLng(latitude, longtitude),
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
                                        point:
                                            latLng.LatLng(latitude, longtitude),
                                        child: Icon(
                                          Icons.gps_fixed,
                                          color: Colors.red,
                                        ))
                                  ]),
                                  CircleLayer(
                                    circles: [
                                      CircleMarker(
                                        point:
                                            latLng.LatLng(latitude, longtitude),
                                        color:
                                            Colors.lightGreen.withOpacity(0.3),
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
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Get.to(() => Itemdetail(id));
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(child: Text('No data found.'));
        },
      ),
    );
  }
}
