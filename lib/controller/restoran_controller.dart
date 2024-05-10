import 'package:ucp2_paml/service/restoran_service.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../model/restoran.dart';

class RestoranController {
  final restoranService = RestoranService();

  Future<Map<String, dynamic>> addRestoran(
      Restoran restoran, File? file) async {
    Map<String, String> data = {
      'nama': restoran.nama,
      'lokasi': restoran.lokasi
    };

    try {
      var response = await restoranService.addRestoran(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil disimpan',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }
        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data',
        };
      }
    } catch (e) {}
    return {
      'success': false,
      'message': 'Terjadi kesalahan: $e',
    };
  }

  Future<List<Restoran>> getRestoran() async {
    try {
      List<dynamic> restoranData = await restoranService.fetchRestoran();
      List<Restoran> restoran =
          restoranData.map((json) => Restoran.fromMap(json)).toList();
      return restoran;
    } catch (e) {
      throw Exception('Failed to get people');
    }
  }
}
