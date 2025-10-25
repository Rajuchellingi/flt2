// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/common_component/image_viewer.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailImageDesign5 extends StatelessWidget {
  ProductDetailImageDesign5(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();

  final design;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value &&
              _controller.productPackImage.length == 0
          ? Container()
          : Stack(children: [
              Container(
                  padding: EdgeInsets.all(10),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: new ProductDetailImageViewer(
                      controller: _controller,
                      design: design,
                      press: (data) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImageViewer(
                              imageIndex: data['index'],
                              gallery: _controller.productPackImage.value,
                            );
                          },
                        );
                      },
                      type: 'product',
                      bannerList: _controller.productPackImage.value
                          as List<ImageSliderVWModel>,
                      autoPlay: false,
                      imageBaseUri: singlePackImageUri,
                      height: SizeConfig.screenHeight * 0.6,
                      borderRadius: 0,
                      // type:_controller.type,
                    ),
                  )),
              Positioned(
                  top: 10,
                  right: 20,
                  child: Column(children: [
                    if (design['source']['show-share'] == true) ...[
                      GestureDetector(
                          onTap: () {
                            _controller.shareImageFromUrl();

                            // Share.share(
                            //     websiteUrl +
                            //         'products/' +
                            //         _controller.product.value.handle.toString(),
                            //     subject: "Take a look at this " +
                            //         _controller.product.value.name.toString());
                          },
                          child: const Icon(Icons.share_outlined)),
                      const SizedBox(height: 10)
                    ],
                  ]))
            ]),
    );
  }
}

class ProductDetailImageViewer extends StatelessWidget {
  final _controller = Get.find<CommonController>();

  ProductDetailImageViewer(
      {Key? key,
      required this.bannerList,
      required this.autoPlay,
      required this.imageBaseUri,
      this.type = 'banner',
      required controller,
      required this.height,
      required this.design,
      this.borderRadius = 10,
      required this.press})
      : _productController = controller,
        super(key: key);

  final List<ImageSliderVWModel> bannerList;
  final bool autoPlay;
  final String imageBaseUri;
  final String type;
  final double height;
  final double borderRadius;
  final Function press;
  final _productController;

  final themeController = Get.find<ThemeController>();
  final design;

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: height - 60,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: autoPlay,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, page) {
                autoPlay
                    ? _controller.imageCarouselPageChanges(index)
                    : _controller.imageSliderPageChanges(index);
              }),
          items: bannerList.asMap().entries.map((entry) {
            var index = entry.key;
            var data = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => press({"data": data, "index": index}),
                  child: Container(
                    //color: i.sortOrder == 1 ? Colors.amber[200] : Colors.black,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImageWidget(
                        // image: imageBaseUri + i.id + '/' + i.imageName,
                        placeholderImage: type == 'product'
                            ? data.imageName + "&width=100"
                            : null,
                        image: type == 'product'
                            ? data.imageName + "&width=500"
                            : data.imageName,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(color: Color(0xFFF0DFBF)),
          child: Row(children: [
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: bannerList.asMap().entries.map((entry) {
                        return GestureDetector(
                            onTap: () => {},
                            child: Obx(() => Container(
                                  width: 20.0,
                                  height: 4.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    color: _controller
                                                .imageSliderCurrentPageIndex ==
                                            entry.key
                                        ? kPrimaryColor
                                        : Colors.white,
                                  ),
                                )));
                      }).toList(),
                    ))),
            if (instance != null &&
                instance['source']['show-wishlist'] == true &&
                design != null &&
                design['source']['show-wishlist'] == true) ...[
              SizedBox(width: 10),
              Obx(() => GestureDetector(
                  onTap: () {
                    _productController.addToWishList(
                        _productController.product.value.sId.toString());
                  },
                  child: (_productController.wishlistFlag.value != null &&
                          _productController.getWishListonClick(
                              _productController.product.value))
                      ? const Icon(
                          Icons.favorite_sharp,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border_sharp,
                          color: kPrimaryColor))),
            ]
          ]),
        ),
      ],
    );
  }
}
