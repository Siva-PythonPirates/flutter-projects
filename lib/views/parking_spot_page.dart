import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'parking_spot_details_page.dart';

class ParkingSpot {
  final String name;
  final LatLng location;
  final int availableSpaces;

  ParkingSpot({
    required this.name,
    required this.location,
    required this.availableSpaces,
  });
}

class ParkingSpotListPage extends StatelessWidget {
  final List<ParkingSpot> parkingSpots = [
    ParkingSpot(
      name: 'Parking Spot 1',
      location: LatLng(13.0881, 80.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 2',
      location: LatLng(13.0729, 80.2212),
      availableSpaces: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spots'),
      ),
      body: ListView.builder(
        itemCount: parkingSpots.length,
        itemBuilder: (context, index) {
          final parkingSpot = parkingSpots[index];

          return ListTile(
            title: Text(parkingSpot.name),
            subtitle: Text('Available spaces: ${parkingSpot.availableSpaces}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ParkingSpotDetailsPage(
                        name: parkingSpot.name,
                        location: parkingSpot.location.toString(),
                        isAvailable: true,
                        price: 5.0,
                        availableSpaces: parkingSpot.availableSpaces,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
