import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/layanan_service.dart';

class ServiceProvider with ChangeNotifier {
  List<ServiceModel> _services = [];
  bool _isLoading = true;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;

  final LayananService _apiService = LayananService();

  Future<void> fetchServices() async {
    try {
      _isLoading = true;
      notifyListeners();

      _services = await _apiService.fetchServices();
    } catch (e) {
      print("Error fetching services: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
