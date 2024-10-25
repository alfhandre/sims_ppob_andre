import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_andre/url.dart';
import '../models/service_model.dart';
import '../utils/storage_util.dart';

class LayananService {
  final Url urlProvider = Url();

  Future<List<ServiceModel>> fetchServices() async {
    final serviceUrl = '${urlProvider.getVal()}services';

    try {
      String? token = await StorageUtil.getToken();

      final response = await http.get(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return (data['data'] as List)
            .map((json) => ServiceModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load services, status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching services: $error');
      throw Exception('Error fetching services: $error');
    }
  }
}
