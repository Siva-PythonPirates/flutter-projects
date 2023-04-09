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
    ParkingSpot(
      name: 'Parking Spot 3',
      location: LatLng(13.0501, 80.2123),
      availableSpaces: 8,
    ),
    ParkingSpot(
      name: 'Parking Spot 4',
      location: LatLng(13.0678, 80.2397),
      availableSpaces: 3,
    ),
    ParkingSpot(
      name: 'Parking Spot 5',
      location: LatLng(13.0881, 91.2838),
      availableSpaces: 0,
    ),
    ParkingSpot(
      name: 'Parking Spot 6',
      location: LatLng(13.0881, 90.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 7',
      location: LatLng(13.0881, 86.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 8',
      location: LatLng(13.0881, 87.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 9',
      location: LatLng(13.0881, 88.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 10',
      location: LatLng(13.0881, 89.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 11',
      location: LatLng(13.0881, 81.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 12',
      location: LatLng(13.0881, 82.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 13',
      location: LatLng(13.0881, 83.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 14',
      location: LatLng(13.0881, 84.2838),
      availableSpaces: 10,
    ),
    ParkingSpot(
      name: 'Parking Spot 15',
      location: LatLng(13.0881, 85.2838),
      availableSpaces: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spots'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: parkingSpots.length,
          itemBuilder: (context, index) {
            final parkingSpot = parkingSpots[index];

            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(
                  parkingSpot.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'Available spaces: ${parkingSpot.availableSpaces}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkingSpotDetailsPage(
                        name: parkingSpot.name,
                        location: parkingSpot.location.toString(),
                        isAvailable: true,
                        price: 5.0,
                        availableSpaces: parkingSpot.availableSpaces,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
