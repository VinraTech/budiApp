class TermsAndConditionModel {
  String? message;
  TAndC? tAndC;
  PrivacyPolicy? privacyPolicy;
  bool? status;
  UserDetail? userDetail;

  TermsAndConditionModel(
      {this.message,
      this.tAndC,
      this.status,
      this.privacyPolicy,
      this.userDetail});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tAndC =
        json['t_and_c'] != null ? new TAndC.fromJson(json['t_and_c']) : null;
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    privacyPolicy = json['privacy_policy'] != null
        ? new PrivacyPolicy.fromJson(json['privacy_policy'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tAndC != null) {
      data['t_and_c'] = this.tAndC!.toJson();
    }
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class TAndC {
  int? id;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;

  TAndC({this.id, this.title, this.content, this.createdAt, this.updatedAt});

  TAndC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PrivacyPolicy {
  int? id;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;

  PrivacyPolicy(
      {this.id, this.title, this.content, this.createdAt, this.updatedAt});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserDetail {
  int? id;
  int? userId;
  int? onboarded;
  int? termsAccepted;
  int? privacyAccepted;
  bool? pushNotifications;
  int? active;
  String? createdAt;
  String? updatedAt;

  UserDetail(
      {this.id,
      this.userId,
      this.onboarded,
      this.termsAccepted,
      this.privacyAccepted,
      this.pushNotifications,
      this.active,
      this.createdAt,
      this.updatedAt});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    onboarded = json['onboarded'];
    termsAccepted = json['terms_accepted'];
    privacyAccepted = json['privacy_accepted'];
    pushNotifications = json['push_notifications'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['onboarded'] = this.onboarded;
    data['terms_accepted'] = this.termsAccepted;
    data['privacy_accepted'] = this.privacyAccepted;
    data['push_notifications'] = this.pushNotifications;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PushNotificationModel {
  String? message;
  UserProfileDetail? userDetail;

  PushNotificationModel({this.message, this.userDetail});

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userDetail = json['user_detail'] != null
        ? new UserProfileDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserProfileDetail {
  int? id;
  int? userId;
  bool? onboarded;
  bool? termsAccepted;
  bool? privacyAccepted;
  bool? pushNotifications;
  bool? active;
  String? createdAt;
  String? updatedAt;

  UserProfileDetail(
      {this.id,
        this.userId,
        this.onboarded,
        this.termsAccepted,
        this.privacyAccepted,
        this.pushNotifications,
        this.active,
        this.createdAt,
        this.updatedAt});

  UserProfileDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    onboarded = json['onboarded'];
    termsAccepted = json['terms_accepted'];
    privacyAccepted = json['privacy_accepted'];
    pushNotifications = json['push_notifications'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['onboarded'] = this.onboarded;
    data['terms_accepted'] = this.termsAccepted;
    data['privacy_accepted'] = this.privacyAccepted;
    data['push_notifications'] = this.pushNotifications;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
