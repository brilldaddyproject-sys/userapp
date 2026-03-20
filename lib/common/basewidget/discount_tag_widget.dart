import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:provider/provider.dart';


class DiscountTagWidget extends StatelessWidget {
  const DiscountTagWidget({
    super.key,
    required this.productModel,
    this.positionedTop = 10,
    this.positionedLeft = 0,
    this.positionedRight = 0,
  });

  final Product productModel;
  final double positionedTop;
  final double positionedLeft;
  final double positionedRight;

  @override
  Widget build(BuildContext context) {
    final bool isLtr  = Provider.of<LocalizationController>(context, listen: false).isLtr;

    return Positioned(
    //  top: positionedTop, left: isLtr ? positionedLeft : null, right: !isLtr ? positionedRight : null,
      bottom: 10,
      left: Dimensions.paddingSizeSmall,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/discount-tag.png", // your image
            width: 65,
            height: 35,
            fit: BoxFit.contain,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Center(
                child: Text(
                  productModel.clearanceSale != null ?
                  PriceConverter.percentageCalculation(context, productModel.unitPrice, productModel.clearanceSale?.discountAmount, productModel.clearanceSale?.discountType) :
                  PriceConverter.getFormattedDiscount( productModel.discount, productModel.discountType)! + " Off",

                  style: textBold.copyWith(color: Colors.white,
                      fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}