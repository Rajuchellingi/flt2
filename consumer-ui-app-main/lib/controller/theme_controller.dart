// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use, unnecessary_null_comparison, unused_field, unused_import

import 'dart:convert';

import 'package:b2b_graphql_package/modules/common/common_repo.dart';
import 'package:black_locust/common_component/offer_popup.dart';
import 'package:black_locust/common_component/search_delegate.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:new_version_plus/new_version_plus.dart';

class ThemeController extends GetxController {
  CommonRepo? commonRepo;
  var allTemplate = [].obs;
  var pageIndex = 0.obs;
  var previousPage = 0.obs;
  var logo = ''.obs;
  var secondaryLogo = ''.obs;
  var bottomBarType = 'design1'.obs;
  var initalRoute = '/home'.obs;
  final musicController = Get.put(MusicController());
  var isWelcomeImageLoading = false.obs;
  var isInitialDataLoading = false.obs;
  var isTimeReached = false.obs;
  var productBadge;
  bool _hasShownPopup = false;

  @override
  void onInit() {
    commonRepo = CommonRepo();
    super.onInit();
  }

  Future<void> _checkVersion() async {
    final newVersion = NewVersionPlus(
      iOSId: 'com.shopify.nineShineLabel',
      androidId: 'com.shopify.nineShineLabel',
    );
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      print("Store version: ${status.storeVersion}");
      print("Local version: ${status.localVersion}");
      print("Can update: ${status.canUpdate}");

      if (status.canUpdate) {
        /// Force update dialog
        newVersion.showUpdateDialog(
          context: Get.context!,
          versionStatus: status,
          dialogTitle: "Update Required",
          dialogText:
              "A new version of the app is available. Please update to continue.",
          updateButtonText: "Update Now",
          allowDismissal: false, // user cannot skip
        );
      }
    }
  }
  // Future getTemplate() async {
  //   final String response =
  //       await rootBundle.loadString('assets/config/template.json');
  //   // await rootBundle.loadString('assets/config/toautomation_template.json');
  //   allTemplate.value = jsonDecode(response);
  //   initalRoute.value = await initialRoute();
  //   assignDefaultData();
  // }

  startMusic() {
    var globalConfig = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'global-config');
    if (globalConfig != null && globalConfig['options'] != null) {
      var options = globalConfig['options'];
      if (options['play-background-music'] == true &&
          options['background-music'] != null &&
          options['background-music'].isNotEmpty) {
        musicController.startMusic(
            options['play-background-music'], options['background-music']);
      }
    }
  }

  getWelcomImage() {
    var globalConfig = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'global-config');
    if (globalConfig != null && globalConfig['options'] != null) {
      var showWelcomeImage = globalConfig['options']['showWelcomeImage'];
      if (showWelcomeImage == true) {
        isWelcomeImageLoading.value = true;
        Future.delayed(
            Duration(
                seconds:
                    globalConfig['options']['welcomeImageDisplaySeconds'] ?? 5),
            () {
          if (isInitialDataLoading.value == false) {
            isWelcomeImageLoading.value = false;
          }
          isTimeReached.value = true;
        });
      }
    }
  }

  Future getTemplate() async {
    var result = await commonRepo!.getTemplate();
    if (result != null && result['template'] != null) {
      allTemplate.value = jsonDecode(result['template']);
      _checkVersion();
      initalRoute.value = await initialRoute();
      assignDefaultData();
      startMusic();
      getWelcomImage();
    }
  }

  instanceId(componentId) {
    var globalConfig = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'global-config');
    if (globalConfig != null) {
      var instances = globalConfig['instances'];
      if (instances != null && instances.length > 0) {
        var instance = instances.firstWhere(
            (element) => element['componentId'] == componentId,
            orElse: () => null);
        if (instance != null) {
          return instance['instanceId'];
        } else {
          return 'design1';
        }
      }
    } else {
      return 'design1';
    }
  }

  Future initialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch && isWelcomeScreen()) {
      return '/welcomeScreen';
    } else {
      return '/home';
    }
  }

  bool isWelcomeScreen() {
    List<dynamic> allTemplates = allTemplate.value;
    var template = allTemplates.firstWhere(
        (value) => value['id'] == 'welcome-screen',
        orElse: () => {});
    if (template != null &&
        template.isNotEmpty &&
        template['layout'] != null &&
        template['layout']['blocks'] != null &&
        template['layout']['blocks'].length > 0) {
      return true;
    } else {
      return false;
    }
  }

  assignDefaultData() {
    var home = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'home');
    if (home != null) {
      var header = home['layout']['header'];
      var footer = home['layout']['footer'];
      if (header != null && header.isNotEmpty) {
        var headerOption = header['options'];
        if (headerOption != null) {
          var logoBlock = header['options']['logo'];
          if (logoBlock != null && logoBlock['image'] != null) {
            logo.value = platform == 'shopify'
                ? changeImageUrl(logoBlock['image'])
                : logoBlock['image'];
          }
          if (logoBlock != null && logoBlock['secondary-logo'] != null) {
            secondaryLogo.value = platform == 'shopify'
                ? changeImageUrl(logoBlock['secondary-logo'])
                : logoBlock['secondary-logo'];
          }
        }
      }
      if (footer != null && footer.isNotEmpty) {
        bottomBarType.value = footer['instanceId'] ?? 'design1';
      }
    }
    for (var element in allTemplate.value) {
      if (element['id'] == 'global-config') {
        var instances = element['instances'] ?? [];
        for (var instance in instances) {
          if (instance['componentId'] == 'product') {
            if (instance['source'] != null) {
              if (instance['source']['badge-metafield'] != null &&
                  instance['source']['badge-metafield'].isNotEmpty) {
                var value = instance['source']['badge-metafield'];
                var parts = value.split('.');
                productBadge = {"key": parts.last, "namespace": parts.first};
              }
            }
          }
        }
      }
    }
    // if (logo.value != null && logo.value != '') {
    //   Future.delayed(Duration(seconds: 3), () {
    //     preloadLogo();
    //   });
    // }
  }

  floatingActionButton(footer) {
    if (footer != null) {
      if (footer['layout'] != null &&
          footer['layout']['children'] != null &&
          footer['layout']['children'].length > 0) {
        var data = footer['layout']['children'].firstWhere(
          (element) {
            var key = element['key'];
            return footer['options'][key]['isCenterButton'] == true;
          },
          orElse: () => null,
        );

        return data;
      }
    }
  }

  Future<void> preloadLogo() async {
    await precacheImage(CachedNetworkImageProvider(logo.value), Get.context!);
  }

  instance(componentId) {
    var globalConfig = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'global-config');
    if (globalConfig != null) {
      var instances = globalConfig['instances'];
      if (instances != null && instances.length > 0) {
        var instance = instances.firstWhere(
            (element) => element['componentId'] == componentId,
            orElse: () => null);
        if (instance != null) {
          return instance;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  changeImageUrl(image) {
    var newUrl = image;
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

  iconByTheme(type, color, {size = 24.0}) {
    final brightness = Theme.of(Get.context!).brightness;
    switch (type) {
      case 'back-button-1':
        return Icon(Icons.arrow_back_outlined, color: color, size: size);
      case 'back-button-2':
        return Icon(Icons.arrow_back_ios_new_outlined,
            color: color, size: size);
      case 'account-1':
        return Icon(Icons.person_2_outlined, color: color, size: size);
      case 'account-2':
        return Icon(Icons.person_3_outlined, color: color, size: size);
      case 'search-1':
        return Icon(Icons.search_outlined, color: color, size: size);
      case 'search-2':
        return Icon(CupertinoIcons.search, color: color, size: size);
      case 'wishlist-1':
        return Icon(Icons.favorite_border_outlined, color: color, size: size);
      case 'wishlist-2':
        return Icon(CupertinoIcons.heart, color: color, size: size);
      case 'cart-1':
        return Icon(Icons.shopping_bag_outlined, color: color, size: size);
      case 'cart-2':
        return Icon(Icons.shopping_cart_outlined, color: color, size: size);
      case 'cart-3':
        return Icon(CupertinoIcons.cart_fill, color: color, size: size);
      case 'cart-4':
        return SvgPicture.asset(
          "assets/icons/cart_icon_4.svg",
          height: 24,
          width: 24,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        );
      case 'sort-button-1':
        return Icon(Icons.sort_outlined, color: color, size: size);
      case 'filter-button-1':
        return Icon(Icons.filter_alt_outlined, color: color, size: size);
      case 'address-button-1':
        return Icon(Icons.book_outlined, color: color, size: size);
      case 'order-history-button-1':
        return Icon(Icons.history_outlined, color: color, size: size);
      case 'booking-history-button-1':
        return Icon(Icons.library_books, color: color, size: size);
      case 'profile-button-1':
        return Icon(Icons.person, color: color, size: size);
      case 'wishlist-button-1':
        return Icon(Icons.favorite, color: color, size: size);
      case 'menu-1':
        return Icon(Icons.category_outlined, color: color, size: size);
      case 'menu-2':
        return Icon(Icons.grid_view, color: color, size: size);
      case 'home-1':
        return Icon(Icons.home_outlined, color: color, size: size);
      case 'home-2':
        return Icon(CupertinoIcons.house_alt_fill, color: color, size: size);
      case 'notification-1':
        return Icon(Icons.notifications_outlined, color: color, size: size);
      case 'filter-1':
        return Icon(Icons.checklist_rounded, color: color, size: size);
      case 'share-button-1':
        return Icon(Icons.share, color: color, size: size);
      case 'facebook-1':
        return SvgPicture.asset(
          "assets/icons/facebook1.svg",
          height: 24,
          width: 24,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        );
      case 'instagram-1':
        return SvgPicture.asset(
          "assets/icons/instagram1.svg",
          height: 19,
          width: 19,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        );
      case 'youtube-1':
        return SvgPicture.asset(
          "assets/icons/youtube1.svg",
          height: 22,
          width: 22,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        );
      case 'linkedin-1':
        return SvgPicture.asset(
          "assets/icons/linkedin1.svg",
          height: 16,
          width: 16,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        );
      default:
        return Icon(Icons.error_outline, color: color, size: size);
    }
  }

  filledIcon(type, color, {size = 24.0}) {
    switch (type) {
      case 'back-button-1':
        return Icon(Icons.arrow_back, color: color, size: size);
      case 'back-button-2':
        return Icon(Icons.arrow_back_ios_new, color: color, size: size);
      case 'account-1':
        return Icon(Icons.person_2, color: color, size: size);
      case 'account-2':
        return Icon(Icons.person_3, color: color, size: size);
      case 'search-1':
        return Icon(Icons.search, color: color, size: size);
      case 'wishlist-1':
        return Icon(Icons.favorite, color: color, size: size);
      case 'cart-1':
        return Icon(Icons.shopping_bag, color: color, size: size);
      case 'cart-2':
        return Icon(Icons.shopping_cart, color: color, size: size);
      case 'sort-button-1':
        return Icon(Icons.sort, color: color, size: size);
      case 'filter-button-1':
        return Icon(Icons.filter_alt, color: color, size: size);
      case 'address-button-1':
        return Icon(Icons.book, color: color, size: size);
      case 'order-history-button-1':
        return Icon(Icons.history, color: color, size: size);
      case 'booking-history-button-1':
        return Icon(Icons.library_books, color: color, size: size);
      case 'profile-button-1':
        return Icon(Icons.person, color: color, size: size);
      case 'wishlist-button-1':
        return Icon(Icons.favorite, color: color, size: size);
      case 'menu-1':
        return Icon(Icons.category, color: color, size: size);
      case 'menu-2':
        return Icon(Icons.grid_view_rounded, color: color, size: size);
      case 'home-1':
        return Icon(Icons.home, color: color, size: size);
      case 'notification-1':
        return Icon(Icons.notifications, color: color, size: size);
      default:
        return Icon(Icons.error_outline, color: color, size: size);
    }
  }

  navigateByType(type, {link = ''}) async {
    var userId = GetStorage().read('utoken');
    print("type: $type, link: $link, userId: $userId");
    switch (type) {
      case 'home':
        await Get.toNamed('/home');
        break;
      case 'account':
        await Get.toNamed('/myAccount');
        break;
      case 'search':
        showSearch(
            context: Get.context!,
            delegate: SearchDelegateWidget('collectionPage'));
        break;
      case 'cart':
        var isAllowCart = isAllowCartBeforLogin();
        if (userId != null || isAllowCart) {
          await Get.toNamed('/cart');
        } else {
          var isMessage = isCartMessage();
          if (isMessage == true) {
            Get.toNamed('/cartLoginMessage', arguments: {"path": "/cart"});
          } else {
            Get.toNamed('/login', arguments: {"path": "/cart"});
          }
        }
        break;
      case 'wishlist':
        if (userId != null) {
          await Get.toNamed('/wishlist');
        } else {
          var isMessage = isWishlistMessage();
          if (isMessage == true) {
            Get.toNamed('/wishlistLoginMessage',
                arguments: {"path": "/wishlist"});
          } else {
            Get.toNamed('/login', arguments: {"path": "/wishlist"});
          }
        }
        break;
      case 'address':
        if (userId != null)
          await Get.toNamed('/address');
        else
          Get.toNamed('/login', arguments: {"path": "/address"});
        break;
      case 'orderHistory':
        if (userId != null)
          await Get.toNamed('/orderHistory');
        else
          Get.toNamed('/login', arguments: {"path": "/orderHistory"});
        break;
      case 'enquiryHistory':
        if (userId != null)
          await Get.toNamed('/enquiryHistory');
        else
          Get.toNamed('/login', arguments: {"path": "/enquiryHistory"});
        break;
      case 'bookingHistory':
        if (userId != null)
          await Get.toNamed('/bookingHistory');
        else
          Get.toNamed('/login', arguments: {"path": "/bookingHistory"});
        break;
      case 'profile':
        if (userId != null)
          await Get.toNamed('/profile');
        else
          Get.toNamed('/login', arguments: {"path": "/profile"});
        break;
      case 'back':
        Get.back();
        break;
      case 'collection':
        if (link != null && link.isNotEmpty) {
          Get.toNamed('/collection', arguments: {'id': link});
        }
        break;
      case 'product':
        if (link != null && link.isNotEmpty) {
          await Get.toNamed('/productDetail', arguments: {
            'productUrl': link,
          });
        }
        break;
      case 'external':
        if (link.startsWith('http://') || link.startsWith('https://')) {
          if (await canLaunch(link)) {
            await launch(link);
          } else {
            throw 'Could not launch $link';
          }
        }
        break;
      default:
        Get.back();
        break;
    }
  }

  isCartMessage() {
    var messageComponent = allTemplate.value
        .firstWhereOrNull((value) => value['id'] == 'cart-login-message');
    return messageComponent != null && messageComponent.isNotEmpty;
  }

  isAllowCartBeforLogin() {
    var instanceData = instance('product');
    if (instanceData['source'] != null) {
      return instanceData['source']['add-to-cart-without-login'] == true;
    }
    return false;
  }

  isWishlistMessage() {
    var messageComponent = allTemplate.value
        .firstWhereOrNull((value) => value['id'] == 'wishlist-login-message');
    return messageComponent != null && messageComponent.isNotEmpty;
  }

  getPopupMessage() {
    var globalConfig = allTemplate.value
        .firstWhereOrNull((element) => element['id'] == 'global-config');
    if (globalConfig != null && globalConfig['instances'] != null) {
      var instances = globalConfig['instances'];
      var popupInstance = instances.firstWhere(
          (element) => element['componentId'] == 'popup-message',
          orElse: () => null);
      if (popupInstance != null &&
          popupInstance['source'] != null &&
          popupInstance['source']['showMessage'] == true) {
        return popupInstance;
      }
    }
    return null;
  }

  void showOfferPopup() async {
    final popupData = getPopupMessage();
    print('popup data ${popupData}');
    if (popupData != null && Get.context != null) {
      final prefs = await SharedPreferences.getInstance();
      final hasShownBefore = prefs.getBool('hasShownOfferPopup') ?? false;

      if (!hasShownBefore && !_hasShownPopup) {
        final messageDelay = popupData['source']['messageDelay'] ?? 10;
        Future.delayed(Duration(seconds: messageDelay), () async {
          if (!_hasShownPopup && Get.context != null) {
            _hasShownPopup = true;
            await prefs.setBool('hasShownOfferPopup', true);
            _showOfferDialog(popupData);
          }
        });
      }
    }
  }

  void _showOfferDialog(dynamic popupData) {
    final imageUrl = popupData['source']['image'];
    final link = popupData['source']['link'];
    if (imageUrl != null && imageUrl.isNotEmpty && Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return OfferPopup(
            imageUrl: imageUrl,
            link: link,
          );
        },
      );
    }
  }

  defaultStyle(type, value) {
    final brightness = Theme.of(Get.context!).brightness;
    switch (type) {
      case 'margin':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 7);
      case 'padding':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 0);
      case 'color':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.white
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.white : Colors.black;
      case 'backgroundColor':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.black
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.white : kBackground;
      case 'fontWeight':
        if (value != null && value.isNotEmpty)
          return fontWeight(value);
        else
          return FontWeight.w600;
      case 'fontSize':
        if (value != null)
          return value.toDouble();
        else
          return 14.0;
      case 'height':
        if (value != null)
          return value.toDouble();
        else
          return 300.0;
      case 'aspectRatio':
        if (value != null)
          return value.toDouble();
        else
          return 16 / 9;
      case 'textAlign':
        if (value != null && value.isNotEmpty)
          return textAlign(value);
        else
          return TextAlign.start;
      default:
        return null;
    }
  }

  footerStyle(type, value) {
    final brightness = Theme.of(Get.context!).brightness;
    switch (type) {
      case 'margin':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 7);
      case 'padding':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 0);
      case 'color':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.white
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.white : Colors.black;
      case 'backgroundColor':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.black
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.white : Colors.black;
      case 'fontWeight':
        if (value != null && value.isNotEmpty)
          return fontWeight(value);
        else
          return FontWeight.w600;
      case 'fontSize':
        if (value != null)
          return value.toDouble();
        else
          return 14.0;
      case 'height':
        if (value != null)
          return value.toDouble();
        else
          return 300.0;
      case 'textAlign':
        if (value != null && value.isNotEmpty)
          return textAlign(value);
        else
          return TextAlign.start;
      default:
        return null;
    }
  }

  textAlign(value) {
    switch (value) {
      case 'center':
        return TextAlign.center;
      case 'end':
        return TextAlign.end;
      case 'justify':
        return TextAlign.justify;
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'start':
        return TextAlign.start;
      default:
        return TextAlign.start;
    }
  }

  alignment(value) {
    switch (value) {
      case 'top-left':
        return Alignment.topLeft;
      case 'top-right':
        return Alignment.topRight;
      case 'bottom-left':
        return Alignment.bottomLeft;
      case 'bottom-right':
        return Alignment.bottomRight;
      case 'center':
        return Alignment.center;
      case 'center-left':
        return Alignment.centerLeft;
      case 'center-right':
        return Alignment.centerRight;
      case 'top-center':
        return Alignment.topCenter;
      case 'bottom-center':
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }

  headerStyle(type, value) {
    final brightness = Theme.of(Get.context!).brightness;
    switch (type) {
      case 'margin':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 5);
      case 'padding':
        if (value != null && value.isNotEmpty)
          return edgeInsets(value);
        else
          return EdgeInsets.symmetric(horizontal: 7);
      case 'backgroundColor':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.black
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.black : Colors.white;
      case 'color':
        if (value != null && value.isNotEmpty)
          return brightness == Brightness.dark
              ? Colors.white
              : Color(int.parse(value.replaceAll('#', '0xff')));
        else
          return brightness == Brightness.dark ? Colors.white : Colors.black;
      case 'fontWeight':
        if (value != null && value.isNotEmpty)
          return fontWeight(value);
        else
          return FontWeight.w600;
      case 'fontSize':
        if (value != null)
          return value.toDouble();
        else
          return 16.0;
      case 'textAlign':
        if (value != null && value.isNotEmpty)
          return textAlign(value);
        else
          return TextAlign.start;
      case 'width':
        if (value != null)
          return value.toDouble();
        else
          return null;
      case 'borderRadius':
        if (value != null)
          return BorderRadius.circular(10);
        else
          return BorderRadius.circular(0);
      default:
        return null;
    }
  }

  footerNavigationByType(type, index) async {
    this.previousPage.value = this.pageIndex.value;
    this.pageIndex.value = index;
    var userId = GetStorage().read('utoken');
    switch (type) {
      case 'home':
        await Get.toNamed('/home');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'account':
        await Get.toNamed('/myAccount');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'search':
        showSearch(
                context: Get.context!,
                delegate: SearchDelegateWidget('collectionPage'))
            .then((value) => {this.pageIndex.value = this.previousPage.value});
        break;
      case 'cart':
        var isAllowCart = isAllowCartBeforLogin();
        if (userId != null || isAllowCart) {
          await Get.toNamed('/cart');
        } else {
          var isMessage = isCartMessage();
          if (isMessage == true) {
            Get.toNamed('/cartLoginMessage', arguments: {"path": "/cart"});
          } else {
            Get.toNamed('/login', arguments: {"path": "/cart"});
          }
        }
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'wishlist':
        if (userId != null) {
          await Get.toNamed('/wishlist');
        } else {
          var isMessage = isWishlistMessage();
          if (isMessage == true) {
            Get.toNamed('/wishlistLoginMessage',
                arguments: {"path": "/wishlist"});
          } else {
            Get.toNamed('/login', arguments: {"path": "/wishlist"});
          }
        }
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'menu':
        await Get.toNamed('/category');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'notification':
        await Get.toNamed('/notification', preventDuplicates: false);
        this.pageIndex.value = this.previousPage.value;
        break;
      default:
        await Get.toNamed('/home');
        this.pageIndex.value = this.previousPage.value;
        break;
    }
  }

  edgeInsets(value) {
    var left = value['left'] ?? 0;
    var right = value['right'] ?? 0;
    var top = value['top'] ?? 0;
    var bottom = value['bottom'] ?? 0;
    return EdgeInsets.only(
        left: left.toDouble(),
        right: right.toDouble(),
        top: top.toDouble(),
        bottom: bottom.toDouble());
  }

  fontWeight(type) {
    switch (type) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      case '100':
        return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }
}
