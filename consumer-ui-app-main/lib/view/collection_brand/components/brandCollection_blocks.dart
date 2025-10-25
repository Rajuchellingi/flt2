// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/collection/components/collection_menu_design1.dart';
import 'package:black_locust/view/collection/components/collection_menu_design2.dart';
import 'package:black_locust/view/collection/components/collection_sort_design1.dart';
import 'package:black_locust/view/collection/components/collection_top_filter.dart';
import 'package:black_locust/view/collection/components/collection_top_filter_design2.dart';
import 'package:black_locust/view/collection_brand/components/brandCollection_block_design1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandCollectionBlocks extends StatelessWidget {
  BrandCollectionBlocks({Key? key, required this.controller}) : super(key: key);

  final dynamic controller;
  final themeController = Get.find<ThemeController>();
  final f_controller = Get.find<CollectionFilterV1Controller>();

  Widget _buildBannerWidget(List<dynamic> banners, collectionName) {
    if (banners.isEmpty) return const SizedBox.shrink();
    return Column(
      children: banners.map((banner) {
        final imageUrl = controller.changeImageUrl(banner.image, banner.type);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CachedNetworkImage(
            cacheKey: imageUrl,
            imageUrl: '${rietailImageUrl}${banner.imageId}/${banner.image}',
            errorWidget: (_, __, ___) => ErrorImage(),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            placeholder: (_, __) => Container(
              constraints: BoxConstraints(
                minHeight: SizeConfig.screenWidth / 2,
              ),
              child: Center(child: ImagePlaceholder()),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenuComponent(Map<String, dynamic> item) {
    if (item['instanceId'] == 'design1' &&
        item['visibility']['hide'] == false &&
        controller.collectionMenu.value.isNotEmpty) {
      return CollectionMenuDesign1(controller: controller, design: item);
    } else if (item['instanceId'] == 'design2' &&
        item['visibility']['hide'] == false &&
        controller.collectionMenu.value.isNotEmpty) {
      return CollectionMenuDesign2(controller: controller, design: item);
    }
    return const SizedBox.shrink();
  }

  Widget _buildProductListComponent(Map<String, dynamic> item) {
    if (item['visibility']['hide'] == true) {
      return const SizedBox.shrink();
    }

    Widget child;
    switch (item['instanceId']) {
      case 'design1':
        child =
            BrandCollectionBlockDesign7(controller: controller, design: item);
        break;
      default:
        return const SizedBox.shrink();
    }

    return child;
  }

  Widget _buildFilterAndSortComponents(List<Map<String, dynamic>> blocks) {
    final filterItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'product-filter-component' &&
          item['visibility']['hide'] == false,
    );
    final sortItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['visibility']['hide'] == false,
    );

    if ((filterItem != null && filterItem["instanceId"] == "design2") ||
        (sortItem != null && sortItem["instanceId"] == "design2") ||
        (filterItem == null && sortItem == null)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        print('Search: $value');
                      },
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search products...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (filterItem != null && filterItem["instanceId"] == "design1")
            _buildButton('Filters', Icons.filter_list, () {
              controller.openTopFilter(Get.context!, controller);
            }),
          const SizedBox(width: 8),
          if (sortItem != null && sortItem["instanceId"] == "design1")
            _buildButton('Sort By', Icons.filter_list, () {
              controller.showSortBottomSheet(Get.context!);
            }),
        ],
      ),
    );
  }

  Widget _buildFilterAndSortComponents4(List<Map<String, dynamic>> blocks) {
    final filterItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'product-filter-component' &&
          item['visibility']['hide'] == false,
    );
    final sortItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['visibility']['hide'] == false,
    );
    final filters = controller.selectedFilter.value
        .where((element) => element.fieldName != 'sortBy');
    if ((filterItem != null && filterItem["instanceId"] == "design2") ||
        (sortItem != null && sortItem["instanceId"] == "design2") ||
        (filterItem == null && sortItem == null)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sort By button on the left
          if (sortItem != null && sortItem["instanceId"] == "design4")
            _buildButton(
              '${controller.selectedSortValue.value.name}',
              Icons.sort,
              () {
                controller.showSortBottomSheet(Get.context!);
              },
            ),

          // Filters button on the right
          if (filterItem != null && filterItem["instanceId"] == "design4" ||
              filterItem != null && filterItem["instanceId"] == "design5")
            _buildButton(
              'Filters (${filters.length})',
              Icons.filter_list,
              () {
                controller.openTopFilter(Get.context!, controller);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      height: 36,
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black), // 👈 Black border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        icon: Icon(icon, size: 18, color: Colors.black),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildFilterAndSortDesign3(List<Map<String, dynamic>> blocks) {
    final filterItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'product-filter-component' &&
          item['instanceId'] == 'design3' &&
          item['visibility']?['hide'] == false,
    );
    final sortItem = blocks.firstWhereOrNull(
      (item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['instanceId'] == 'design3' &&
          item['visibility']?['hide'] == false,
    );

    if (filterItem == null && sortItem == null) return const SizedBox.shrink();

    return Row(
      children: [
        if (filterItem != null)
          Expanded(
            child: _buildButton('Filters', Icons.filter_list, () {
              controller.openTopFilter(Get.context!, controller);
            }),
          ),
        if (filterItem != null && sortItem != null) const SizedBox(width: 8),
        if (sortItem != null)
          Expanded(
            child: GestureDetector(
              onTap: () => controller.showSortBottomSheet(Get.context!),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      controller.selectedSortValue.value != null
                          ? iconByType(controller.selectedSortValue.value.type)
                          : Icons.sort,
                      size: 18,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Sort By',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData iconByType(dynamic type) {
    switch (type) {
      case 1:
        return Icons.trending_up;
      case 2:
        return Icons.access_time;
      case 3:
        return CupertinoIcons.sort_down;
      case 4:
        return CupertinoIcons.sort_up;
      case 5:
        return CupertinoIcons.sort_down_circle;
      case 6:
        return CupertinoIcons.sort_up_circle;
      default:
        return CupertinoIcons.sort_down;
    }
  }

  Widget _buildFilterComponent(Map<String, dynamic> item) {
    if (item['instanceId'] == 'design1' &&
        item['visibility']['hide'] == false) {
      return CollectionTopFilter(
        controller: controller,
        f_controller: f_controller,
        backgroundColor: Colors.white,
      );
    } else if (item['instanceId'] == 'design2' &&
        item['visibility']['hide'] == false) {
      return CollectionTopFilterDesign2(design: item, controller: controller);
    }
    return const SizedBox.shrink();
  }

  Widget _buildCollectionSortComponent(Map<String, dynamic> item) {
    if (item['instanceId'] == 'design1' &&
        item['visibility']['hide'] == false) {
      return CollectionSortDesign1(controller: controller, design: item);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final blocks = controller.template.value['layout']['blocks'] as List;
      final banners = controller.collectionData.value.collection.banners ?? [];
      final collectionName =
          controller.collectionData.value.collection.collectionName ?? '';
      final typedBlocks = List<Map<String, dynamic>>.from(blocks);

      final hasFilterDesign1 = typedBlocks.any((item) =>
          item['componentId'] == 'product-filter-component' &&
          item['instanceId'] == 'design1' &&
          item['visibility']?['hide'] == false);

      final hasSortDesign1 = typedBlocks.any((item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['instanceId'] == 'design1' &&
          item['visibility']?['hide'] == false);

      final hasFilterDesign3 = typedBlocks.any((item) =>
          item['componentId'] == 'product-filter-component' &&
          item['instanceId'] == 'design3' &&
          item['visibility']?['hide'] == false);

      final hasSortDesign3 = typedBlocks.any((item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['instanceId'] == 'design3' &&
          item['visibility']?['hide'] == false);

      final hasFilterDesign4 = typedBlocks.any((item) =>
          item['componentId'] == 'product-filter-component' &&
          item['instanceId'] == 'design4' &&
          item['visibility']?['hide'] == false);

      final hasSortDesign4 = typedBlocks.any((item) =>
          item['componentId'] == 'collection-sort-component' &&
          item['instanceId'] == 'design4' &&
          item['visibility']?['hide'] == false);
      final hasFilterDesign5 = typedBlocks.any((item) =>
          item['componentId'] == 'product-filter-component' &&
          item['instanceId'] == 'design5' &&
          item['visibility']?['hide'] == false);

      return Scaffold(
        body: Column(
          children: [
            _buildBannerWidget(banners, collectionName),
            if (hasFilterDesign1 && hasSortDesign1)
              _buildFilterAndSortComponents(typedBlocks),
            if (hasFilterDesign4 && hasSortDesign4)
              _buildFilterAndSortComponents4(typedBlocks),
            if (hasFilterDesign5 && hasSortDesign4)
              _buildFilterAndSortComponents4(typedBlocks),
            ...typedBlocks.map((item) {
              if ((hasFilterDesign1 && hasSortDesign1) ||
                  (hasFilterDesign3 && hasSortDesign3)) {
                if ((item['componentId'] == 'product-filter-component' &&
                        item['instanceId'] == 'design1') ||
                    (item['componentId'] == 'collection-sort-component' &&
                        item['instanceId'] == 'design1') ||
                    (item['componentId'] == 'product-filter-component' &&
                        item['instanceId'] == 'design3') ||
                    (item['componentId'] == 'collection-sort-component' &&
                        item['instanceId'] == 'design3')) {
                  return const SizedBox.shrink();
                }
              }

              switch (item['componentId']) {
                case 'product-filter-component':
                  return _buildFilterComponent(item);
                case 'collection-sort-component':
                  return _buildCollectionSortComponent(item);
                case 'collection-menu-component':
                  return _buildMenuComponent(item);
                case 'product-list-component':
                  return Expanded(child: _buildProductListComponent(item));
                default:
                  return const SizedBox.shrink();
              }
            }).toList(),
          ],
        ),
        bottomNavigationBar: (hasFilterDesign3 && hasSortDesign3)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: _buildFilterAndSortDesign3(typedBlocks),
              )
            : null,
      );
    });
  }
}
