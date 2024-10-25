import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/models/banner_model.dart';
import '../services/banner_service.dart';

class BannerProvider with ChangeNotifier {
  List<BannerModel> _banners = [];
  bool _isLoading = false;

  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;

  Future<void> fetchBanners() async {
    _isLoading = true;
    notifyListeners();

    try {
      BannerService bannerService = BannerService();
      _banners = await bannerService.fetchBanners();
    } catch (e) {
      print('Error fetching banners: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
