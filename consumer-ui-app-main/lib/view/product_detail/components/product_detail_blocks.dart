// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_add_to_cart_button.dart';
import 'package:black_locust/view/product_detail/components/product_add_to_catalog_dwnld_button.dart';
import 'package:black_locust/view/product_detail/components/product_add_to_image_dwnld_button.dart';
import 'package:black_locust/view/product_detail/components/product_custom_variant.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image.dart';
import 'package:black_locust/view/product_detail/components/product_detail_price.dart';
import 'package:black_locust/view/product_detail/components/product_detail_quantity_update.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products.dart';
import 'package:black_locust/view/product_detail/components/product_detail_rich_text.dart';
import 'package:black_locust/view/product_detail/components/product_detail_size_chart.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant.dart';
import 'package:black_locust/view/product_detail/components/product_enquiry_buttonV1.dart';
import 'package:black_locust/view/product_detail/components/product_image_banner.dart';
import 'package:black_locust/view/product_detail/components/product_meta_fields.dart';
import 'package:black_locust/view/product_detail/components/product_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailBlocks extends StatelessWidget {
  ProductDetailBlocks({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();
  final _orderSettingController = Get.find<OrderSettingController>();

  @override
  Widget build(BuildContext context) {
    var blocks = _controller.template.value['layout']['blocks'];
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;
    var buttonDesigns = ['design1', 'design4'];
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Obx(
        () => _controller.isLoading.value
            ? Container(
                child: const Center(
                child: const CircularProgressIndicator(color: kPrimaryColor),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < blocks.length; i++) ...[
                    buildProductBlock(blocks, i)
                  ],
                  if (footer != null && footer.isNotEmpty)
                    if ((themeController.bottomBarType.value == 'design1' &&
                            footer['componentId'] == 'footer-navigation') ||
                        (footer['componentId'] == 'add-to-cart-bar' &&
                            buttonDesigns.contains(footer['instanceId'])))
                      const SizedBox(height: 80),
                ],
              ),
      ),
    );
  }

  Widget buildProductBlock(blocks, int index) {
    final design = blocks[index];
    final componentId = design['componentId'];
    final isVisible = design['visibility']['hide'] == false;

    if (!isVisible) return const SizedBox.shrink();

    switch (componentId) {
      case 'product-image':
        return ProductDetailImage(controller: _controller, design: design);
      case 'product-title':
        return ProductDetailTitle(controller: _controller, design: design);
      case 'product-price':
        return ProductDetailPrice(controller: _controller, design: design);
      case 'varaint-selector':
        return ProductDetailVariant(controller: _controller, design: design);
      case 'size-chart':
        if (_controller.isSizeChart.value) {
          return ProductDetailSizeChart(
              controller: _controller, design: design);
        }
        break;
      case 'quantity-selector':
        return ProductDetailQuantityUpdate(
            controller: _controller, design: design);
      case 'product-description':
        return ProductDetailDescription(
            controller: _controller, design: design);
      case 'rich-text-block':
        return ProdcutDetailRichText(design: design);
      case 'add-to-cart-button':
        return ProductAddToCartButton(controller: _controller, design: design);
      case 'catalog-download-block':
        return ProductAddToCatalogButton(
            controller: _controller, design: design);
      case 'image-download-block':
        return ProductImageDownloadButton(
            controller: _controller, design: design);
      case 'enquiry-button':
        if (_orderSettingController.orderSetting.value.orderType == 'enquiry') {
          return ProductEnquiryButtonV1(
              controller: _controller, design: design);
        }
        break;
      case 'image-banner-block':
        return ProductImageBanner(design: design);
      case 'meta-field-block':
        return ProductMetaFields(design: design, controller: _controller);
      case 'custom-variant':
        return ProductCustomVariant(design: design, controller: _controller);
      case 'review':
        if (_controller.isReview.value) {
          return ProductReview(design: design, controller: _controller);
        }
        break;
      case 'related-products':
        if (_controller.relatedProduct.value.isNotEmpty ||
            _controller.relatedProducts.value.isNotEmpty) {
          final products = _controller.relatedProduct.value.isNotEmpty
              ? _controller.relatedProduct.value
              : _controller.relatedProducts.value;
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProductDetailRelatedProducts(
                controller: _controller,
                design: design,
                products: products,
              ));
        }
        break;
      case 'recently-viewed-products':
        if (_controller.recentlyView.value.isNotEmpty) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProductDetailRelatedProducts(
                controller: _controller,
                design: design,
                products: _controller.recentlyView.value,
              ));
        }
        break;
      case 'product-collection':
        if (_controller.productCollection.value.isNotEmpty &&
            _controller.productCollection.value[index].length > 0) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProductDetailRelatedProducts(
                controller: _controller,
                design: design,
                products: _controller.productCollection.value[index],
              ));
        }
        break;
    }

    return const SizedBox.shrink();
  }
}
