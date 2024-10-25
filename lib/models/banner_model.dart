class BannerModel {
  final String bannerName;
  final String bannerImage;
  final String description;

  BannerModel({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerName: json['banner_name'],
      bannerImage: json['banner_image'],
      description: json['description'],
    );
  }
}
