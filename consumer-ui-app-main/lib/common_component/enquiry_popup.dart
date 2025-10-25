// import 'package:black_locust/common_component/default_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:black_locust/controller/cart_v1_controller.dart';

// class EnquiryNowPopup extends StatelessWidget {
//   final TextEditingController summaryController = TextEditingController();
//   // final CartV1Controller controller = Get.put(CartV1Controller());
//   final controller = Get.find<CartV1Controller>();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       surfaceTintColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       insetPadding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Summary',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     // controller.updateSummary();
//                   },
//                 ),
//               ],
//             ),
//             Divider(color: Color.fromARGB(255, 168, 167, 167), thickness: 1),
//             Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10),
//                   Text(
//                     'Message',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     cursorColor: Colors.black54,
//                     cursorWidth: 2.0,
//                     decoration: InputDecoration(
//                       labelStyle: TextStyle(fontSize: 14),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.black),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 15.0, horizontal: 10.0),
//                     ),
//                     controller: controller.summaryController,
//                     keyboardType: TextInputType.multiline,
//                     maxLines: 2,
//                   ),
//                   SizedBox(height: 20),
//                   DefaultButton(
//                     press: () {
//                       if (_formKey.currentState != null &&
//                           _formKey.currentState!.validate()) {
//                         // Navigator.of(context).pop();
//                         controller.fetchOrderStatus();
//                       }
//                     },
//                     text: 'Submit',
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:black_locust/common_component/default_button.dart';
import 'package:flutter/material.dart';

class EnquiryNowPopup extends StatelessWidget {
  final String type;
  // final TextEditingController summaryController = TextEditingController();

  // final controller = Get.find<CartV1Controller>();
  final _formKey = GlobalKey<FormState>();

  EnquiryNowPopup({Key? key, required this.type, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;
  @override
  Widget build(BuildContext context) {
    // final dynamic controller = type == 'cartEnquiry'
    //     ? Get.find<CartV1Controller>()
    //     : Get.find<ProductDetailV1Controller>();
    return Dialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding:
          const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Summary',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(
                color: const Color.fromARGB(255, 168, 167, 167), thickness: 1),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Message',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    cursorColor: Colors.black54,
                    cursorWidth: 2.0,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                    controller: _controller.summaryController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    press: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        if (type == "cartEnquiry") {
                          _controller.updateSummary();
                        } else {
                          _controller.updateSummaryProduct(context);
                        }
                      }
                    },
                    text: 'Submit',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
