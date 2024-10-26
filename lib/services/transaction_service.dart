import 'dart:convert';
import 'package:sims_ppob_andre/url.dart';
import 'package:sims_ppob_andre/utils/storage_util.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  final Url urlProvider = Url();

  Future<int?> fetchBalance() async {
    final balanceUrl = '${urlProvider.getVal()}balance';
    try {
      String? token = await StorageUtil.getToken();
      final res = await http.get(
        Uri.parse(balanceUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final jsonResponse = json.decode(res.body);
      print(jsonResponse);
      return jsonResponse['data']['balance'];
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<void> transaction(String service_code) async {
    final transactionUrl = '${urlProvider.getVal()}transaction';
    try {
      String? token = await StorageUtil.getToken();
      final res = await http.post(
        Uri.parse(transactionUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'service_code': service_code}),
      );
      final jsonResponse = json.decode(res.body);
      print(jsonResponse);
    } catch (e) {
      print("Exception: $e");
    }
  }
}
