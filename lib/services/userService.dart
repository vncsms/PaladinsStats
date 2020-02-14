import 'package:http/http.dart' as http;

getUser() async {
  final response = await http
      .get('https://api.paladins.guru/v3/profiles/12195252-picicio/summary');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return response.body;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
