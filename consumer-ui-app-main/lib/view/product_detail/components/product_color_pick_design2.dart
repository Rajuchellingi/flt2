// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductColorPickDesign2 extends StatelessWidget {
  const ProductColorPickDesign2({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      print(
          '_controller.attributeFieldValues ${_controller.attributeFieldValues}');
      int totalQuantity = _controller.calculateTotalQuantity();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 15.0),
            child: Text(
              'Available ${_controller.product.value.preferenceVariant.attributeLabelName}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          ..._controller.attributeFieldValues.map((field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                  decoration: BoxDecoration(
                    color: brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 219, 216, 216),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color Header
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${field['color']}",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (field['colorCode'] != null)
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(field['colorCode']
                                      .replaceFirst('#', '0xFF'))),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 154, 148, 148),
                                    width: 1,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Customizable Sizes
                      if (field['isCustomizable'] == true)
                        Wrap(
                          spacing: 20.0,
                          runSpacing: 10.0,
                          children: List.generate(
                            (field['availableSize'] as List).length,
                            (sizeIndex) {
                              var sizeInfo = field['availableSize'][sizeIndex];
                              String size = sizeInfo['size'];
                              String colorCode =
                                  sizeInfo['colorCode'] ?? '#FFFFFF';
                              String sellingPrice =
                                  productSetting.priceDisplayType == 'mrp'
                                      ? sizeInfo['mrp'].toString()
                                      : sizeInfo['sellingPrice'].toString();

                              // Initialize quantity as RxInt
                              RxInt quantity = (field['inputValues'][sizeIndex]
                                          ['value'] as TextEditingController)
                                      .text
                                      .isEmpty
                                  ? 0.obs
                                  : int.parse((field['inputValues'][sizeIndex]
                                                  ['value']
                                              as TextEditingController)
                                          .text)
                                      .obs;

                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2.5,
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.only(
                                    left: 10.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC2B389),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '$size',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(colorCode
                                                .replaceFirst('#', '0xFF'))),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 154, 148, 148),
                                                width: 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Quantity Selector with separate backgrounds
                                    Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Decrease Button
                                            InkWell(
                                              onTap: () {
                                                if (quantity.value > 0) {
                                                  quantity.value--;
                                                  _controller.updateQuantity(
                                                      field['color'],
                                                      size,
                                                      quantity.value
                                                          .toString());
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            // Quantity Display
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Text(
                                                quantity.value.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            // Increase Button
                                            InkWell(
                                              onTap: () {
                                                quantity.value++;
                                                _controller.updateQuantity(
                                                    field['color'],
                                                    size,
                                                    quantity.value.toString());
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    if (productSetting.showVariantPrice ==
                                        true) ...[
                                      const SizedBox(height: 10),
                                      Text(
                                        '${_controller.product.value.currencySymbol}$sellingPrice /Piece',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Total Quantity: $totalQuantity',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      );
    });
  }
}

// // ignore_for_file: deprecated_member_use

// import 'package:black_locust/const/constant.dart';
// import 'package:black_locust/const/size_config.dart';
// import 'package:black_locust/controller/product_setting_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProductColorPickDesign2 extends StatelessWidget {
//   const ProductColorPickDesign2({Key? key, required controller})
//       : _controller = controller,
//         super(key: key);
//   final _controller;
//   @override
//   Widget build(BuildContext context) {
//     final productSettingController = Get.find<ProductSettingController>();
//     final productSetting = productSettingController.productSetting.value;
//     final brightness = Theme.of(context).brightness;

//     print(
//         "_controller.product.value.packVariant ${_controller.product.value.packVariant.map((e) => e.toJson()).toList()}");

//     return Obx(() {
//       int totalQuantity = _controller.calculateTotalQuantity();

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 5.0, top: 15.0),
//             child: const Text(
//               'Available Materials',
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           ..._controller.attributeFieldValues.map((field) {
//             bool isDefault = _controller.attributeFieldValues.first == field;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
//                   decoration: BoxDecoration(
//                     color: brightness == Brightness.dark
//                         ? Colors.black
//                         : Colors.white,
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.circular(5.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(255, 96, 94, 94).withOpacity(0.1),
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         color: Colors.white,
//                         padding: const EdgeInsets.only(
//                             left: 15.0, top: 15.0, right: 15.0, bottom: 15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(left: 5.0),
//                               child: Text(
//                                 "${field['color']}",
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             if (field['colorCode'] != null)
//                               Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 10.0),
//                                 child: Container(
//                                   width: 25.0,
//                                   height: 25.0,
//                                   decoration: BoxDecoration(
//                                     color: field['colorCode'] != null
//                                         ? Color(int.parse(field['colorCode']
//                                             .replaceFirst('#', '0xFF')))
//                                         : Colors.black,
//                                     border: Border.all(
//                                       color: Color.fromARGB(255, 154, 148, 148),
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             // if (!isDefault)
//                             //   Container(
//                             //     margin: const EdgeInsets.only(right: 10.0),
//                             //     child: IconButton(
//                             //       icon: const Icon(Icons.cancel),
//                             //       onPressed: () {
//                             //         _controller.removeColor(field['color']);
//                             //       },
//                             //     ),
//                             //   ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       if (field['isCustomizable'] == true) ...[
//                         Wrap(
//                           spacing: 20.0,
//                           runSpacing: 10.0,
//                           children: List.generate(
//                             (field['availableSize'] as List).length,
//                             (sizeIndex) {
//                               var sizeInfo = field['availableSize'][sizeIndex];
//                               String size = sizeInfo['size'];
//                               String colorCode = sizeInfo['colorCode'] != null
//                                   ? sizeInfo['colorCode']
//                                   : '#FFFFFF';
//                               String totalQuantity =
//                                   sizeInfo['totalQuantity'].toString();
//                               String sellingPrice =
//                                   productSetting.priceDisplayType == 'mrp'
//                                       ? sizeInfo['mrp'].toString()
//                                       : sizeInfo['sellingPrice'].toString();
//                               TextEditingController controller =
//                                   field['inputValues'][sizeIndex]['value'];
//                               bool showQuantity = sizeInfo['trackQuantity'] ==
//                                       true &&
//                                   sizeInfo['continueSellingWhenOutOfStock'] ==
//                                       false;

//                               return Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 40) /
//                                         2.5,
//                                 padding: const EdgeInsets.all(8.0),
//                                 margin: const EdgeInsets.only(
//                                     left: 10.0, bottom: 5.0),
//                                 decoration: BoxDecoration(
//                                   color: Color(
//                                       0xFFC2B389), // gray background for the block
//                                   border: Border.all(
//                                       color: Colors.grey), // gray border
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           // showQuantity
//                                           //     ? '$size ($totalQuantity)':
//                                           '$size',
//                                           style:
//                                               const TextStyle(fontSize: 12.0),
//                                         ),
//                                         const SizedBox(width: 10),
//                                         Container(
//                                           width: 25.0,
//                                           height: 25.0,
//                                           decoration: BoxDecoration(
//                                             color: Color(int.parse(colorCode
//                                                 .replaceFirst('#', '0xFF'))),
//                                             shape: BoxShape.circle,
//                                             border: Border.all(
//                                               color: const Color.fromARGB(
//                                                   255, 154, 148, 148),
//                                               width: 1.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors
//                                             .white, // white background for quantity
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius:
//                                             BorderRadius.circular(5.0),
//                                       ),
//                                       child: TextField(
//                                         controller: controller,
//                                         decoration: const InputDecoration(
//                                           labelText: 'Quantity',
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(
//                                               vertical: 5.0, horizontal: 10.0),
//                                           labelStyle: TextStyle(fontSize: 10.5),
//                                         ),
//                                         keyboardType: TextInputType.number,
//                                         onChanged: (value) {
//                                           _controller.updateQuantity(
//                                               field['color'], size, value);
//                                         },
//                                       ),
//                                     ),
//                                     if (productSetting.showVariantPrice ==
//                                         true) ...[
//                                       const SizedBox(height: 10),
//                                       Text(
//                                         '${_controller.product.value.currencySymbol}$sellingPrice /Piece',
//                                         style: const TextStyle(
//                                           fontSize: 12.0,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 15),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }).toList(),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.only(left: 5.0),
//             child: Text(
//               'Total Quantity: $totalQuantity',
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 13.0,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15),
//         ],
//       );
//     });
//   }
// }
