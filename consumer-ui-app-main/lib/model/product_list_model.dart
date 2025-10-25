import 'package:get/get.dart';

class Product {
  String name;
  String image;
  String price;
  var quantity = 0.obs;
  var size = "".obs;

  Product(this.name, this.image, this.price, this.quantity, this.size);

  Product.fromGetterJson(dynamic json)
      : name = json["name"] != null ? json["name"] : json.name,
        image = json["image"] != null ? json["image"] : json.image,
        price = json["price"] != null ? json["price"] : json.price,
        quantity = json["quantity"] != null ? json["quantity"] : json.size,
        size = json["size"] != null ? json["size"] : json.size;

  Product.fromJson(dynamic json)
      : name = json.name,
        image = json.image,
        price = json.price,
        quantity = json.quantity,
        size = json.size;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'size': size
    };
  }
}

List<Product> productListGetterFromJson(dynamic str) =>
    List<Product>.from(str.map((x) => Product.fromGetterJson(x)));

List<Product> productListFromJson(dynamic str) =>
    List<Product>.from(str.map((x) => Product.fromJson(x)));

ProductList productListVMFromJson(dynamic str) => (ProductList.fromJson(str));

class ProductList {
  late final List<ProductDetails>? product;
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  late final String? sTypename;

  ProductList(
      {required this.product,
      required this.currentPage,
      required this.totalPages,
      required this.count,
      required this.sTypename});

  ProductList.fromJson(dynamic json) {
    if (json.product != null) {
      product = <ProductDetails>[];
      json.product.forEach((v) {
        product!.add(new ProductDetails.fromJson(v));
      });
    }
    currentPage = json.currentPage;
    totalPages = json.totalPages;
    count = json.count;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

class ProductDetails {
  late final String? sId;
  late final String? productId;
  late final String? name;
  late final String? description;
  late final String? imageId;
  late final String? type;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final String? priceType;
  late final Price? price;
  late final List<Images>? images;
  late final Ribbon? ribbon;
  late final String? sTypename;

  ProductDetails(
      {required this.sId,
      required this.productId,
      required this.name,
      required this.description,
      required this.imageId,
      required this.priceType,
      required this.type,
      required this.moq,
      required this.ribbon,
      required this.isOutofstock,
      required this.isMultiple,
      required this.price,
      required this.images,
      required this.sTypename});

  ProductDetails.fromJson(dynamic json) {
    sId = json.sId;
    productId = json.productId;
    name = json.name;
    description = json.description;
    imageId = json.imageId;
    type = json.type;
    priceType = json.priceType;
    moq = json.moq;
    isOutofstock = json.isOutofstock == null ? false : json.isOutofstock;
    isMultiple = json.isMultiple;
    price = json.price != null ? new Price.fromJson(json.price) : null;
    ribbon =
        json.ribbon != null ? new Ribbon.fromJson(json.ribbon.toJson()) : null;
    if (json.images != null) {
      images = <Images>[];
      json.images.forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['priceType'] = this.priceType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['sTypename'] = this.sTypename;
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

  Price.fromJson(dynamic json) {
    sellingPrice = json.sellingPrice;
    mrp = json.mrp;
    discount = json.discount;
    minPrice = json.minPrice;
    maxPrice = json.maxPrice;
    type = json.type;
    isSamePrice = json.isSamePrice;
    sTypename = json.sTypename;
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
    data['sTypename'] = this.sTypename;
    return data;
  }
}

class Images {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;

  Images(
      {required this.imageName,
      required this.position,
      required this.sTypename});

  Images.fromJson(dynamic json) {
    imageName = json.imageName;
    position = json.position;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

List<SortSetting> sortSettingFromJson(dynamic str) =>
    List<SortSetting>.from(str.map((x) => SortSetting.fromJson(x)));

class SortSetting {
  late final int? sId;
  late final String? name;
  late final String? sortKey;
  late final bool? reverse;

  SortSetting(
      {required this.sId,
      required this.sortKey,
      required this.name,
      required this.reverse});

  SortSetting.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    sortKey = json['sortKey'];
    reverse = json['reverse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sortKey'] = this.sortKey;
    data['name'] = this.name;
    data['reverse'] = this.reverse;
    return data;
  }
}
