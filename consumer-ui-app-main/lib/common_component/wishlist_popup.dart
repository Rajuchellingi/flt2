// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/wishlist_popup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistPopup extends StatefulWidget {
  final dynamic product;
  final String productId;

  const WishlistPopup(
      {Key? key, required this.product, required this.productId})
      : super(key: key);

  @override
  _WishlistPopupState createState() => _WishlistPopupState();
}

class _WishlistPopupState extends State<WishlistPopup> {
  final _controller = Get.find<WishlistPopupController>();

  @override
  void initState() {
    super.initState();
    _controller.assignSelectedCollections(widget.product.wishlistCollection);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Manage Item',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ])),
            const Divider(),
            Expanded(
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            width: SizeConfig.screenWidth,
                            child: GestureDetector(
                                onTap: () {
                                  _controller.openCreateNewCollection();
                                },
                                child: Row(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              style: BorderStyle.solid)),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(Icons.add,
                                          color: kPrimaryColor)),
                                  const SizedBox(width: 15),
                                  const Text(
                                    'Create a new collection',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                  ),
                                ]))),
                        if (_controller.isCreate.value)
                          _buildCreateNewCollection(),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _controller.wishlistCollection.value
                              .map((filter) {
                            return ListTile(
                              onTap: () {
                                _controller.onChangeCollection(filter.sId);
                              },
                              title: Text(
                                filter.name ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              trailing: Checkbox(
                                activeColor: kPrimaryColor,
                                value: _controller.selectedCollections.value
                                    .contains(filter.sId),
                                onChanged: (bool? value) {
                                  _controller.onChangeCollection(filter.sId);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        // ListTile(
                        //   title: TextButton(
                        //     child: Text('Done'),
                        //     onPressed: () async {
                        //       _controller
                        //           .addProductToWishlist(widget.productId);
                        //     },
                        //   ),
                        // ),
                      ],
                    ))),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 1.5, color: Colors.grey.shade300))),
                child: ListTile(
                  title: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text('Done',
                        style: const TextStyle(color: kSecondaryColor)),
                    onPressed: () async {
                      _controller.addProductToWishlist(widget.productId);
                    },
                  ),
                )),
          ])),
    );
  }

  Widget _buildCreateNewCollection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Collection Name',
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              labelStyle: const TextStyle(fontSize: 10.5),
            ),
            keyboardType: TextInputType.text,
            controller: _controller.collectionNameController,
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              _controller.createWishlistCollection();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            ),
            child: const Text('Create',
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
