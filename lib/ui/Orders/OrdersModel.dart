class OrdersModel {
  int count;
  dynamic next;
  dynamic previous;
  List<OrderItem> results;

  OrdersModel({this.count, this.next, this.previous, this.results});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<OrderItem>();
      json['results'].forEach((v) {
        results.add(new OrderItem.fromJson(v));
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

class OrderItem {
  int id;
  String customername;
  dynamic customeraddressname;
  dynamic customerdetails;
  String addressname;
  List<OrderproductDetails> orderproductDetails;
  String expecteddeliverdate;
  String expecteddeliverdatename;
  String mobile;
  String timeStarts;
  String timeEnds;
  String orderdatetime;
  int orderprice;
  dynamic deliveryprice;
  int taxes;
  dynamic rate;
  int totalprice;
  String ordercomments;
  String orderstatus;
  dynamic laststatusdatetime;
  String location;
  int discountValue;
  int customerid;
  dynamic driverid;
  int customeraddress;
  dynamic couponCode;

  OrderItem(
      {this.id,
        this.customername,
        this.customeraddressname,
        this.customerdetails,
        this.addressname,
        this.orderproductDetails,
        this.expecteddeliverdate,
        this.expecteddeliverdatename,
        this.mobile,
        this.timeStarts,
        this.timeEnds,
        this.orderdatetime,
        this.orderprice,
        this.deliveryprice,
        this.taxes,
        this.rate,
        this.totalprice,
        this.ordercomments,
        this.orderstatus,
        this.laststatusdatetime,
        this.location,
        this.discountValue,
        this.customerid,
        this.driverid,
        this.customeraddress,
        this.couponCode});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customername = json['customername'];
    customeraddressname = json['customeraddressname'] != null
        ? json['customeraddressname'].runtimeType.toString()=='String'? json['customeraddressname']: new Customeraddressname.fromJson(json['customeraddressname'])
        : null;
    customerdetails = json['customerdetails'] != null
        ?
    json['customerdetails'].runtimeType.toString()=="String"?json['customerdetails']:

    new Customerdetails.fromJson(json['customerdetails'])
        : null;
    addressname = json['addressname'];
    if (json['orderproductDetails'] != null) {
      orderproductDetails = new List<OrderproductDetails>();
      json['orderproductDetails'].forEach((v) {
        orderproductDetails.add(new OrderproductDetails.fromJson(v));
      });
    }
    expecteddeliverdate = json['expecteddeliverdate'];
    expecteddeliverdatename = json['expecteddeliverdatename'];
    mobile = json['mobile'];
    timeStarts = json['timeStarts'];
    timeEnds = json['timeEnds'];
    orderdatetime = json['orderdatetime'];
    orderprice = json['orderprice'];
    deliveryprice = json['deliveryprice'];
    taxes = json['taxes'];
    rate = json['rate'];
    totalprice = json['totalprice'];
    ordercomments = json['ordercomments'];
    orderstatus = json['orderstatus'];
    laststatusdatetime = json['laststatusdatetime'];
    location = json['location'];
    discountValue = json['discount_value']??0;
    customerid = json['customerid'];
    driverid = json['driverid'];
    customeraddress = json['customeraddress'];
    couponCode = json['coupon_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customername'] = this.customername;
    if (this.customeraddressname != null) {
      data['customeraddressname'] = this.customeraddressname.toJson();
    }
    if (this.customerdetails != null) {
      data['customerdetails'] = this.customerdetails.toJson();
    }
    data['addressname'] = this.addressname;
    if (this.orderproductDetails != null) {
      data['orderproductDetails'] =
          this.orderproductDetails.map((v) => v.toJson()).toList();
    }
    data['expecteddeliverdate'] = this.expecteddeliverdate;
    data['expecteddeliverdatename'] = this.expecteddeliverdatename;
    data['mobile'] = this.mobile;
    data['timeStarts'] = this.timeStarts;
    data['timeEnds'] = this.timeEnds;
    data['orderdatetime'] = this.orderdatetime;
    data['orderprice'] = this.orderprice;
    data['deliveryprice'] = this.deliveryprice;
    data['taxes'] = this.taxes;
    data['rate'] = this.rate;
    data['totalprice'] = this.totalprice;
    data['ordercomments'] = this.ordercomments;
    data['orderstatus'] = this.orderstatus;
    data['laststatusdatetime'] = this.laststatusdatetime;
    data['location'] = this.location;
    data['discount_value'] = this.discountValue;
    data['customerid'] = this.customerid;
    data['driverid'] = this.driverid;
    data['customeraddress'] = this.customeraddress;
    data['coupon_code'] = this.couponCode;
    return data;
  }
}

class Customeraddressname {
  int id;
  int customerid;
  String name;
  String city;
  dynamic section;
  dynamic street;
  String buildingno;
  String floor;
  String flatno;
  String gPS;
  String buildingphotoid;

  Customeraddressname(
      {this.id,
        this.customerid,
        this.name,
        this.city,
        this.section,
        this.street,
        this.buildingno,
        this.floor,
        this.flatno,
        this.gPS,
        this.buildingphotoid});

  Customeraddressname.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerid = json['customerid'];
    name = json['name'];
    city = json['city'];
    section = json['section'];
    street = json['street'];
    buildingno = json['buildingno'];
    floor = json['floor'];
    flatno = json['flatno'];
    gPS = json['GPS'];
    buildingphotoid = json['buildingphotoid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerid'] = this.customerid;
    data['name'] = this.name;
    data['city'] = this.city;
    data['section'] = this.section;
    data['street'] = this.street;
    data['buildingno'] = this.buildingno;
    data['floor'] = this.floor;
    data['flatno'] = this.flatno;
    data['GPS'] = this.gPS;
    data['buildingphotoid'] = this.buildingphotoid;
    return data;
  }
}

class Customerdetails {
  int id;
  dynamic customeraddressname;
  String telephoneno;
  String lastLogin;
  bool isSuperuser;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  String dateJoined;
  String nameAr;
  String nameEn;
  String mail;
  bool isverified;
  String password;
  bool isactive;
  bool lockedbyadmin;
  String createAt;
  int balance;
  String username;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  Customerdetails(
      {this.id,
        this.customeraddressname,
        this.telephoneno,
        this.lastLogin,
        this.isSuperuser,
        this.firstName,
        this.lastName,
        this.email,
        this.isStaff,
        this.isActive,
        this.dateJoined,
        this.nameAr,
        this.nameEn,
        this.mail,
        this.isverified,
        this.password,
        this.isactive,
        this.lockedbyadmin,
        this.createAt,
        this.balance,
        this.username,
        this.groups,
        this.userPermissions});

  Customerdetails.fromJson(Map<String, dynamic> json) {

    print("customeraddressname::: ${ json['customeraddressname']}");
    print("customeraddressnameruntimeType::: ${ json['customeraddressname'].runtimeType}");
    id = json['id'];
    customeraddressname = json['customeraddressname'] != null
        ?json['customeraddressname'].runtimeType.toString()=="String"?json['customeraddressname']: new Customeraddressname.fromJson(json['customeraddressname'])
        : null;
    telephoneno = json['telephoneno'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    mail = json['mail'];
    isverified = json['isverified'];
    password = json['password'];
    isactive = json['isactive'];
    lockedbyadmin = json['lockedbyadmin'];
    createAt = json['create_at'];
    balance = json['balance'];
    username = json['username'];
    if (json['groups'] != null) {
      groups = new List<Null>();
      json['groups'].forEach((v) {
        // groups.add(new Null.fromJson(v));
      });
    }
    if (json['user_permissions'] != null) {
      userPermissions = new List<Null>();
      json['user_permissions'].forEach((v) {
        // userPermissions.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customeraddressname != null) {
      data['customeraddressname'] = this.customeraddressname.toJson();
    }
    data['telephoneno'] = this.telephoneno;
    data['last_login'] = this.lastLogin;
    data['is_superuser'] = this.isSuperuser;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['mail'] = this.mail;
    data['isverified'] = this.isverified;
    data['password'] = this.password;
    data['isactive'] = this.isactive;
    data['lockedbyadmin'] = this.lockedbyadmin;
    data['create_at'] = this.createAt;
    data['balance'] = this.balance;
    data['username'] = this.username;
    if (this.groups != null) {
      // data['groups'] = this.groups.map((v) => v.toJson()).toList();
    }
    if (this.userPermissions != null) {
      // data['user_permissions'] =
      //     this.userPermissions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderproductDetails {
  String photo;
  String productnameEn;
  String productnameAr;
  int quantity;
  int unitprice;
  int totalprice;

  OrderproductDetails(
      {this.photo,
        this.productnameEn,
        this.productnameAr,
        this.quantity,
        this.unitprice,
        this.totalprice});

  OrderproductDetails.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    productnameEn = json['productname_en'];
    productnameAr = json['productname_ar'];
    quantity = json['quantity'];
    unitprice = json['unitprice'];
    totalprice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['productname_en'] = this.productnameEn;
    data['productname_ar'] = this.productnameAr;
    data['quantity'] = this.quantity;
    data['unitprice'] = this.unitprice;
    data['totalprice'] = this.totalprice;
    return data;
  }
}
