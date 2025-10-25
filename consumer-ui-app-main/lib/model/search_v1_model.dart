import 'package:black_locust/model/search_model.dart';

SearchProductsV1VM searchProductV1VMFromJson(dynamic str) =>
    (SearchProductsV1VM.fromJson(str.toJson()));

class SearchProductsV1VM {
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  late final List<AttributeListVM> filters;
  late final List<ProductCollectionListVM> products;

  SearchProductsV1VM({
    required this.currentPage,
    required this.totalPages,
    required this.count,
    required this.filters,
    required this.products,
  });

  SearchProductsV1VM.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    count = json['count'];
    if (json['filters'] != null) {
      filters = <AttributeListVM>[];
      json['filters'].forEach((v) {
        if (v != null) {
          filters.add(AttributeListVM.fromJson(v));
        }
      });
    }
    if (json['products'] != null) {
      products = <ProductCollectionListVM>[];
      json['products'].forEach((v) {
        if (v != null) {
          products.add(ProductCollectionListVM.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    data['filters'] = this.filters.map((v) => v.toJson()).toList();
    data['products'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}
