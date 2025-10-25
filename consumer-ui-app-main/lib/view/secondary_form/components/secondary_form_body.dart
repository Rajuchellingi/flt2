import 'package:black_locust/view/secondary_form/components/secondary_form_field.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class SecondaryFormBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: SecondaryFormField(),
            ),
          )),
    );
  }
}
