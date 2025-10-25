import 'package:black_locust/common_component/default_button.dart';
import 'package:flutter/material.dart';

class OrderCancel extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  OrderCancel({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Dialog(
      backgroundColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      surfaceTintColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cancel Order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Divider(color: Color.fromARGB(255, 168, 167, 167), thickness: 1),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Reason',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a reason';
                      }
                      return null;
                    },
                    cursorColor: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
                    cursorWidth: 2.0,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                    controller: _controller.reasonController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                  DefaultButton(
                    press: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        _controller.cancelOrder();
                      }
                    },
                    text: 'Submit',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
