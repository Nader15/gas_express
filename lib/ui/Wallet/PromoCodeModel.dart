class PromoCodeModel {
  int count;
  dynamic next;
  dynamic previous;
  List<PromoCodeItem> results;

  PromoCodeModel({this.count, this.next, this.previous, this.results});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<PromoCodeItem>();
      json['results'].forEach((v) {
        results.add(new PromoCodeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromoCodeItem {
  String couponCode;
  String expiryDate;
  dynamic discountValue;
  int discountPercentage;

  PromoCodeItem(
      {this.couponCode,
        this.expiryDate,
        this.discountValue,
        this.discountPercentage});

  PromoCodeItem.fromJson(Map<String, dynamic> json) {
    couponCode = json['coupon_code'];
    expiryDate = json['expiry_date'];
    discountValue = json['discount_value'];
    discountPercentage = json['discount_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_code'] = this.couponCode;
    data['expiry_date'] = this.expiryDate;
    data['discount_value'] = this.discountValue;
    data['discount_percentage'] = this.discountPercentage;
    return data;
  }
}
