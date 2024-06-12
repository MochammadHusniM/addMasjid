import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tugas/app/modules/report/controllers/report_controller.dart';

Future<Position?> getLastKnownPosition() async {
  try {
    Position? position = await Geolocator.getLastKnownPosition();
    return position;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

class ReportView extends GetView<ReportController> {
  ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: FutureBuilder<Position?>(
        future: getLastKnownPosition(),
        builder: (context, positionSnapshot) {
          if (positionSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (positionSnapshot.hasError) {
            return Center(child: Text('Error: ${positionSnapshot.error}'));
          }

          Position? lastKnownPosition = positionSnapshot.data;
          if (lastKnownPosition == null) {
            return Center(child: Text('No last known position available.'));
          }

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('masjid').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No masjid found'));
              }

              Map<String, String> map = {};
              List<Marker> markers = [];
              List<CircleMarker> circles = [];
              int i = 0;

              snapshot.data!.docs.forEach((doc) {
                int random = Random().nextInt(0xFFFFFF);
                Color randomColor = Color(random);

                double latitude = doc['latitude'];
                double longitude = doc['longtitude'];
                String namamasjid = doc['namamasjid'];
                String lokasi = doc['lokasi'];
                String key = '$latitude-$longitude';

                i++;
                Marker marker = Marker(
                  point: latLng.LatLng(latitude, longitude),
                  child: Icon(
                    Icons.circle,
                    size: 12,
                    color: randomColor.withOpacity(1.0),
                  ),
                );

                circles.add(
                  CircleMarker(
                    point: latLng.LatLng(latitude, longitude),
                    color: randomColor.withOpacity(0.2),
                    borderStrokeWidth: 0.2,
                    borderColor: randomColor,
                    radius: i * 10.0, // Radius in meters
                  ),
                );
                markers.add(
                  Marker(
                    point: latLng.LatLng(
                      lastKnownPosition.latitude,
                      lastKnownPosition.longitude,
                    ),
                    child: const Icon(
                      Icons.gps_fixed, // Gunakan ikon GPS
                      size: 32,
                      color: Colors.red, // Warna biru
                    ),
                  ),
                );

                map[key] = '$namamasjid, $lokasi, $random';
                markers.add(marker);
              });

              return ListView(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter:
                            // latLng.LatLng(-7.945581609707316, 112.56841751221398),
                            latLng.LatLng(
                          lastKnownPosition.latitude,
                          lastKnownPosition.longitude,
                        ),
                        initialZoom: 10.9,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        CircleLayer(circles: circles),
                        MarkerLayer(markers: markers),
                      ],
                    ),
                  ),
                  // Displaying the table of masjid and lokasi
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Table(
                      border: TableBorder.all(), // Adding borders to the table
                      columnWidths: {
                        0: FlexColumnWidth(1), // Adjust column width as needed
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: map.entries.map((entry) {
                        var values = entry.value.split(
                            ','); // Splitting the value into "masjid", "lokasi", and "warna"
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Text(
                                '${values[0]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Text(
                                '${values[1]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Icon(
                                Icons.circle,
                                size: 12,
                                color: Color(int.parse(values[2]))
                                    .withOpacity(1.0),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
