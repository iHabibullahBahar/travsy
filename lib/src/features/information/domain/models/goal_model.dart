class GoalModel {
  String title;
  String image;
  String endpoint;
  bool isSelected = false;
  GoalModel({
    required this.title,
    required this.image,
    required this.endpoint,
    this.isSelected = false,
  });
}
