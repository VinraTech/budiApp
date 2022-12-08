class TermsAndConditionModel {
  String? message;
  String? tAndC;
  String? privacy_policy;
  int? status;

  TermsAndConditionModel({this.message, this.tAndC, this.status,this.privacy_policy});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tAndC = json['t_and_c'];
    privacy_policy = json['privacy_policy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['t_and_c'] = this.tAndC;
    data['privacy_policy'] = this.privacy_policy;
    data['status'] = this.status;
    return data;
  }
}