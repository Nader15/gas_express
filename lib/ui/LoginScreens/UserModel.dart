class UserModel {
  Results results;

  UserModel({this.results});

  UserModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    return data;
  }
}

class Results {
  int id;
  String telephoneno;
  String nameAr;
  String mail;
  String nameEn;
  String token;
  bool isverified;

  Results(
      {this.id,
        this.telephoneno,
        this.nameAr,
        this.mail,
        this.nameEn,
        this.token,
        this.isverified});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    telephoneno = json['telephoneno'];
    nameAr = json['name_ar'];
    mail = json['mail'];
    nameEn = json['name_en'];
    token = json['token'];
    isverified = json['isverified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['telephoneno'] = this.telephoneno;
    data['name_ar'] = this.nameAr;
    data['mail'] = this.mail;
    data['name_en'] = this.nameEn;
    data['token'] = this.token;
    data['isverified'] = this.isverified;
    return data;
  }
}
