class MealModel {
  String title;
  String image;
  dynamic descriptionWidget;
  bool isSelected = false;
  String? meal1;
  String? meal2;
  String? meal3;
  String? snack1;
  String? snack2;
  MealModel({
    required this.title,
    required this.image,
    this.isSelected = false,
    this.descriptionWidget,
    this.meal1 = null,
    this.meal2 = null,
    this.meal3 = null,
    this.snack1 = null,
    this.snack2 = null,
  });
}
