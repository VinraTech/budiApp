import 'package:budi/Models/UserInfoModel.dart';

class NearbyAgentsModel {
  String? message;
  List<User>? users;

  NearbyAgentsModel({this.message, this.users});

  NearbyAgentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coordinates {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? latitude;
  String? longitude;

  Coordinates(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.latitude,
        this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}