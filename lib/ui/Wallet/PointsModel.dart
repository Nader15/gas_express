class PointsModel {
  List<PointItem> data;

  PointsModel({this.data});

  PointsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PointItem>();
      json['data'].forEach((v) {
        data.add(new PointItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PointItem {
  int userUsage;
  int countToReach;
  int duration;

  PointItem({this.userUsage, this.countToReach, this.duration});

  PointItem.fromJson(Map<String, dynamic> json) {
    userUsage = json['user_usage'];
    countToReach = json['count_to_reach'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_usage'] = this.userUsage;
    data['count_to_reach'] = this.countToReach;
    data['duration'] = this.duration;
    return data;
  }
}
