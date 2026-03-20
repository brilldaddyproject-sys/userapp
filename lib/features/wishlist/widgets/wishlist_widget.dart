import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_asset_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_directionality_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/domain/models/wishlist_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/remove_from_wishlist_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class WishListWidget extends StatelessWidget {
  final WishlistModel? wishlistModel;
  final int? index;
  const WishListWidget({super.key, this.wishlistModel, this.index});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = Provider.of<LocalizationController>(context, listen: false).isLtr;
  //print(wishlistModel?.productFullInfo?.discount);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (context, anim1, anim2) => ProductDetails(
              productId: wishlistModel?.productFullInfo?.id,
              slug: wishlistModel?.productFullInfo?.slug,
              isFromWishList: true,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        margin: const EdgeInsets.only(top: Dimensions.marginSizeSmall),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha:0.05),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 1)
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [

              Positioned(
                bottom: 0, right: 5,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
                        pageBuilder: (context, anim1, anim2) => ProductDetails(
                          productId: wishlistModel?.productFullInfo?.id,
                          slug: wishlistModel?.productFullInfo?.slug,
                          isFromWishList: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 60,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.white, size: Dimensions.paddingSizeLarge),
                  ),
                ),
              ),



              Row(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(children: [

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        border: Border.all(width: 1, color: Colors.black.withValues(alpha: 0.1)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: CustomImageWidget(
                          width: 70,
                          height: 70,
                          image: '${wishlistModel?.productFullInfo?.thumbnailFullUrl?.path}',
                        ),
                      ),
                    ),
                   // SizedBox(height: 2,),

                  ]),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text(
                        wishlistModel?.productFullInfo?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                      )),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      InkWell(
                        onTap: (){
                          showModalBottomSheet(backgroundColor: Colors.transparent,
                              context: context, builder: (_) => RemoveFromWishlistBottomSheet(
                                  productId : wishlistModel?.productFullInfo?.id, index: index));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeEight),
                          child: CustomAssetImageWidget(Images.delete, color: Theme.of(context).colorScheme.error),
                        ),
                      ),

                    ]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Row(
                        children: [

                  /*    ((wishlistModel?.productFullInfo?.discount != null) || (wishlistModel?.productFullInfo?.clearanceSale != null)) ?
                       const SizedBox(width: Dimensions.paddingSizeSmall) : const SizedBox(),*/

                      Flexible(child: CustomDirectionalityWidget(
                        child: Text(
                          _getProductPrice(context),
                          style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      )),
                      SizedBox(width: 2,),
                      if(_getProductPrice(context) != PriceConverter.convertPrice(context, wishlistModel?.productFullInfo?.unitPrice))
                      CustomDirectionalityWidget(
                        child: Text(
                          wishlistModel?.productFullInfo?.unitPrice != null ?
                          PriceConverter.convertPrice(context, wishlistModel?.productFullInfo?.unitPrice) : '',
                          style: titilliumSemiBold.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                          ),
                        ),
                      ),



                    ]),

                    const Spacer(),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    if(wishlistModel?.productFullInfo?.discount !=0.00)
                      ((wishlistModel?.productFullInfo?.discount != null) || (wishlistModel?.productFullInfo?.clearanceSale != null)) ?
                      Container(
                        height: Dimensions.paddingSizeLarge,
                        width: 80,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF9A825),
                        ),
                        child: Text(_getProductDiscount(context) + "Offer",
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white)),
                      ) : const SizedBox(),

                  ])),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  String _getProductPrice(BuildContext context) {
    return PriceConverter.convertPrice(
                  context, wishlistModel?.productFullInfo?.unitPrice,
                  discountType: (wishlistModel?.productFullInfo?.clearanceSale?.discountAmount ?? 0)  > 0
                      ? wishlistModel?.productFullInfo?.clearanceSale?.discountType
                      : wishlistModel?.productFullInfo?.discountType,
                  discount: (wishlistModel!.productFullInfo?.clearanceSale?.discountAmount ?? 0)  > 0
                      ? wishlistModel?.productFullInfo?.clearanceSale?.discountAmount
                      : wishlistModel?.productFullInfo?.discount,
                );
  }

  String _getProductDiscount(BuildContext context) {
    return (wishlistModel?.productFullInfo!.clearanceSale != null)
        ? percentageCalculation(
      context,
      wishlistModel?.productFullInfo?.unitPrice,
      wishlistModel?.productFullInfo?.clearanceSale?.discountAmount,
      wishlistModel?.productFullInfo?.clearanceSale?.discountType,
    )
        : (wishlistModel?.productFullInfo?.unitPrice != null && wishlistModel?.productFullInfo?.discount != null && wishlistModel?.productFullInfo?.discountType != null)
        ? percentageCalculation(
      context,
      wishlistModel?.productFullInfo?.unitPrice,
      wishlistModel?.productFullInfo?.discount,
      wishlistModel?.productFullInfo?.discountType,
    )
        : '';
  }

   String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    if (discount != null && discountType != null) {
      if (discountType == 'percent' || discountType == 'percentage') {
        // Round to 0 decimals for percentage
        return '${discount.toStringAsFixed(0)}%';
      } else if (discountType == 'amount' || discountType == 'flat') {
        // For amount/flat type, you can return in currency format
        return PriceConverter.convertPrice(context, discount);
      }
    }
    return '';
  }

}
