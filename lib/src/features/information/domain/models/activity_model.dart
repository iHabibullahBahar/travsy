class ActivityModel {
  final String title;
  final String image;
  final dynamic descriptionWidget;
  final String endpoint;
  bool isSelected = false;

  ActivityModel({
    required this.title,
    required this.image,
    required this.descriptionWidget,
    required this.endpoint,
    this.isSelected = false,
  });
}
