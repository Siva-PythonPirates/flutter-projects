import 'package:flutter/material.dart';

class Booking {
  final String spotName;
  final DateTime date;
  final int duration;
  final double totalPrice;

  Booking({
    required this.spotName,
    required this.date,
    required this.duration,
    required this.totalPrice,
  });
}
