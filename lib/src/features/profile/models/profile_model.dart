class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    try {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      try {
        data['data'] = this.data!.toJson();
      } catch (e) {
        print(e);
      }
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? firebaseId;
  double? bmr;
  double? calorie;
  double? protein;
  double? carb;
  double? fat;
  String? dob;
  int? height;
  int? weight;
  String? activityLevel;
  String? goal;
  String? gender;
  int? meal1;
  int? meal2;
  int? meal3;
  int? snack1;
  int? snack2;
  bool? status;
  List<String>? dietaryOptions;
  String? subscriptionExpiryDate;
  String? referral;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.image,
      this.firebaseId,
      this.bmr,
      this.calorie,
      this.protein,
      this.carb,
      this.fat,
      this.dob,
      this.height,
      this.weight,
      this.activityLevel,
      this.goal,
      this.gender,
      this.meal1,
      this.meal2,
      this.meal3,
      this.snack1,
      this.snack2,
      this.status,
      this.dietaryOptions,
      this.subscriptionExpiryDate,
      this.referral});

  Data.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      email = json['email'];
      image = json['image'];
      firebaseId = json['firebase_id'];
      bmr = json['bmr']?.toDouble();
      calorie = json['calorie']?.toDouble();
      protein = json['protein']?.toDouble();
      carb = json['carb']?.toDouble();
      fat = json['fat']?.toDouble();
      dob = json['dob'];
      height = json['height'];
      weight = json['weight'];
      activityLevel = json['activity_level'];
      goal = json['goal'];
      gender = json['gender'];
      meal1 = json['meal1'];
      meal2 = json['meal2'];
      meal3 = json['meal3'];
      snack1 = json['snack1'];
      snack2 = json['snack2'];
      status = json['status'];
      dietaryOptions = json['dietary_options'].cast<String>();
      subscriptionExpiryDate = json['subscription_expiry_date'];
      referral = json['referral'].toString();
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['firebase_id'] = this.firebaseId;
    data['bmr'] = this.bmr;
    data['calorie'] = this.calorie;
    data['protein'] = this.protein;
    data['carb'] = this.carb;
    data['fat'] = this.fat;
    data['dob'] = this.dob;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['activity_level'] = this.activityLevel;
    data['goal'] = this.goal;
    data['gender'] = this.gender;
    data['meal1'] = this.meal1;
    data['meal2'] = this.meal2;
    data['meal3'] = this.meal3;
    data['snack1'] = this.snack1;
    data['snack2'] = this.snack2;
    data['status'] = this.status;
    data['subscription_expiry_date'] = this.subscriptionExpiryDate;
    data['referral'] = this.referral;
    return data;
  }
}
