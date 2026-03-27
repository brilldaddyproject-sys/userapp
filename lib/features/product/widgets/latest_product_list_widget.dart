import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/slider_product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:provider/provider.dart';



class LatestProductListWidget extends StatelessWidget {
  const LatestProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProductController, ProductModel?>(
      selector: (ctx, productController)=> productController.latestProductModel,
      builder: (context, latestProductModel, child) {
        return (latestProductModel?.products?.isNotEmpty ?? false)  ? Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/lat-bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( children: [
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color:  Colors.deepPurpleAccent, // Blue color
                    borderRadius: BorderRadius.circular(16), // Fully rounded capsule
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated('latest_products', context)!,
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewAllProductScreen(productType: ProductType.featuredProduct)));
                          },
                          child: Container(
                            height: 20,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white, // Blue color
                              borderRadius: BorderRadius.circular(50), // Fully rounded capsule
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeSmall),


              SizedBox(
                height: ResponsiveHelper.isTab(context)? MediaQuery.of(context).size.width * .58 : 285,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: ResponsiveHelper.isTab(context)? .5 :.65,
                    autoPlay: false,
                    pauseAutoPlayOnTouch: true,
                    pauseAutoPlayOnManualNavigate: true,
                    enlargeFactor: 0.2,
                    enlargeCenterPage: true,
                    pauseAutoPlayInFiniteScroll: true,
                    disableCenter: true,
                  ),
                  itemCount: latestProductModel?.products?.length,
                  itemBuilder: (context, index, next) {
                    return ProductWidget(productModel: latestProductModel!.products![index], productNameLine: 1);
                  },
                ),
              ),




            ]),
          ),
        ) : latestProductModel == null ? const SliderProductShimmerWidget() : const SizedBox();
      },
    );
  }
}

