ReviewProduct reviewProductFromJson(dynamic str) =>
    (ReviewProduct.fromJson(str));

class ReviewProduct {
  late final int? sId;
  late final String? handle;
  late final int? externalId;
  late final String? title;

  ReviewProduct(
      {required this.sId,
      required this.handle,
      required this.externalId,
      required this.title});

  ReviewProduct.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    handle = json['handle'];
    externalId = json['external_id'];
    title = json['title'];
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

ReviewData reviewDataFromJson(dynamic str) => ReviewData.fromJson(str);

class ReviewData {
  late final int? currentPage;
  late final int? perPage;
  late final List<Review> reviews;

  ReviewData({
    required this.currentPage,
    required this.perPage,
    required this.reviews,
  });

  ReviewData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    reviews = List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['reviews'] = reviews.map((x) => x.toJson()).toList();
    return data;
  }
}

class Review {
  late final int? id;
  late final int? externalId;
  late final String? title;
  late final String? body;
  late final int? rating;
  late final String? name;
  late final bool? published;
  late final String? createdAt;
  late final String? updatedAt;

  Review({
    required this.id,
    required this.externalId,
    required this.title,
    required this.body,
    required this.rating,
    required this.name,
    required this.published,
    required this.createdAt,
    required this.updatedAt,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    externalId = json['product_external_id'];
    title = json['title'];
    body = json['body'];
    rating = json['rating'];
    name = json['reviewer']['name'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['rating'] = rating;
    data['externalId'] = externalId;
    data['name'] = name;
    data['published'] = published;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

NectorProductReview nectorProductReviewFromJson(dynamic str) =>
    (NectorProductReview.fromJson(str));

class NectorProductReview {
  late final int? count;
  late final int? sum;

  NectorProductReview({
    required this.count,
    required this.sum,
  });

  NectorProductReview.fromJson(Map<String, dynamic> json) {
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
