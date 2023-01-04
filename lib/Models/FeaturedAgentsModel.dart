import 'package:budi/Models/ProfileDetailModel.dart';
import 'package:budi/Models/UserInfoModel.dart';

class FeaturedAgentsModel {
  String? message;
  List<User>? agents;

  FeaturedAgentsModel({this.message, this.agents});

  FeaturedAgentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['agents'] != null) {
      agents = <User>[];
      json['agents'].forEach((v) {
        agents!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}