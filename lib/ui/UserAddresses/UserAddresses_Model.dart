class UserAddresses {
  int count;
  dynamic next;
  dynamic previous;
  List<AddressItem> results;

  UserAddresses({this.count, this.next, this.previous, this.results});

  UserAddresses.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<AddressItem>();
      json['results'].forEach((v) {
        results.add(new AddressItem.fromJson(v));
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

class AddressItem {
  bool isDefault=false;
  int id;
  String name;
  String city;
  dynamic section;
  dynamic street;
  String buildingno;
  String floor;
  String flatno;
  String gPS;
  String buildingphotoid;
  int customerid;

  AddressItem(
      {
        this.isDefault,
        this.id,
        this.name,
        this.city,
        this.section,
        this.street,
        this.buildingno,
        this.floor,
        this.flatno,
        this.gPS,
        this.buildingphotoid,
        this.customerid});

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    section = json['section'];
    street = json['street'];
    buildingno = json['buildingno'];
    floor = json['floor'];
    flatno = json['flatno'];
    gPS = json['GPS'];
    buildingphotoid = json['buildingphotoid'];
    customerid = json['customerid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['section'] = this.section;
    data['street'] = this.street;
    data['buildingno'] = this.buildingno;
    data['floor'] = this.floor;
    data['flatno'] = this.flatno;
    data['GPS'] = this.gPS;
    data['buildingphotoid'] = this.buildingphotoid;
    data['customerid'] = this.customerid;
    return data;
  }
}
