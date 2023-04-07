import 'package:flutter/material.dart';
import 'package:parking_app/views/profile_page.dart';

import '../models/booking.dart';
import '../models/user.dart';
import 'history_page.dart';
import 'parking_spot_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedTabIndex = 0;

  get bookingHistory => null;

  get user => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => _getAvailableSpotsPage();
              break;
            case '/history':
              builder = (BuildContext context) => _getBookingHistoryPage();
              break;
            case '/profile':
              builder = (BuildContext context) =>
                  _getProfilePage(user: user, bookingHistory: bookingHistory);
              break;
            case '/help':
              builder = (BuildContext context) => _getHelpandSupportPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
      bottomNavigationBar: Scaffold(
        body: _getPage(_selectedTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              label: 'Available Spots',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Booking History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Help & FAQ',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _getAvailableSpotsPage();
      case 1:
        return _getBookingHistoryPage();
      case 2:
        return _getProfilePage(user: user, bookingHistory: bookingHistory);
      case 3:
        return _getHelpandSupportPage();
      default:
        return Container();
    }
  }

  Widget _getAvailableSpotsPage() {
    // TODO: Implement code to display available parking spots
    return ParkingSpotListPage();
  }

  Widget _getBookingHistoryPage() {
    // TODO: Implement code to display booking history
    return BookingHistoryPage();
  }

  Widget _getProfilePage({required User user, required List<Booking> bookingHistory}) {
    return ProfilePage(user: user, bookingHistory: bookingHistory);
  }

  Widget _getHelpandSupportPage() {
    // TODO: Implement code to display available parking spots
    return Center(
      child: Text('FAQ and SUPPORT'),
    );
  }

}
