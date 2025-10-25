// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with BaseController, SingleGetTickerProviderMixin {
  var pageIndex = 0.obs;
  var categoryList = [].obs;
  var subCategoryList = Object().obs;
  var menuType = ''.obs;
  var menu = Object().obs;
  PageController? pageController;
  // PageController? pageController1;
  var isLoading = false.obs;
  var template = {}.obs;
  final themeController = Get.find<ThemeController>();
  var selectedMenu = {}.obs;
  var selectedDesign3Menu = {}.obs;
  var selectedIndex = 0.obs;
  var selectedDesign3Index = 100.obs;
  late TabController tabController;

  @override
  void onInit() {
    pageController = new PageController();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhere((value) => value['id'] == 'collections', orElse: () => {});
    setDefaultSelectedMenu();
    assignTabCount();
    isLoading.value = false;
  }

  setDefaultSelectedMenu() {
    var menu = template.value['layout']['blocks'].firstWhere(
        (element) => element['componentId'] == 'collection-component',
        orElse: () => null);
    if (menu != null) {
      selectedMenu.value = (menu['source']['lists'] != null &&
              menu['source']['lists'].length > 0)
          ? menu['source']['lists'].first
          : {};
    }
  }

  assignTabCount() {
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.length > 0) {
      var lists;
      for (var element in blocks) {
        if (element['componentId'] == 'collection-component') {
          lists = element['source']['lists'];
          tabController = TabController(length: lists.length, vsync: this);
        }
      }
    }
  }
  // void dispose() {
  //   pageController?.dispose();
  //   pageController1?.dispose();
  //   super.dispose();
  // }

  Future<Null> refreshMainPageCategory() async {}

  Future<Null> refreshChildPageCategory() async {}

  void onPageChanged(page) {
    this.pageIndex.value = page;
  }

  changeImageUrl(image) {
    var newUrl = image ?? '';
    if (image != null && image.isNotEmpty) {
      if (platform == 'shopify') {
        if (image.contains('ri-shopify-mobile-app-file') &&
            image.contains('homepageSetting') &&
            !image.contains('/webp/')) {
          newUrl = image.replaceAll(
              'ri-shopify-mobile-app-file.s3.ap-south-1.amazonaws.com/homepageSetting',
              'd1p1ymt3bt37nv.cloudfront.net/homepageSetting/webp');
        } else if (image.contains('cdn.shopify.com') &&
            !image.contains('width=')) {
          newUrl = '$image?width=150';
        }
      }
    }
    return newUrl;
  }

  void onTabTapped(int index, dynamic data, dynamic menuData) {
    menu.value = menuData;
    // print(" menu.value --> ${menuData.type}");
    menuType.value = menuData.type;
    if (menuData.type == 'category') {
      subCategoryList.value = data;
      if (data.children != null && data.children.length > 0) {
        this.pageController!.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      } else {
        checkUrlAndNavigate(data.link);
        // var packdata = {"categoryLink": data.link.toString(), "page": 1};
        // Get.toNamed('/productList', arguments: packdata);
      }
    } else {
      var subMenu = menuData.subMenu.where((e) => e.status == true);
      // print('mentu type ${subMenu.toJson()}');
      if (subMenu != null && subMenu.length > 0) {
        // print("subMenu.title ${subMenu.title}");
        this.pageController!.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      } else {
        navigateToCollection(menuData.title);
        // print("subMenu.title ${subMenu.title}");
      }
    }
  }

  checkUrlAndNavigate(link) async {
    if (link != null) {
      if (link.contains('collections')) {
        var splittedLink = link.split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        // var collectionId = 'gid://shopify/Collection/$id';
        var result =
            await Get.toNamed('/collection', arguments: {'id': collectionId});
        categoryList.refresh();
      } else if (link.contains('brand')) {
        var splittedLink = link.split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        // var collectionId = 'gid://shopify/Collection/$id';
        var result = await Get.toNamed('/brandCollection',
            arguments: {'id': collectionId});
        categoryList.refresh();
      } else {
        print('URL does not contain the word "collections"');
      }
    }
  }

  navigateByUrlType(link) async {
    // print("link category---------------->>>>>>>>> ${link}");
    if (link != null) {
      if (link['kind'] == 'collection') {
        var splittedLink = link['value'].split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        // var collectionId = 'gid://shopify/Collection/$id';
        var result =
            await Get.toNamed('/collection', arguments: {'id': collectionId});
        categoryList.refresh();
      } else if (link['kind'] == 'brand' || link['value'].contains('brand')) {
        var splittedLink = link['value'].split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        // var collectionId = 'gid://shopify/Collection/$id';
        var result = await Get.toNamed('/brandCollection',
            arguments: {'id': collectionId});
        categoryList.refresh();
      } else if (link['kind'] == 'landingPage') {
        var splittedLink = link['value'].split('/');
        var landingPageId = splittedLink[splittedLink.length - 1];
        var result =
            await Get.toNamed('/landingPage', arguments: {'id': landingPageId});
      } else {
        print('URL does not contain the word "collections"');
      }
    }
  }

  Future clickMenu(index, menuData, context) async {
    if (menuData['lists'] != null && menuData['lists'].length > 0) {
      if (selectedMenu.value['title'] == menuData['title']) {
        selectedMenu.value = menuData;
        selectedIndex.value = index;
      } else {
        selectedIndex.value = index;
        selectedMenu.value = menuData;
      }
    } else {
      navigateByUrlType(menuData['link']);
    }
  }

  Future clickDesign3Menu(index, menuData) async {
    if (menuData['lists'] != null && menuData['lists'].length > 0) {
      if (selectedDesign3Menu.value['title'] == menuData['title']) {
        selectedDesign3Menu.value = {};
        selectedDesign3Index.value = -1;
      } else {
        selectedDesign3Index.value = index;
        selectedDesign3Menu.value = menuData;
      }
    } else {
      navigateByUrlType(menuData['link']);
    }
  }

  navigateToCollection(String link) async {
    if (link != null) {
      var result = await Get.toNamed('/collection', arguments: {'id': link});
      // refreshMainPageCategory();
      categoryList.refresh();
    }
  }

  getPath(String path, int type) {
    List<String> parts = path.split("/");
    if (parts.length > 1) {
      String pathName = parts[type];
      return pathName;
    }
  }

  void onBackTapped(int index) {
    this.pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    pageController!.dispose();
    tabController.dispose();
    pageIndex.close();
    categoryList.close();
    subCategoryList.close();
    menuType.close();
    menu.close();
    isLoading.close();
    template.close();
    selectedMenu.close();
    selectedDesign3Menu.close();
    selectedIndex.close();
    selectedDesign3Index.close();
    // pageController1?.dispose();
    super.dispose();
  }
}
