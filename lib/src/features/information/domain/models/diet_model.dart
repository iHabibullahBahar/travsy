class DietModel {
  String title;
  String image;
  String endPoint;
  bool isSelected;
  bool isDeactivated = false;
  DietModel({
    required this.title,
    this.image = "",
    required this.endPoint,
    this.isSelected = false,
  });
}
