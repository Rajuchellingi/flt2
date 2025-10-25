ReviewProductVM reviewProductVMFromJson(dynamic str) =>
    (ReviewProductVM.fromJson(str));

class ReviewProductVM {
  late final int? sId;
  late final String? handle;
  late final int? externalId;
  late final String? title;

  ReviewProductVM(
      {required this.sId,
      required this.handle,
      required this.externalId,
      required this.title});

  ReviewProductVM.fromJson(dynamic json) {
    sId = json.sId;
    handle = json.handle;
    externalId = json.externalId;
    title = json.title;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['handle'] = this.handle;
    data['external_id'] = this.externalId;
    data['title'] = this.title;
    return data;
  }
}

ReviewDataVM reviewDataVMFromJson(dynamic str) => ReviewDataVM.fromJson(str);

class ReviewDataVM {
  late final int? currentPage;
  late final int? perPage;
  late final List<ReviewVM> reviews;

  ReviewDataVM({
    required this.currentPage,
    required this.perPage,
    required this.reviews,
  });

  ReviewDataVM.fromJson(dynamic json) {
    currentPage = json.currentPage;
    perPage = json.perPage;
    reviews =
        List<ReviewVM>.from(json.reviews.map((x) => ReviewVM.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['reviews'] = reviews.map((x) => x.toJson()).toList();
    return data;
  }
}

class ReviewVM {
  late final int? id;
  late final String? title;
  late final String? body;
  late final int? rating;
  late final int? externalId;
  late final String? name;
  late final bool? published;
  late final String? createdAt;
  late final String? updatedAt;

  ReviewVM({
    required this.id,
    required this.title,
    required this.body,
    required this.externalId,
    required this.rating,
    required this.name,
    required this.published,
    required this.createdAt,
    required this.updatedAt,
  });

  ReviewVM.fromJson(dynamic json) {
    id = json.id;
    title = json.title;
    body = json.body;
    rating = json.rating;
    name = json.name;
    published = json.published;
    externalId = json.externalId;
    createdAt = json.createdAt;
    updatedAt = json.updatedAt;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['rating'] = rating;
    data['name'] = name;
    data['externalId'] = externalId;
    data['published'] = published;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

NectorProductReviewVM nectorProductReviewVMFromJson(dynamic str) =>
    (NectorProductReviewVM.fromJson(str));

class NectorProductReviewVM {
  late final int? count;
  late final int? sum;

  NectorProductReviewVM({
    required this.count,
    required this.sum,
  });

  NectorProductReviewVM.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['sum'] = this.sum;
    return data;
  }
}
