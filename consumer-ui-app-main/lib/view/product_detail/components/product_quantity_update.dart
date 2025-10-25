import 'package:flutter/material.dart';
import '../../../const/size_config.dart';

class ProductQuantityUpdate extends StatelessWidget {
  const ProductQuantityUpdate({
    Key? key,
    this.tag,
    this.size,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final String? tag;
  final _controller;
  final dynamic size;

  @override
  Widget build(BuildContext context) {
    // print("ProductQuantityUpdate ${_controller.product.value.toJson()}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 0.0),
          child: Text(
            _controller.product.value.type == 'pack'
                ? "1 Pack: ${_controller.product.value.packQuantity.totalQuantity} Pieces"
                : _controller.product.value.type == 'set' &&
                        _controller.product.value.isAssorted == false
                    ? "1 Set: ${_controller.product.value.setQuantity.totalQuantity} Pieces"
                    : _controller.product.value.type == 'set' &&
                            _controller.product.value.isAssorted == true
                        ? "1 Set: ${_controller.product.value.setQuantity.totalQuantity} Pieces; Assorted ${_controller.product.value.preferenceVariant.attributeLabelName};"
                        : "",
            style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _controller.product.value.type == 'pack'
                ? _controller.product.value.packQuantity.setQuantities
                    .map<Widget>((setQuantity) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${setQuantity.fieldValue}   : ",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        ...setQuantity.variantQuantites.map<Widget>((variant) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                            child: Text(
                              "${variant.attributeFieldValue} = ${variant.moq} ;",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList()
                : _controller.product.value.type == 'set'
                    ? _controller.product.value.setQuantity.variantQuantites
                        .map<Widget>((variant) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${variant.attributeFieldValue} = ${variant.moq} ;",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        );
                      }).toList()
                    : "",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 0)),
            const Text(
              "Quantity",
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.0),
            ),
            IconButton(
              icon: const Icon(
                Icons.remove,
                size: 18,
              ),
              onPressed: () {
                _controller.quantityMinus(
                    size == null ? 0 : size, _controller.product.value);
              },
            ),
            Container(
              height: getProportionateScreenWidth(30),
              width: getProportionateScreenWidth(40),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  size == null ? '0' : size.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 18,
              ),
              onPressed: () {
                _controller.quantityAdd(
                    size == null ? 0 : size, _controller.product.value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
