class PromoCodeModelSuccess {
  String coupon;
  dynamic discountPercentage;
  dynamic discountValue;

  PromoCodeModelSuccess({this.coupon, this.discountPercentage, this.discountValue});

  PromoCodeModelSuccess.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    discountPercentage = json['discount_percentage'];
    discountValue = json['discount_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon'] = this.coupon;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_value'] = this.discountValue;
    return data;
  }
}
