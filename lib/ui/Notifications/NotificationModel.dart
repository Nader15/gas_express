class NotificationModel {
  int count;
  dynamic next;
  dynamic previous;
  List<NotificationItem> results;

  NotificationModel({this.count, this.next, this.previous, this.results});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<NotificationItem>();
      json['results'].forEach((v) {
        results.add(new NotificationItem.fromJson(v));
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

class NotificationItem {
  int id;
  String messagetouser;
  String messagetitle;
  String messagedetails;
  int messageto;

  NotificationItem(
      {this.id,
        this.messagetouser,
        this.messagetitle,
        this.messagedetails,
        this.messageto});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messagetouser = json['messagetouser'];
    messagetitle = json['messagetitle'];
    messagedetails = json['messagedetails'];
    messageto = json['messageto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messagetouser'] = this.messagetouser;
    data['messagetitle'] = this.messagetitle;
    data['messagedetails'] = this.messagedetails;
    data['messageto'] = this.messageto;
    return data;
  }
}
