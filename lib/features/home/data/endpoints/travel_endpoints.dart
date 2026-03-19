import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['WEB_SOCKET']!;
final String getQuoteForTrip = '/passengers/trips/quote';
final String createTripUrl = '/passengers/trips';
