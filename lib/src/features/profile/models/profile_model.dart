class ProfileModel {
  int? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? email;
  String? photo;
  int? townId;
  int? selectedCategoryId;
  String? activityStatus;
  int? isEmailVerified;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? city;
  String? town;
  String? questionIds;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.photo,
      this.townId,
      this.selectedCategoryId,
      this.activityStatus,
      this.isEmailVerified,
      this.lastLogin,
      this.createdAt,
      this.updatedAt,
      this.questionIds,
      this.city,
      this.town});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    photo = json['photo'];
    townId = int.parse(json['town_id'].toString());
    selectedCategoryId = int.parse(json['selected_category_id'].toString());
    activityStatus = json['activity_status'];
    isEmailVerified = int.parse(json['is_email_verified'].toString());
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionIds = json['question_ids'];
    city = json['city'];
    town = json['town'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['town_id'] = this.townId;
    data['selected_category_id'] = this.selectedCategoryId;
    data['activity_status'] = this.activityStatus;
    data['is_email_verified'] = this.isEmailVerified;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city'] = this.city;
    data['town'] = this.town;
    return data;
  }
}
