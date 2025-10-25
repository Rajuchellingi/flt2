import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import '../../../const/size_config.dart';

class ProductImageDownloadDesign1 extends StatelessWidget {
  const ProductImageDownloadDesign1({
    Key? key,
    required controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  final design;
  final _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity, // Full width button
        height: getProportionateScreenHeight(45),
        child: ElevatedButton(
          onPressed: () {
            _controller.downloadProductImage(context, design);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Orange color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              side: const BorderSide(color: kPrimaryColor),
            ),
            elevation: 0, // Flat like screenshot
          ),
          child: Text(
            (design['source'] != null && design['source']['metaName'] != null)
                ? design['source']['metaName']
                : _controller.toBagButtonText.value,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
        ),
      ),
    );
  }
}
