List<RelatedProduct> relatedProductFromJson(dynamic str) =>
    List<RelatedProduct>.from(str.map((x) => RelatedProduct.fromJson(x)));

// RelatedProduct relatedProductFromJson(dynamic str) =>
//     (RelatedProduct.fromJson(str));
List<RelatedProduct> cartCollectionProductFromJson(dynamic str) =>
    List<RelatedProduct>.from(
        str.map((x) => RelatedProduct.fromJson(x['node'])));

class RelatedProduct {
  late final String? sId;
  late final String? productId;
  late final String? name;
  late final String? description;
  late final String? imageId;
  late final String? type;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final Price? price;
  late final List<Images>? images;
  late final List<RelatedProductOptions>? options;
  late final List<RelatedProductVariants>? variants;
  late final List<ProductMetafields>? metafields;
  late final List<ProductImages>? productImages;
  late final String? priceType;
  late final String? vendor;
  late final Ribbon? ribbon;
  late final String? sTypename;

  RelatedProduct(
      {required this.sId,
      required this.productId,
      required this.name,
      required this.description,
      required this.imageId,
      required this.type,
      required this.moq,
      required this.priceType,
      required this.vendor,
      required this.isOutofstock,
      required this.isMultiple,
      required this.price,
      required this.images,
      required this.ribbon,
      required this.options,
      required this.productImages,
      required this.metafields,
      required this.variants,
      required this.sTypename});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    sId = json['id'] ?? null;
    priceType = json['priceType'] ?? null;
    vendor = json['vendor'] ?? null;
    productId = json['productId'] ?? null;
    name = json['title'] ?? null;
    description = json['description'] ?? null;
    imageId = json["featuredImage"] != null
        ? json["featuredImage"]["id"] ?? null
        : null;
    type = json['type'] ?? "product";
    moq = 1;
    isOutofstock = json['availableForSale'] ?? null;
    isMultiple = json['isMultiple'] ?? null;
    price = json['priceRange'] != null ? new Price.fromJson(json) : null;
    ribbon =
        json['ribbon'] != null ? new Ribbon.fromJson(json['ribbon']) : null;
    // if (json['featuredImage'] != null) {
    //   images = <Images>[];
    //   json['featuredImage'].forEach((v) {
    //     images!.add(new Images.fromJson(v));
    //   });
    // }
    if (json['options'] != null) {
      options = <RelatedProductOptions>[];
      json['options'].forEach((v) {
        options!.add(RelatedProductOptions.fromJson(v));
      });
    }
    if (json['variants'] != null && json['variants']['edges'] != null) {
      variants = <RelatedProductVariants>[];
      json['variants']['edges'].forEach((v) {
        variants!.add(RelatedProductVariants.fromJson(v['node']));
      });
    }
    metafields = <ProductMetafields>[];
    if (json['metafields'] != null) {
      var value = json['metafields'].where((element) => element != null);
      value.forEach((v) {
        metafields!.add(ProductMetafields.fromJson(v));
      });
    }
    productImages = <ProductImages>[];
    if (json['images'] != null && json['images']['nodes'] != null) {
      json['images']['nodes'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['featuredImage'] != null) {
      images = <Images>[];
      images!.add(new Images.fromJson(json['featuredImage']));
    } else {
      images = <Images>[];
    }
    sTypename = json['__typename'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['priceType'] = this.priceType;
    data['description'] = this.description;
    data['imageId'] = this.imageId;
    data['type'] = this.type;
    data['vendor'] = this.vendor;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    } else {
      this.images = [];
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['productImages'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductImages {
  late final String? url;
  late final int? height;
  late final int? width;

  ProductImages({required this.url, required this.height, required this.width});
  ProductImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    height = json['height'];
    width = json['width'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}

class ProductMetafields {
  late final String? type;
  late final String? key;
  late final String? namespace;
  late final String? value;

  ProductMetafields({
    required this.value,
    required this.type,
    required this.key,
    required this.namespace,
  });

  ProductMetafields.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    key = json['key'];
    namespace = json['namespace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['key'] = this.key;
    data['namespace'] = this.namespace;
    return data;
  }
}

class Price {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final bool? isSamePrice;
  late final String? sTypename;

  Price(
      {required this.sellingPrice,
      required this.mrp,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  Price.fromJson(Map<String, dynamic> json) {
    var priceRange = json['priceRange'];
    var compareAtPriceRange = json['compareAtPriceRange'];
    sellingPrice = priceRange['maxVariantPrice']['amount'] != null
        ? num.parse(priceRange['maxVariantPrice']['amount'])
        : 0;
    mrp = compareAtPriceRange['maxVariantPrice']['amount'] != null
        ? num.parse(compareAtPriceRange['maxVariantPrice']['amount'])
        : 0;
    discount = json['discount'] != null ? num.parse(json['discount']) : 0;
    minPrice = priceRange['maxVariantPrice']['amount'] != null
        ? num.parse(priceRange['maxVariantPrice']['amount'])
        : 0;
    maxPrice = compareAtPriceRange['maxVariantPrice']['amount'] != null
        ? num.parse(compareAtPriceRange['maxVariantPrice']['amount'])
        : 0;
    type = json['type'] ?? null;
    isSamePrice = json['isSamePrice'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['type'] = this.type;
    data['isSamePrice'] = this.isSamePrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Images {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;
  late final String? link;

  Images(
      {required this.imageName,
      required this.position,
      required this.sTypename,
      this.link});

  Images.fromJson(Map<String, dynamic> json) {
    // imageName = json['imageName'];
    // position = json['position'];
    sTypename = json['__typename'];
    link = json['link'] != null ? json['link'] : "";

    imageName = json['url'];
    position = json['position'] ?? null;
    // attributeFieldId = json['attributeFieldId'];
    // attributeFieldValueId = json['id'];
    // sTypename = json['__typename'];
    // link = json['link'] != null ? json['link'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Ribbon {
  late final String? name;
  late final String? colorCode;

  Ribbon({required this.name, required this.colorCode});
  Ribbon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    colorCode = json['colorCode'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['colorCode'] = this.colorCode;
    return data;
  }
}

class RelatedProductVariants {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  RelatedProductVariants({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  RelatedProductVariants.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    title = json['title'];
    availableForSale = json['availableForSale'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['title'] = this.title;
    data['availableForSale'] = this.availableForSale;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RelatedProductOptions {
  late final String? sId;
  late final String? name;
  late final List<RelatedProductOptionsValue> values;
  late final String? sTypename;

  RelatedProductOptions({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  RelatedProductOptions.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <RelatedProductOptionsValue>[];
      json['values'].forEach((v) {
        var optionValue = {"name": v};
        values.add(RelatedProductOptionsValue.fromJson(optionValue));
      });
    }
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['values'] = this.values.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    data['name'] = this.name;
    return data;
  }
}

class RelatedProductOptionsValue {
  late final String? name;

  RelatedProductOptionsValue({
    required this.name,
  });

  RelatedProductOptionsValue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
