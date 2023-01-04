class ContactUsModel {
  String? message;
  Support? support;

  ContactUsModel({this.message, this.support});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    support =
    json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class Support {
  String? topic;
  String? subject;
  String? message;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Support(
      {this.topic,
        this.subject,
        this.message,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Support.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    subject = json['subject'];
    message = json['message'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = this.topic;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}