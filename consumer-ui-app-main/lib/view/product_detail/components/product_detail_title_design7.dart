// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/collection_model.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign7 extends StatelessWidget {
  ProductDetailTitleDesign7(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    var productDetailData = _controller.product.value;
    var productDetaiCatalog = productDetailData.productCatalog!;
    final productSetting = productSettingController.productSetting.value;
    print("productDetailData---------->>>>> ${productDetailData.toJson()}");
    print(
        "template.value ----------->>>>>> ${_controller.template.value.toString()}");
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: SizeConfig.screenWidth * 0.80,
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.product.value.name.toString(),
                                  style: TextStyle(
                                      color: themeController.defaultStyle(
                                          'color', design['style']['color']),
                                      fontWeight: themeController.defaultStyle(
                                          'fontWeight',
                                          design['style']['fontWeight']),
                                      fontSize: themeController.defaultStyle(
                                          'fontSize',
                                          design['style']['fontSize'])),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    if (_controller.product.value.showPrice ==
                                        true) ...[
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          if (productSetting.priceDisplayType ==
                                              'mrp') ...[
                                            Text(
                                              "MRP " +
                                                  _controller.product.value
                                                      .currencySymbol +
                                                  _controller
                                                      .product.value.price!.mrp
                                                      .toString() +
                                                  (_controller.product.value
                                                                  .type ==
                                                              "pack" ||
                                                          _controller.product
                                                                  .value.type ==
                                                              "set"
                                                      ? " / Piece"
                                                      : ""),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            )
                                          ] else ...[
                                            Text(
                                                _controller.product.value
                                                        .currencySymbol +
                                                    _controller.product.value
                                                        .price!.sellingPrice
                                                        .toString() +
                                                    (_controller.product.value
                                                                    .type ==
                                                                "pack" ||
                                                            _controller
                                                                    .product
                                                                    .value
                                                                    .type ==
                                                                "set"
                                                        ? " / Piece"
                                                        : ""),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15))
                                          ],
                                          SizedBox(width: 5),
                                          if (productSetting.priceDisplayType ==
                                                  'mrp-and-selling-price' &&
                                              _controller.product.value.type !=
                                                  "pack" &&
                                              _controller.product.value.type !=
                                                  "set") ...[
                                            const Text(
                                              'MRP: ',
                                              style:
                                                  const TextStyle(fontSize: 11),
                                            ),
                                            Text(
                                              _controller.product.value
                                                      .currencySymbol +
                                                  _controller
                                                      .product.value.price!.mrp
                                                      .toString(),
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                          if (_controller.product.value.offer !=
                                              null) ...[
                                            const SizedBox(width: 8),
                                            Text(
                                              (_controller.product.value
                                                              .offer !=
                                                          null &&
                                                      _controller.product.value
                                                              .offer! >
                                                          0)
                                                  ? '${_controller.product.value.offer} % Off'
                                                  : '',
                                              style: headingStyle.copyWith(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ],
                                      )
                                    ]
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (_controller.product.value.type == "pack" ||
                                    _controller.product.value.type ==
                                        "set") ...[
                                  Row(
                                    children: [
                                      Text(
                                        'Minimum Order: ${_controller.product.value.moq?.toString() ?? ''} ${_controller.product.value.type == 'pack' && _controller.product.value.isCustomizable == true ? 'Pieces' : _controller.product.value.type == 'pack' && _controller.product.value.isCustomizable == false ? 'Pack' : _controller.product.value.type == 'set' && _controller.product.value.isCustomizable == false ? 'Set' : _controller.product.value.type == 'set' && _controller.product.value.isCustomizable == true ? 'Pieces' : ''}',
                                        // style: headingStyle.copyWith(
                                        //   fontWeight: FontWeight.w800,
                                        //   fontSize: 13.0,
                                        // ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_controller.product.value.showWishlist == true)
                        InkWell(
                          onTap: () {
                            _controller.addToWishList(
                                _controller.product.value.sId,
                                _controller.product.value);
                          },
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                _controller.product.value.isWishlist == true
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border_outlined,
                                color:
                                    _controller.product.value.isWishlist == true
                                        ? Colors.red
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      // SizedBox(width: 10),
                      // InkWell(
                      //   onTap: () {
                      //     _controller.shareImageFromUrl();
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white.withOpacity(0.5),
                      //       borderRadius: BorderRadius.circular(50),
                      //     ),
                      //     child: Icon(
                      //       Icons.share_outlined,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 10),
                      // if (_controller.product.value.showDownloadCatalog ==
                      //         true &&
                      //     (_controller.product.value.catalogUrl != null ||
                      //         _controller.product.value.productCatalog != null))
                      //   InkWell(
                      //     onTap: () {
                      //       _controller.downloadCatalog();
                      //     },
                      //     child: Container(
                      //       padding: const EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white.withOpacity(0.5),
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //       child: Icon(
                      //         Icons.download,
                      //       ),
                      //     ),
                      //   ),
                      if (productDetailData.showDownloadCatalog == true) ...[
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 15, 5),
                          alignment: Alignment.centerRight,
                          child: productDetaiCatalog.length == 1
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    var file = productDetaiCatalog.first;
                                    _controller.downloadCatalog(
                                        file.fileName, file.fileUrl);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : PopupMenuButton<String>(
                                  icon: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                  ),
                                  color: kPrimaryColor,
                                  onSelected: (selectedName) {
                                    var selectedItem =
                                        productDetaiCatalog.firstWhere(
                                      (item) => item.name == selectedName,
                                      orElse: () => CatalogFileVM(
                                        name: '',
                                        fileName: '',
                                        fileUrl: '',
                                        fileType: '',
                                        sId: '',
                                      ),
                                    );
                                    if (selectedItem.name.isNotEmpty) {
                                      _controller.selectedCatalog.value =
                                          selectedItem.name;
                                      _controller.downloadCatalog(
                                          selectedItem.fileName,
                                          selectedItem.fileUrl);
                                    }
                                  },
                                  itemBuilder: (context) => productDetaiCatalog
                                      .map<PopupMenuItem<String>>(
                                          (item) => PopupMenuItem<String>(
                                                value: item.name,
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ))
                                      .toList(),
                                ),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
