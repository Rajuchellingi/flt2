// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/home/components/announcement_bar.dart';
import 'package:black_locust/view/home/components/banner_with_background.dart';
import 'package:black_locust/view/home/components/banner_with_button.dart';
import 'package:black_locust/view/home/components/card_banner.dart';
import 'package:black_locust/view/home/components/carousel_banner.dart';
import 'package:black_locust/view/home/components/carousel_promotion.dart';
import 'package:black_locust/view/home/components/carousel_video_banner.dart';
import 'package:black_locust/view/home/components/custom_banner.dart';
import 'package:black_locust/view/home/components/customer_review.dart';
import 'package:black_locust/view/home/components/explainer_banner.dart';
import 'package:black_locust/view/home/components/faq_list.dart';
import 'package:black_locust/view/home/components/fixed_banner.dart';
import 'package:black_locust/view/home/components/fixed_promotion.dart';
import 'package:black_locust/view/home/components/form_Component.dart';
import 'package:black_locust/view/home/components/grid_carousel_promotion.dart';
import 'package:black_locust/view/home/components/icon_info.dart';
import 'package:black_locust/view/home/components/media_tab_scroller.dart';
import 'package:black_locust/view/home/components/sliding_banner.dart';
import 'package:black_locust/view/home/components/testimonial_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'banner_with_text.dart';

class HomeBlocks extends StatelessWidget {
  const HomeBlocks({Key? key, required dynamic controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller.scrollController,
      child: Obx(() {
        final blocks = _controller.homeBlocks.value;
        final footer = _controller.template.value['layout']?['footer'];
        final hasFooter = footer != null &&
            footer['instanceId'] == 'design1' &&
            !footer['visibility']['hide'] &&
            blocks.length > 1;
        final isLoading = _controller.isLoadData.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildBlocks(blocks),
            if (hasFooter) const SizedBox(height: 80),
            if (isLoading)
              const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor)),
          ],
        );
      }),
    );
  }

  List<Widget> _buildBlocks(List<dynamic> blocks) {
    return blocks
        .where((design) => !design['visibility']['hide'])
        .map((design) {
      final componentId = design['componentId'];
      if (componentId == 'sliding-banner-component') {
        return SlidingBanner(controller: _controller, design: design);
      }

      if (componentId == 'carousel-banner-component') {
        return CarouselBanner(controller: _controller, design: design);
      }

      if (componentId == 'fixed-banner-component') {
        return FixedBanner(controller: _controller, design: design);
      }

      if (componentId == 'fixed-promotion-component') {
        final products = _getPromotionProducts(design);
        if (products.isNotEmpty) {
          return FixedPromotion(controller: _controller, design: design);
        }
      }

      if (componentId == 'carousel-promotion-component') {
        final products = _getPromotionProducts(design);
        if (products.isNotEmpty) {
          return CarouselPromotion(controller: _controller, design: design);
        }
      }

      if (componentId == 'grid-carousel-promotion-component') {
        final products = _getPromotionProducts(design);
        if (products.isNotEmpty) {
          return GridCarouselPromotion(controller: _controller, design: design);
        }
      }

      if (componentId == 'custom-banner-component') {
        return CustomBanner(controller: _controller, design: design);
      }

      if (componentId == 'banner-with-text-component') {
        return BannerWithText(controller: _controller, design: design);
      }

      if (componentId == 'card-banner-component') {
        return CardBanner(controller: _controller, design: design);
      }

      if (componentId == 'icon-info-component') {
        return IconInfo(controller: _controller, design: design);
      }

      if (componentId == 'faq-list-component') {
        return FAQList(controller: _controller, design: design);
      }

      if (componentId == 'media-tab-scroller-component') {
        return MediaTabScroller(controller: _controller, design: design);
      }

      if (componentId == 'carousel-video-banner-component') {
        return CarouselVideoBanner(controller: _controller, design: design);
      }

      if (componentId == 'customer-review-component') {
        return CustomerReview(controller: _controller, design: design);
      }

      if (componentId == 'announcement-bar-component') {
        return AnnouncementBar(controller: _controller, design: design);
      }
      if (componentId == 'explainer-banner-component') {
        return ExplainerBanner(controller: _controller, design: design);
      }
      if (componentId == 'testimonial-component') {
        return TestimonialDesign1(controller: _controller, design: design);
      }
      if (componentId == 'banner-with-background-component') {
        return BannerWithBackground(controller: _controller, design: design);
      }
      if (componentId == 'login-banner-component') {
        return BannerWithButton(controller: _controller, design: design);
      }

      if (componentId == 'form-component') {
        return FormComponent(controller: _controller, design: design);
      }

      return const SizedBox.shrink();
    }).toList();
  }

  List<dynamic> _getPromotionProducts(Map<String, dynamic> design) {
    if (_controller.collectionProducts.value.isEmpty) return [];

    final collection = design['source']['collection'];
    final count = design['source']['count'];
    final products = _controller.collectionProducts.value.firstWhere(
        (element) =>
            element['collection'] == collection && element['count'] == count,
        orElse: () => {});

    return products?['products'] ?? [];
  }
}
