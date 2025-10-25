import 'package:black_locust/config/configConstant.dart';

List<RelatedProduct> relatedProductFromJson(dynamic str) =>
    List<RelatedProduct>.from(
        str.map((x) => RelatedProduct.fromJson(x.toJson())));

List<RelatedProduct> cartCollectionProductVMFromJson(dynamic str) =>
    List<RelatedProduct>.from(
        str.map((x) => RelatedProduct.fromJson(x.toJson())));
// RelatedProduct relatedProductFromJson(dynamic str) =>
//     (RelatedProduct.fromJson(str));

class RelatedProduct {
  late final String? sId;
  late final String? productId;
  late final String? name;
  late final String? description;
  late final String? imageId;
  late final String? type;
  late final String? vendor;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final Price? price;
  late final List<Images>? images;
  late final List<RelatedProductOptionsVM>? options;
  late final List<RelatedProductVariantsVM>? variants;
  late final List<ProductMetafieldsVM>? metafields;
  late final List<ProductImagesVM>? productImages;
  late final String? priceType;
  late final Ribbon? ribbon;
  late final String? sTypename;

  RelatedProduct(
      {required this.sId,
      required this.productId,
      required this.name,
      required this.description,
      required this.imageId,
      required this.type,
      required this.variants,
      required this.options,
      required this.moq,
      required this.vendor,
      required this.priceType,
      required this.isOutofstock,
      required this.isMultiple,
      required this.price,
      required this.productImages,
      required this.metafields,
      required this.images,
      required this.ribbon,
      required this.sTypename});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    priceType = json['priceType'];
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    imageId = json['imageId'];
    type = json['type'];
    moq = json['moq'];
    vendor = json['vendor'];
    isOutofstock = json['isOutofstock'];
    isMultiple = json['isMultiple'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    ribbon =
        json['ribbon'] != null ? new Ribbon.fromJson(json['ribbon']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    } else {
      images = <Images>[];
    }
    if (json['options'] != null) {
      options = <RelatedProductOptionsVM>[];
      json['options'].forEach((v) {
        options!.add(new RelatedProductOptionsVM.fromJson(v));
      });
    }
    metafields = <ProductMetafieldsVM>[];
    if (json['metafields'] != null) {
      json['metafields'].forEach((v) {
        metafields!.add(new ProductMetafieldsVM.fromJson(v));
      });
    }
    productImages = <ProductImagesVM>[];
    if (json['productImages'] != null) {
      json['productImages'].forEach((v) {
        productImages!.add(new ProductImagesVM.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <RelatedProductVariantsVM>[];
      json['variants'].forEach((v) {
        variants!.add(new RelatedProductVariantsVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['priceType'] = this.priceType;
    data['vendor'] = this.vendor;
    data['description'] = this.description;
    data['imageId'] = this.imageId;
    data['type'] = this.type;
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
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['productImages'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductImagesVM {
  late final String? url;
  late final int? height;
  late final int? width;

  ProductImagesVM(
      {required this.url, required this.height, required this.width});
  ProductImagesVM.fromJson(Map<String, dynamic> json) {
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

class ProductMetafieldsVM {
  late final String? type;
  late final String? value;
  late final String? key;
  late final String? namespace;

  ProductMetafieldsVM({
    required this.value,
    required this.type,
    required this.key,
    required this.namespace,
  });

  ProductMetafieldsVM.fromJson(Map<String, dynamic> json) {
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
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    discount = json['discount'] != null
        ? parseToDouble(json['discount'].toString())
        : 0;
    minPrice = json['minPrice'] != null
        ? parseToDouble(json['minPrice'].toString())
        : 0;
    maxPrice = json['maxPrice'] != null
        ? parseToDouble(json['maxPrice'].toString())
        : 0;
    type = json['type'];
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
    imageName = json['imageName'];
    position = json['position'];
    sTypename = json['__typename'];
    link = json['link'] != null ? json['link'] : "";
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

class RelatedProductVariantsVM {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  RelatedProductVariantsVM({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  RelatedProductVariantsVM.fromJson(Map<String, dynamic> json) {
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

class RelatedProductOptionsVM {
  late final String? sId;
  late final String? name;
  late final List<RelatedProductOptionsValueVM> values;
  late final String? sTypename;

  RelatedProductOptionsVM({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  RelatedProductOptionsVM.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <RelatedProductOptionsValueVM>[];
      json['values'].forEach((v) {
        values.add(RelatedProductOptionsValueVM.fromJson(v));
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

class RelatedProductOptionsValueVM {
  late final String? name;

  RelatedProductOptionsValueVM({
    required this.name,
  });

  RelatedProductOptionsValueVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class RelatedProductSizeOptions {
  late final String? name;
  bool? isAvailable;

  RelatedProductSizeOptions({required this.name, required this.isAvailable});

  RelatedProductSizeOptions.fromJson(dynamic json) {
    name = json.name;
    isAvailable = json.isAvailable;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
