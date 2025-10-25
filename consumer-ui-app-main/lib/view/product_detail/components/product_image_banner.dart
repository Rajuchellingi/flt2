// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/view/product_detail/components/product_image_banner_design1.dart';
import 'package:black_locust/view/product_detail/components/product_image_banner_design2.dart';
import 'package:flutter/material.dart';

class ProductImageBanner extends StatelessWidget {
  const ProductImageBanner({Key? key, required this.design}) : super(key: key);

  final design;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductImageBannerDesign1(design: design)
      else if (design['instanceId'] == 'design2')
        ProductImageBannerDesign2(design: design)
    ]);
  }
}
