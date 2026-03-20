
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../../../utill/dimensions.dart';
import '../../banner/widgets/banner_shimmer.dart';

class VoucherBannersWidget extends StatelessWidget {
  const VoucherBannersWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {

          double width = MediaQuery.of(context).size.width;
          return Stack(children: [
            categoryProvider.voucherList != null ? categoryProvider.voucherList!.isNotEmpty ?
            SizedBox(height: width * 0.4,width: width,
              child: Column(children: [
                SizedBox(height: width * 0.33, width: width,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                        aspectRatio: 4/1,
                        viewportFraction: 0.8,
                        autoPlay: true,
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayOnManualNavigate: true,
                        pauseAutoPlayInFiniteScroll: true,
                        enlargeFactor: .2,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          Provider.of<CategoryController>(context, listen: false).setCurrentIndex(index);}),
                    itemCount: categoryProvider.voucherList!.isEmpty ? 1 : categoryProvider.voucherList?.length,
                    itemBuilder: (context, index, _) {

                      return InkWell(
                        onTap: () {

                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: Container(decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                              color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Theme.of(context).primaryColor.withValues(alpha:.1) :
                              Theme.of(context).primaryColor.withValues(alpha:.05)),
                              child: CustomImageWidget(image: '${categoryProvider.voucherList?[index].image}')
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              ),
            ) : const SizedBox() : const BannerShimmer(),
          ],
          );
        },
      ),
      const SizedBox(height: 5),
    ],
    );
  }
}
