import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/coupon_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class CouponApplyWidget extends StatelessWidget {
  final TextEditingController couponController;
  final double orderAmount;
  const CouponApplyWidget({super.key, required this.couponController, required this.orderAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: DottedBorder(
        color: Colors.orange,
        strokeWidth: 1.5,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        child: Consumer<CouponController>(
            builder: (context, couponProvider, _) {
              return Container(width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E8), // Light cream background
                  borderRadius: BorderRadius.circular(12),
                ),

                child: (couponProvider.discount != null && couponProvider.discount != 0)?
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        SizedBox(height: 25,width: 25, child: Image.asset(Images.appliedCoupon)),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          child: Text(couponProvider.couponCode, style: textBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color),),),

                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                            child: Text('(-${PriceConverter.convertPrice(context, couponProvider.discount)} off)',
                                style: textMedium.copyWith(color: Theme.of(context).primaryColor)))]),

                      InkWell(onTap: ()=> couponProvider.removeCoupon(),
                          child: Icon(Icons.clear, color: Theme.of(context).colorScheme.error))])): InkWell(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (c) =>
                            CouponBottomSheetWidget(orderAmount: orderAmount)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${getTranslated('add_coupon', context)}',
                          style: textMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                        //   Text('${getTranslated('add_more', context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Add +",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
            }
        ),
      ),
    );
  }
}
