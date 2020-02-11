import 'package:http/http.dart' as http;

fetchPost(championName) async {
  final response = await http.get(
      'https://cms.paladins.com/wp-json/wp/v2/champions?slug=' +
          championName.replaceAll(' ', '-').toLowerCase() +
          '&lang_id=1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return response.body;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}