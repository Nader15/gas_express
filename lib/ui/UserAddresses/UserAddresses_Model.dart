class UserAddresses {
  int id;
  String name;
  String city;
  dynamic section;
  dynamic street;
  dynamic buildingno;
  dynamic floor;
  dynamic flatno;
  String gPS;
  dynamic buildingphotoid;
  int customerid;

  UserAddresses(
      {this.id,
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

  UserAddresses.fromJson(Map<String, dynamic> json) {
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
