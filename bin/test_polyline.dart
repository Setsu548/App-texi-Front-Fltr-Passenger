import 'dart:convert';
import 'dart:io';

void main() async {
  final apiKey = 'AIzaSyCiPWUT7LoCjEFruA6ebXaBBRwgptjQ4lQ'; // from your old code
  final origin = '37.4219983,-122.084';
  final dest = '37.4220011,-122.086';

  var url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$dest&key=$apiKey');

  var request = await HttpClient().getUrl(url);
  var response = await request.close();
  var resBody = await response.transform(utf8.decoder).join();
  print(resBody);
}
