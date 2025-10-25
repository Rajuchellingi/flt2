NotificationHistory notificationHistoryFromJson(dynamic str) =>
    (NotificationHistory.fromJson(str));

class NotificationHistory {
  late final int? count;
  late final int? totalPages;
  late final List<NotificationHistoryData>? notification;
  late final String? sTypename;

  NotificationHistory(
      {required this.count,
      required this.totalPages,
      required this.notification,
      required this.sTypename});

  NotificationHistory.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['totalPages'];
    if (json['notification'] != null) {
      notification = <NotificationHistoryData>[];
      json['notification'].forEach((v) {
        notification!.add(new NotificationHistoryData.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    if (this.notification != null)
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;

    return data;
  }
}

class NotificationHistoryData {
  late final String? sId;
  late final String? title;
  late final String? description;
  late final String? notificationStatus;
  late final String? linkType;
  late final String? link;
  late final String? image;
  late final String? creationDate;
  late final String? sTypename;

  NotificationHistoryData(
      {required this.sId,
      required this.title,
      required this.description,
      required this.notificationStatus,
      required this.linkType,
      required this.link,
      required this.image,
      required this.creationDate,
      required this.sTypename});

  NotificationHistoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    notificationStatus = json['notificationStatus'];
    linkType = json['linkType'];
    link = json['link'];
    image = json['image'];
    creationDate = json['creationDate'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['notificationStatus'] = this.notificationStatus;
    data['linkType'] = this.linkType;
    data['link'] = this.link;
    data['image'] = this.image;
    data['creationDate'] = this.creationDate;
    data['__typename'] = this.sTypename;

    return data;
  }
}

NotificationCount notificationCountFromJson(dynamic str) =>
    (NotificationCount.fromJson(str));

class NotificationCount {
  late final int? count;
  late final String? sTypename;

  NotificationCount({required this.count, required this.sTypename});

  NotificationCount.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;

    return data;
  }
}
