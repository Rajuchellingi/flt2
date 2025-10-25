// ignore_for_file: unrelated_type_equality_checks, cancel_subscriptions

import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/view/loyality_widget/components/loyality_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'offline_page.dart';
import 'subscription_message.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final _controller = Get.find<SubscriptionController>();
  final pluginController = Get.find<PluginsController>();

  double x = 10;
  double y = 65;

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    final brightness = Theme.of(context).brightness;
    return WillPopScope(
        onWillPop: () async {
          var currentRoute = Get.currentRoute;
          if (Navigator.of(context).canPop()) {
            return true;
          } else if (currentRoute != '/' && currentRoute != '/home') {
            Get.offAllNamed('/home');
            return false;
          } else if (currentRoute == '/' || currentRoute == '/home') {
            bool? exitApp = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor:
                    brightness == Brightness.dark ? Colors.black : Colors.white,
                surfaceTintColor:
                    brightness == Brightness.dark ? Colors.black : Colors.white,
                title: Text("Exit App",
                    style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)),
                content: Text("Do you want to exit the app?",
                    style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("No",
                        style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Yes",
                        style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)),
                  ),
                ],
              ),
            );
            return exitApp ?? false;
          }
          return true;
        },
        child: Obx(() => _controller.isOffline.value
            ? OfflinePage()
            : _controller.isAllowed.value == true
                ? Stack(
                    children: [
                      widget.child,
                      if (pluginController.isLoyality.value) ...[
                        LoyalityWidgetIcon()
                      ],
                      if (pluginController.isWhatsapp.value)
                        Positioned(
                          bottom: currentRoute == '/register'
                              ? y == 65
                                  ? 45
                                  : y
                              : y,
                          left: currentRoute == '/register' ? x : null,
                          right: currentRoute != '/register' ? x : null,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                x -= details.delta.dx;
                                y -= details.delta.dy;
                              });
                            },
                            child: FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                pluginController.openWhatsApp();
                              },
                              backgroundColor: const Color(0XFF60d66a),
                              child: SvgPicture.asset(
                                "assets/icons/whatsapp1.svg",
                                height: 35,
                                width: 35,
                              ),
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                    ],
                  )
                : SubscriptionMessage(controller: _controller)));
  }
}
