import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/home_category_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeCategoryProductItemWidget extends StatelessWidget {
  final HomeCategoryProduct homeCategoryProduct;
  final int index;
  final bool isHomePage;
  const HomeCategoryProductItemWidget({super.key, required this.homeCategoryProduct, required this.index, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isEven ? null : Theme.of(context).cardColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        if(isHomePage) ...[
          if(index != 0) const SizedBox(height: Dimensions.paddingSizeSmall),

          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Container(
            /*  decoration: BoxDecoration(
                color:  Colors.black26, // Blue color
                borderRadius: BorderRadius.circular(16), // Fully rounded capsule
              ),*/
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(homeCategoryProduct.name!,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black87),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                            isBrand: false,
                            id: homeCategoryProduct.id,
                            name: homeCategoryProduct.name)));
                      },
                      child: Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0059D6), // Blue color
                          borderRadius: BorderRadius.circular(50), // Fully rounded capsule
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
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

        ],

        ConstrainedBox(constraints: homeCategoryProduct.products!.isNotEmpty ?
        const BoxConstraints(maxHeight: BouncingScrollSimulation.maxSpringTransferVelocity):
        const BoxConstraints(maxHeight: 0),

            child: RepaintBoundary(
              child: MasonryGridView.count(
                  itemCount: (isHomePage && homeCategoryProduct.products!.length > 4) ? 4
                      : homeCategoryProduct.products!.length,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(onTap: () {
                      Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
                          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: homeCategoryProduct.products![i].id,
                              slug: homeCategoryProduct.products![i].slug)));
                    },
                        child: ProductWidget(productModel: homeCategoryProduct.products![i]));
                  }),
            ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],
      ),
    );
  }
}