// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:black_locust/view/collection/components/collection_attribute_filter_v2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_locust/const/constant.dart';

class CollectionFilterPopupV1 extends StatefulWidget {
  @override
  _FilterComponentState createState() => _FilterComponentState();
  final _cController;
  const CollectionFilterPopupV1({
    Key? key,
    required controller,
  })  : _cController = controller,
        super(key: key);
}

class _FilterComponentState extends State<CollectionFilterPopupV1> {
  final _controller = Get.find<CollectionFilterV1Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 5,
                      vertical: kDefaultPadding / 5),
                  // child: CollectionAttributeFilterV1(
                  //   controller: widget._cController,
                  //   filterAttribute: _controller.filterAttribute,
                  // ),
                  child: CollectionAttributeFilterV2(
                    controller: widget._cController,
                    filterAttribute: _controller.filterAttribute,
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                _controller.resetAll(widget._cController);
                // setState(() {});
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: kPrimaryColor.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0), // Text color
                side: BorderSide(color: kPrimaryColor.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Clear Filters',
                style: const TextStyle(color: kSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
