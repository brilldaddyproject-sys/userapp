import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/discount_tag_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/recommended_product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:provider/provider.dart';


class RecommendedProductWidget extends StatelessWidget {
  final bool fromAsterTheme;
  const RecommendedProductWidget({super.key,  this.fromAsterTheme = false});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool isLtr  = Provider.of<LocalizationController>(context, listen: false).isLtr;
    return Container(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
      color: Color(0xFFFFCBE3),
      child: Column(children: [
          Consumer<ProductController>(
            builder: (context, recommended, child) {
              String? ratting = recommended.recommendedProduct != null && recommended.recommendedProduct!.rating != null &&
                  recommended.recommendedProduct!.rating!.isNotEmpty? recommended.recommendedProduct!.rating![0].average : "0";

              return  recommended.recommendedProduct != null?
              InkWell(onTap: () {
                Navigator.push(context, PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 1000),
                  pageBuilder: (context, anim1, anim2) => ProductDetails(productId: recommended.recommendedProduct!.id,
                    slug: recommended.recommendedProduct!.slug)));
                },
                child: Stack(children: [


                    Column(children: [


                          Column(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't Miss The Deal!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 8),
                                            blurRadius: 22,
                                            color: Colors.white.withOpacity(0.6),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Let's Shopping Today",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 8),
                                            blurRadius: 22,
                                            color: Colors.white.withOpacity(0.6),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ]),

                      SizedBox(height: 10,),

                        Stack(children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                borderRadius:  const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                                color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                Theme.of(context).highlightColor : Theme.of(context).highlightColor,
                                border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha:.3),width: 1)
                              ),
                                child: Row(children: [
                                  recommended.recommendedProduct !=null && recommended.recommendedProduct!.thumbnail !=null?
                                  Container(
                                    // height: (recommended.recommendedProduct!.currentStock! < recommended.recommendedProduct!.minimumOrderQuantity! &&
                                    //     recommended.recommendedProduct!.productType == 'physical')? 170:150,
                                    decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                                        border: Border.all(color: Theme.of(context).primaryColor,width: .5),
                                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                                    child: LayoutBuilder(builder: (context, boxConstraint)=> ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          child: Stack(
                                            children: [

                                             Stack(
                                               children: [
                                                 CustomImageWidget(
                                                   height: ResponsiveHelper.isTab(context) ? 250 :  size.width * 0.4,
                                                   width: ResponsiveHelper.isTab(context) ? 230 : size.width * 0.4,
                                                   image: '${recommended.recommendedProduct?.thumbnailFullUrl?.path}',
                                                 ),
                                                 Positioned(
                                                     child: FavouriteButtonWidget(
                                                         backgroundColor: Provider
                                                             .of<
                                                             ThemeController>(
                                                             context)
                                                             .darkTheme ?
                                                         Theme
                                                             .of(context)
                                                             .cardColor : Theme
                                                             .of(context)
                                                             .primaryColor,
                                                         productId: recommended
                                                             .recommendedProduct
                                                             ?.id),top: 8, right: 10,),
                                               ],
                                             ),



                                              if(recommended.recommendedProduct!.currentStock! == 0 &&
                                                  recommended.recommendedProduct!.productType == 'physical')
                                                Positioned.fill(child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  width: ResponsiveHelper.isTab(context) ? 230 : size.width * 0.4,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).colorScheme.error.withValues(alpha:0.4),
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(Dimensions.radiusSmall),
                                                        topRight: Radius.circular(Dimensions.radiusSmall),
                                                      )
                                                  ),
                                                  child: Text(
                                                    getTranslated('out_of_stock', context)??'',
                                                    style: textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )),
                                            ],
                                          )
                                        )
                                    )) : const SizedBox(),

                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Expanded(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        const SizedBox(height: 4,),


                                        SizedBox(width: MediaQuery.of(context).size.width/2.5,
                                          child: Text(recommended.recommendedProduct!.name??'',maxLines: 2, overflow: TextOverflow.ellipsis,
                                              style: textRegular.copyWith(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color ))),
                                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                                        FittedBox(
                                            child: Row(children: [
                                              const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall),

                                              recommended.recommendedProduct != null && recommended.recommendedProduct!.unitPrice != null?
                                              Text(PriceConverter.convertPrice(context, recommended.recommendedProduct!.unitPrice,
                                                  discountType: (recommended.recommendedProduct?.clearanceSale?.discountAmount ?? 0) > 0
                                                      ? recommended.recommendedProduct?.clearanceSale?.discountType
                                                      : recommended.recommendedProduct?.discountType,

                                                  discount: (recommended.recommendedProduct?.clearanceSale?.discountAmount ?? 0) > 0
                                                      ?  recommended.recommendedProduct?.clearanceSale?.discountAmount
                                                      : recommended.recommendedProduct?.discount),
                                                  style: textBold.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color,
                                                      fontSize: 14)) : const SizedBox(),


                                              recommended.recommendedProduct !=null && recommended.recommendedProduct!.discount!= null &&
                                                  recommended.recommendedProduct!.discount! > 0 || (recommended.recommendedProduct?.clearanceSale?.discountAmount ?? 0) > 0 ?
                                              Text(
                                                PriceConverter.convertPrice(context, recommended.recommendedProduct!.unitPrice),
                                                style: textRegular.copyWith(color: Theme.of(context).hintColor,
                                                  decoration: TextDecoration.lineThrough, fontSize: 12,),
                                              ) : const SizedBox.shrink(),
                                              const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall,
                                                  width: Dimensions.paddingSizeExtraSmall),


                                            ])),
                                        const SizedBox(height: 4,),
                                        Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          Icon(Icons.star, color: Provider.of<ThemeController>(context).darkTheme ?
                                          Colors.white : Colors.orange, size: 15),

                                          Text(double.parse(ratting!).toStringAsFixed(1),
                                              style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeDefault)),

                                          Text('(${ recommended.recommendedProduct?.reviewCount ?? '0'})', style:
                                          textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                              color: Theme.of(context).hintColor)),]),

                                        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                                          child: Container(width: 110,height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
                                              color: Theme.of(context).primaryColor),
                                            child: Center(child: Text(getTranslated('buy_now', context)!,
                                              style: const TextStyle(color: Colors.white)))))
                                      ],),
                                  ),
                                ],
                                ),
                              ),
                            ),
                          recommended.recommendedProduct !=null && recommended.recommendedProduct!.discount!= null &&
                            ((recommended.recommendedProduct!.discount! > 0) || (recommended.recommendedProduct?.clearanceSale?.discountAmount ?? 0) > 0)  ?
                            DiscountTagWidget(
                              productModel: recommended.recommendedProduct!,
                              positionedTop : 25,
                              positionedLeft : 32,
                              positionedRight : 32
                            ) : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ):const RecommendedProductShimmer();

            },
          ),
        ],
      ),
    );
  }


}

