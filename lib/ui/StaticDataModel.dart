class StaticDataModel {
  int count;
  dynamic next;
  dynamic previous;
  List<StaticDataItem> results;

  StaticDataModel({this.count, this.next, this.previous, this.results});

  StaticDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<StaticDataItem>();
      json['results'].forEach((v) {
        results.add(new StaticDataItem.fromJson(v));
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

class StaticDataItem {
  int id;
  String name;
  String value;
  bool show=true;

  StaticDataItem({this.id, this.name, this.value,this.show});

  StaticDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
