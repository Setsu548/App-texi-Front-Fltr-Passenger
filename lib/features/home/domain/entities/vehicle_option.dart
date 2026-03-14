// Modelo para una futura respuesta de API
import 'package:flutter/material.dart';

class VehicleOption {
  final String id;
  final String name;
  final double price;
  final int capacity;
  final int waitTime;
  final IconData icon;

  VehicleOption({
    required this.id,
    required this.name,
    required this.price,
    required this.capacity,
    required this.waitTime,
    required this.icon,
  });
}