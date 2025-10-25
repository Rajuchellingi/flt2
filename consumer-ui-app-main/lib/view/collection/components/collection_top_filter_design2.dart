import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionTopFilterDesign2 extends StatelessWidget {
  const CollectionTopFilterDesign2({
    Key? key,
    required controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;

  @override
  Widget build(BuildContext context) {
    var header = _controller.template.value['layout']['header'];
    var brightness = Theme.of(Get.context!).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: brightness == Brightness.dark ? Colors.black : Colors.white,
      child: Container(
          color: brightness == Brightness.dark
              ? Colors.black
              : Color.fromARGB(255, 244, 244, 244),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.openFilter('design2');
                    },
                    child: Container(
                        child: Row(children: [
                      const Icon(Icons.filter_list_sharp),
                      const SizedBox(width: 5),
                      const Text('Filters', style: TextStyle(fontSize: 13))
                    ]))),
                GestureDetector(
                    onTap: () {
                      _controller.openSortDesign2();
                    },
                    child: Container(
                        child: Row(children: [
                      const Icon(Icons.import_export_rounded),
                      const SizedBox(width: 5),
                      Text(_controller.selectedSort.value.name,
                          style: const TextStyle(fontSize: 13))
                    ]))),
                if (header['source']['show-multi-view'] == true &&
                    design['source']['show-multi-view-icon'] == true)
                  Container(
                      width: 25,
                      height: 25,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.apps),
                        padding: EdgeInsets.zero,
                        color: brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        surfaceTintColor: brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        constraints: BoxConstraints(),
                        onSelected: (value) {},
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                                value: 'choice',
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _controller.changeViewType('default');
                                          Get.back();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: _controller
                                                            .viewType.value ==
                                                        'default'
                                                    ? Colors.grey[300]
                                                    : null,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                            child: const Icon(
                                                Icons.grid_view_outlined))),
                                    InkWell(
                                        onTap: () {
                                          _controller.changeViewType('large');
                                          Get.back();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: _controller
                                                            .viewType.value ==
                                                        'large'
                                                    ? Colors.grey[300]
                                                    : null,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                            child: const Icon(
                                                Icons.view_stream_outlined)))
                                  ],
                                )),
                            PopupMenuItem<String>(
                                value: 'choice',
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _controller.changeViewType('medium');
                                          Get.back();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: _controller
                                                            .viewType.value ==
                                                        'medium'
                                                    ? Colors.grey[300]
                                                    : null,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                            child: const Icon(Icons
                                                .view_compact_alt_outlined))),
                                    InkWell(
                                        onTap: () {
                                          _controller.changeViewType('small');
                                          Get.back();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: _controller
                                                            .viewType.value ==
                                                        'small'
                                                    ? Colors.grey[300]
                                                    : null,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                            child:
                                                const Icon(Icons.view_compact)))
                                  ],
                                ))
                          ];
                        },
                      ))
              ])),
    );
  }
}
