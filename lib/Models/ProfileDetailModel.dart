class ProfileDetailModel {
  String? message;
  Profile? profile;

  ProfileDetailModel({this.message, this.profile});

  ProfileDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  int? userId;
  String? profilePicture;
  String? instagramHandle;
  String? tiktokHandle;
  String? facebookHandle;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
        this.userId,
        this.profilePicture,
        this.instagramHandle,
        this.tiktokHandle,
        this.facebookHandle,
        this.createdAt,
        this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    profilePicture = json['profile_picture'];
    instagramHandle = json['instagram_handle'];
    tiktokHandle = json['tiktok_handle'];
    facebookHandle = json['facebook_handle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['profile_picture'] = this.profilePicture;
    data['instagram_handle'] = this.instagramHandle;
    data['tiktok_handle'] = this.tiktokHandle;
    data['facebook_handle'] = this.facebookHandle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}