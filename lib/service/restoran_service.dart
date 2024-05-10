import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RestoranService {
  final String baseUrl = 'https://paml.tatiumy.com/api/';
  final String endpoint = 'restoran';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addRestoran(
      Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    return await http.Response.fromStream(await request.send());
  }

  Future<List<dynamic>> fetchRestoran() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['restoran'];
    } else {
      throw Exception('Failed to load restoran: ${response.reasonPhrase}');
    }
  }
}
