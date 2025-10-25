// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/view/collection/components/collection_attribute_filter_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_locust/const/constant.dart';

class CollectionFilterDesign2 extends StatefulWidget {
  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<CollectionFilterDesign2> {
  final _controller = Get.find<CollectionFilterController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        title: Text('Filters',
            style: TextStyle(
                color: brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black)),
        centerTitle: true,
        surfaceTintColor:
            brightness == Brightness.dark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
              : ListView.builder(
                  itemCount: _controller.filterAttribute.length + 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _controller.filterAttribute.length >= (index + 1)
                          ? CollectionAttributeFilterDesign2(
                              controller: _controller,
                              filterAttribute:
                                  _controller.filterAttribute[index],
                            )
                          : Container(),
                    );
                  }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor:
            brightness == Brightness.dark ? Colors.black : kBackground,
        color: brightness == Brightness.dark ? Colors.black : kBackground,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    width: 1.5),
              ),
              onPressed: () {
                _controller.resetAll();
                setState(() {});
              },
              child: Text(
                'Discard',
                style: TextStyle(
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
            )),
            const SizedBox(width: 25),
            Expanded(
                child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => kPrimaryColor)),
              onPressed: () {
                _controller.applyClick();
              },
              child: const Text(
                'Apply',
                style: const TextStyle(color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
