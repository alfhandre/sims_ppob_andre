import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_andre/models/banner_model.dart';
import 'package:sims_ppob_andre/url.dart';
import 'package:sims_ppob_andre/utils/storage_util.dart';

class BannerService {
  final Url urlProvider = Url();

  Future<List<BannerModel>> fetchBanners() async {
    final serviceUrl = '${urlProvider.getVal()}banner';

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
            .map((json) => BannerModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load banner, status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching banner: $error');
      throw Exception('Error fetching banner: $error');
    }
  }
}
