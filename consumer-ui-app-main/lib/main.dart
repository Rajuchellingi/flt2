// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
// import 'package:black_locust/common_component/connectivity_wrapper.dart';
// import 'package:black_locust/common_component/loading_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/dark_theme.dart';
import 'package:black_locust/controller/binding/all_controller_binding.dart';
import 'package:black_locust/controller/location_controller.dart';
// import 'package:black_locust/controller/binding/all_controller_binding.dart';
import 'package:black_locust/controller/shop_controller.dart';
import 'package:black_locust/controller/site_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:black_locust/view/home/screens/home_screen.dart';
// import 'package:black_locust/view/home/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'const/deep_link_config.dart';
import 'const/firebase_config.dart';
import 'routes.dart';
import './const/theme.dart';
// import 'view/landing_page/screens/landing_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await GetStorage.init();
    DeepLinkConfig().init();

    final graphQLConfiguration = await _initializeGraphQL();

    runApp(
      MyApp(graphQLConfiguration.client),
    );
  } catch (e) {
    debugPrint('Initialization error: $e');
    // Handle initialization error appropriately
  }
}

Future<GraphQLConfiguration> _initializeGraphQL() async {
  if (platform == 'shopify') {
    return await setupShopifyGraphQl();
  }
  return await setupToAutomationGraphQl();
}

Future<void> clearCache() async {
  try {
    final tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
      debugPrint("Cache cleared successfully");
    }
  } catch (e) {
    debugPrint("Error clearing cache: $e");
  }
}

Future<GraphQLConfiguration> setupToAutomationGraphQl() async {
  final locationController = Get.put(LocationController());
  final serviceConfiguration = GraphQLConfiguration.config();

  try {
    final country = await locationController.getCountry();
    GraphQLConfiguration.shopifyConfig(country);

    final themeController = Get.put(ThemeController());
    final siteSettingController = Get.put(SiteSettingController());
    final siteSettingData = siteSettingController.getSiteSetting();
    final _controller = Get.put(ShopController());

    final theme = themeController.getTemplate();
    final siteSetting = await siteSettingData;
    await theme;
    FirebaseApp app = await Firebase.initializeApp();

    // await Firebase.initializeApp(
    //   options: FirebaseOptions(
    //     apiKey: firebaseConfig['apiKey'].toString(),
    //     appId: firebaseConfig['appId'].toString(),
    //     messagingSenderId: firebaseConfig['messagingSenderId'].toString(),
    //     projectId: firebaseConfig['projectId'].toString(),
    //     measurementId: siteSetting?.googleAnalyticsMeasurementId,
    //   ),
    // );

    FirebaseConfig().init();
    await serviceConfiguration.initiateGraphQl();
    _controller.getShopifyShopDetails();

    return serviceConfiguration;
  } catch (e) {
    debugPrint('Error in setupToAutomationGraphQl: $e');
    rethrow;
  }
}

Future<GraphQLConfiguration> setupShopifyGraphQl() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp app = await Firebase.initializeApp();
    // FirebaseApp app = await Firebase.initializeApp(
    //   options: FirebaseOptions(
    //     apiKey: firebaseConfig['apiKey'].toString(),
    //     appId: firebaseConfig['appId'].toString(),
    //     messagingSenderId: firebaseConfig['messagingSenderId'].toString(),
    //     projectId: firebaseConfig['projectId'].toString(),
    //   ),
    // );
    // await FirebaseAppCheck.instance.activate(
    //   androidProvider: AndroidProvider.playIntegrity,
    // );
    // var token = await FirebaseAppCheck.instance.getToken(true);
    FirebaseConfig().init();
    final serviceConfiguration = GraphQLConfiguration.config();
    final _controller = Get.put(ShopController());
    final siteSettingController = Get.put(SiteSettingController());
    final themeController = Get.put(ThemeController());

    final theme = themeController.getTemplate();
    final shop = await _controller.getShopifyShopDetails();
    await theme;

    final shopifyGraphqlUrl = 'https://$shop/api/2025-01/graphql.json';
    GraphQLConfiguration.shopifyConfig(shopifyGraphqlUrl);
    await serviceConfiguration.initiateGraphQl();

    return serviceConfiguration;
  } catch (e) {
    debugPrint('Error in setupShopifyGraphQl: $e');
    rethrow;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient>? _graphQlClient;
  final navigatorKey = GlobalKey<NavigatorState>();
  final siteSettingController = Get.find<SiteSettingController>();
  final themeController = Get.find<ThemeController>();

  MyApp(this._graphQlClient);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final siteSetting = siteSettingController.siteSetting.value;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return GraphQLProvider(
      client: _graphQlClient,
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [
          if (siteSetting.googleAnalyticsMeasurementId != null)
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          // CustomNavigationObserver(),
        ],
        initialBinding: AllControllerBinding(),
        debugShowCheckedModeBanner: false,
        popGesture: true,
        title: appTitle,
        themeMode: ThemeMode.system,
        // themeMode: ThemeMode.light,
        theme: theme(context),
        darkTheme: darkTheme(context),
        initialRoute: themeController.initalRoute.value,
        getPages: RouteConfig.route,
        // home: HomeScreen(),
        // home: Obx(() => ConnectivityWrapper(
        //     child: _controller.isLoading.value == true
        //         ? LoadingImage()
        //         : HomeScreen())),
      ),
    );
  }
}
