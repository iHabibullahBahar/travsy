class HomeModel {
  bool? success;
  String? message;
  List<Data>? data;

  HomeModel({this.success, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      try {
        json['data'].forEach((v) {
          if (v != null)
            data!.add(new Data.fromJson(v));
          else
            data!.add(new Data());
        });
      } catch (e) {
        print("Error in HomeModel.fromJson");
        print(e);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      try {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      } catch (e) {
        print(e);
      }
    }
    return data;
  }
}

class Data {
  int? id;
  int? generatedRecipeId;
  String? name;
  String? image;
  double? calory;
  double? protein;
  double? carb;
  double? fat;
  List<String>? mealOption;
  bool? isFavorite;
  String? description;
  String? cookMethod;
  String? createdAt;

  Data(
      {this.id,
      this.generatedRecipeId,
      this.name,
      this.image,
      this.calory,
      this.protein,
      this.carb,
      this.fat,
      this.mealOption,
      this.isFavorite,
      this.description,
      this.cookMethod,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    generatedRecipeId = json['generated_recipe_id'];
    name = json['name'];
    image = json['image'];
    calory = json['calory']?.toDouble();
    protein = json['protein']?.toDouble();
    carb = json['carb']?.toDouble();
    fat = json['fat']?.toDouble();
    mealOption = json['meal_option'].cast<String>();
    isFavorite = json['is_favorite'];
    description = json['description'];
    cookMethod = json['cook_method'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['generated_recipe_id'] = this.generatedRecipeId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['calory'] = this.calory?.toDouble();
    data['protein'] = this.protein?.toDouble();
    data['carb'] = this.carb?.toDouble();
    data['fat'] = this.fat?.toDouble();
    data['meal_option'] = this.mealOption;
    data['is_favorite'] = this.isFavorite;
    data['description'] = this.description;
    data['cook_method'] = this.cookMethod;
    data['created_at'] = this.createdAt;
    return data;
  }
}
