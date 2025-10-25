// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/controller/base_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var returnPageUrl;
  var isLoaded = false.obs;
  @override
  void onInit() {
    webViewController = new WebViewController();
    var args = Get.arguments;
    super.onInit();
  }

  Future openWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted); // Ensure JS execution
    //   ..setBackgroundColor(Colors.transparent)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onPageFinished: (String url) {
    //         // Ensure the script runs after page load
    //         webViewController.runJavaScript('''
    //           console.log("Executing Nector Script...");
    //           let script = document.createElement("script");
    //           script.src = "https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js";
    //           script.setAttribute("async", "true");
    //           script.setAttribute("data-op", "widget");
    //           script.setAttribute("data-api_key", "ak_76a10e5723a930c407afe94a5cf913f219377067176ea2cc8ea1644520b6a4a0");
    //           script.setAttribute("data-platform", "custom_website");
    //           document.body.appendChild(script);
    //         ''');
    //       },
    //     ),
    //   )
    //   ..loadHtmlString('''
    //     <!DOCTYPE html>
    //     <html lang="en">
    //     <head>
    //       <meta charset="UTF-8">
    //       <meta name="viewport" content="width=device-width, initial-scale=1.0">
    //       <title>Nector Widget</title>
    //     </head>
    //     <body>
    //       <h2>Loading Nector Widget...</h2>
    //     </body>
    //     </html>
    //   ''');
    // isLoaded.value = true;
    // webViewController.loadFlutterAsset('assets/config/nector.html');

    String htmlString = """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nector Rewards</title>


</head>


<body>
    <script async src="https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js" data-op="referral"
        data-api_key="enpt-49bd0ebeba8d00106d7e35331425fbf4512fc3fbfc354d4b4cf3d455ca969ef1eede0db8fb6fa7c80fb4a696da190e3ca658abda664018d3978d361e88b3141e1b08d3"
        data-platform="custom_website"></script>
</body>

</html>
""";

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadHtmlString(htmlString);
    isLoaded.value = true;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
