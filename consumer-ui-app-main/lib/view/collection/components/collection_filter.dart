import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/view/collection/components/collection_attribute_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_locust/const/constant.dart';

class CollectionFilter extends StatefulWidget {
  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<CollectionFilter> {
  final _controller = Get.find<CollectionFilterController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              })
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading.value
              ? const Center(child: const CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _controller.filterAttribute.length + 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 2),
                      child: _controller.filterAttribute.length >= (index + 1)
                          ? CollectionAttributeFilter(
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
        color: isDarkMode ? Colors.black : Colors.white,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {
                _controller.resetAll();
                setState(() {});
              },
              child: Text(
                'Reset',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : kPrimaryColor),
              ),
            ),
            Container(
              width: 1,
              height: 25,
              color: Colors.grey,
            ),
            TextButton(
              onPressed: () {
                _controller.applyClick();
              },
              child: Text(
                'Apply',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
