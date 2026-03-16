import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['TRAVEL_URL']!;
final String getQuoteForTrip = '$baseUrl/passengers/trips/quote';
final String createTriUrl = '$baseUrl/passengers/trips';
