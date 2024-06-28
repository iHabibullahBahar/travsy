class FilterMealModel {
  final String name;
  final String endPoint;
  bool isSelected = false;

  FilterMealModel({
    required this.name,
    required this.endPoint,
    this.isSelected = false,
  });
}
