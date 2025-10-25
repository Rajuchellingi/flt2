NotificationHistoryVM notificationHistoryVMFromJson(dynamic str) =>
    (NotificationHistoryVM.fromJson(str));

class NotificationHistoryVM {
  late final int? count;
  late final int? totalPages;
  late final List<NotificationHistoryDataVM>? notification;
  late final String? sTypename;

  NotificationHistoryVM(
      {required this.count,
      required this.totalPages,
      required this.notification,
      required this.sTypename});

  NotificationHistoryVM.fromJson(dynamic json) {
    count = json.count;
    totalPages = json.totalPages;
    if (json.notification != null) {
      notification = <NotificationHistoryDataVM>[];
      json.notification.forEach((v) {
        notification!.add(new NotificationHistoryDataVM.fromJson(v));
      });
    }
    sTypename = json.sTypename;
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

class NotificationHistoryDataVM {
  late final String? sId;
  late final String? title;
  late final String? description;
  late final String? notificationStatus;
  late final String? linkType;
  late final String? link;
  late final String? image;
  late final String? creationDate;
  late final String? sTypename;

  NotificationHistoryDataVM(
      {required this.sId,
      required this.title,
      required this.description,
      required this.notificationStatus,
      required this.linkType,
      required this.link,
      required this.image,
      required this.creationDate,
      required this.sTypename});

  NotificationHistoryDataVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    description = json.description;
    notificationStatus = json.notificationStatus;
    linkType = json.linkType;
    link = json.link;
    image = json.image;
    creationDate = json.creationDate;
    sTypename = json.sTypename;
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

NotificationCountVM notificationCountVMFromJson(dynamic str) =>
    (NotificationCountVM.fromJson(str));

class NotificationCountVM {
  late final int? count;
  late final String? sTypename;

  NotificationCountVM({required this.count, required this.sTypename});

  NotificationCountVM.fromJson(dynamic json) {
    count = json.count;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;

    return data;
  }
}
