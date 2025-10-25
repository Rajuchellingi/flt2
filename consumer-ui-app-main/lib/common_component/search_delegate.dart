// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:async';

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/view/search/components/search_suggestions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/predictive_search_controller.dart';

class SearchDelegateWidget extends SearchDelegate<String> {
  final _controller = Get.find<PredictiveSearchController>();
  Timer? _timer;
  String pageName;

  SearchDelegateWidget(this.pageName) {
    pageName = this.pageName;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.mic),
        onPressed: () {
          _controller.openVoiceSearch(context, pageName);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => SpeechSampleApp()));
        },
      ),
      // IconButton(
      //   icon: Icon(Icons.clear),
      //   onPressed: () {
      //     query = '';
      //   },
      // ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  String? _validateQuery(String value) {
    if (value.isEmpty) return null;

    final continuousSpecialCharRegex =
        RegExp(r'[!@#\$%^&*()_+{}\[\]:;"\<>,.?/~`\\|=-]{3,}');

    if (continuousSpecialCharRegex.hasMatch(value)) {
      return 'Do not use 3 or more continuous special characters';
    }
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final error = _validateQuery(query);

    if (error != null) {
      return Text(error,
          textAlign: TextAlign.center, style: TextStyle(color: Colors.red));
    }

    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), () {
      _controller.submitSearch(context, query, pageName);
    });
    return ListView.builder(
      itemCount: _controller.suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CachedNetworkImage(
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            imageUrl: _controller.suggestions[index].imageUrl != null
                ? platform == 'shopify'
                    ? '${_controller.suggestions[index].imageUrl}&width=100'
                    : _controller.suggestions[index].imageUrl.toString()
                : '',
          ),
          title: Text(_controller.suggestions[index].title),
          onTap: () {
            print('final search');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final error = _validateQuery(query);

    if (error != null) {
      return Text(error,
          textAlign: TextAlign.center, style: TextStyle(color: Colors.red));
    }
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      _controller.getSearchSuggestions(query);
    });

    return Obx(() => (query != null && query.isNotEmpty)
        ? Column(children: [
            if (platform == 'shopify') ...[
              if (_controller.isLoading.value == true &&
                  _controller.suggestions.length == 0)
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Text("Searching.....",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ))),
              if (query != null &&
                  query.isNotEmpty &&
                  _controller.isNoData.value == true &&
                  _controller.isLoading.value == false)
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Text("No results found",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )))
            ],
            Expanded(
                child: ListView.builder(
              itemCount: _controller.suggestions.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  ListTile(
                    leading: _controller.suggestions[index].imageUrl != null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            imageUrl: _controller.suggestions[index].imageUrl !=
                                    null
                                ? platform == 'shopify'
                                    ? '${_controller.suggestions[index].imageUrl}&width=100'
                                    : _controller.suggestions[index].imageUrl
                                        .toString()
                                : '',
                          )
                        : Container(
                            width: 50,
                            height: 50,
                          ),
                    title: Text(_controller.suggestions[index].title),
                    onTap: () async {
                      await Get.toNamed('/productDetail',
                          preventDuplicates: false,
                          arguments: _controller.suggestions[index]);
                      // query = _controller.suggestions[index].title;
                      // // _controller.submitSearch(context, query);
                      // showResults(context);
                    },
                  ),
                  const Divider()
                ]);
              },
            ))
          ])
        : SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_controller.template != null &&
                          _controller.template['layout'] != null) ...[
                        for (var element in _controller.template['layout']
                            ['blocks']) ...[
                          if (element['componentId'] == 'recent-searches' &&
                              element['visibility']['hide'] == false &&
                              _controller.searchQuery.value != null &&
                              _controller.searchQuery.value.length > 0) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("RECENT SEARCHES",
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var element
                                            in _controller.searchQuery.value)
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              child: InkWell(
                                                  onTap: () {
                                                    _controller.submitSearch(
                                                        context,
                                                        element,
                                                        pageName);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                          )),
                                                      child: Row(children: [
                                                        const Icon(
                                                          Icons.history,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                            width: 7),
                                                        Text(element)
                                                      ]))))
                                      ],
                                    ))
                              ],
                            ),
                            const SizedBox(height: 30)
                          ],
                          if (element['componentId'] == 'popular-searches' &&
                              element['visibility']['hide'] == false &&
                              _controller.searchSetting.value != null &&
                              _controller.searchSetting.value.popularSearches !=
                                  null &&
                              _controller.searchSetting.value.popularSearches!
                                      .length >
                                  0) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("POPULAR SEARCHES",
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var element in _controller
                                            .searchSetting
                                            .value
                                            .popularSearches!)
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              child: InkWell(
                                                  onTap: () {
                                                    _controller.submitSearch(
                                                        context,
                                                        element.title,
                                                        pageName);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                          )),
                                                      child: Text(element.title
                                                          .toString()))))
                                      ],
                                    ))
                              ],
                            ),
                            const SizedBox(height: 30)
                          ],
                          if (element['componentId'] == 'related-products' &&
                              element['visibility']['hide'] == false &&
                              _controller.collectionProduct.value != null &&
                              _controller.collectionProduct.value.length > 0)
                            SearchSuggestions(
                                design: element,
                                controller: _controller,
                                title: _controller.searchSetting.value
                                    .recommendedProducts!.title,
                                products: _controller.collectionProduct.value)
                        ],
                      ]
                    ]))));
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final brightness = Theme.of(context).brightness;
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor:
              brightness == Brightness.dark ? Colors.white : Colors.black),
    );
  }
}
