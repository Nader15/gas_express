

import 'package:gas_express/utils/global_vars.dart';

class ProductsModel {
  int count;
  dynamic next;
  dynamic previous;
  List<ProductItem> results;

  ProductsModel({this.count, this.next, this.previous, this.results});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<ProductItem>();
      json['results'].forEach((v) {
        results.add(new ProductItem.fromJson(v));
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

class ProductItem {
  int id;
  String imageurl;
  String photoUrl;
  String productnameAr;
  String productnameEn;
  dynamic unitmeasure;
  dynamic unitprice;
  String details;
  int imageid;

  ProductItem(
      {this.id,
        this.imageurl,
        this.photoUrl,
        this.productnameAr,
        this.productnameEn,
        this.unitmeasure,
        this.unitprice,
        this.details,
        this.imageid});

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageurl = json['imageurl'];
    photoUrl = json['photo_url']!=null?imageUrl+json['photo_url']:json['photo_url'];
    productnameAr = json['productname_ar'];
    productnameEn = json['productname_en'];
    unitmeasure = json['unitmeasure'];
    unitprice = json['unitprice'];
    details = json['details'];
    imageid = json['imageid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageurl'] = this.imageurl;
    data['photo_url'] = this.photoUrl;
    data['productname_ar'] = this.productnameAr;
    data['productname_en'] = this.productnameEn;
    data['unitmeasure'] = this.unitmeasure;
    data['unitprice'] = this.unitprice;
    data['details'] = this.details;
    data['imageid'] = this.imageid;
    return data;
  }
}
