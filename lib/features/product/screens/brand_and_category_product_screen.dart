import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/debounce_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/product_filter_dialog_widget.dart';
import '../../../helper/responsive_helper.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../../brand/controllers/brand_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../search_product/controllers/search_product_controller.dart';
import '../../search_product/widgets/search_filter_bottom_sheet_widget.dart';
import '../../search_product/widgets/search_product_widget.dart';
import '../../splash/controllers/splash_controller.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final int? id;
  final String? name;
  final String? image;
  final CategoryModel? categoryModel;
  final SubCategory? subCategory;
  final bool isInsideSubSubCategory;
  final bool isAllProduct;

  const BrandAndCategoryProductScreen({
    super.key,
    required this.isBrand,
    required this.id,
    required this.name,
    this.image,
    this.subCategory,
    this.isInsideSubSubCategory = false,
    this.categoryModel,
    this.isAllProduct = false
  });

  @override
  State<BrandAndCategoryProductScreen> createState() => _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState extends State<BrandAndCategoryProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  late List<SubSubCategory>? subSubCategoryList;
  late List<SubCategory>? subCategoryList;

  final DebounceHelper debounceHelper = DebounceHelper(milliseconds: 500);
  ScrollController scrollController = ScrollController();


  void _initializeCategoryList(String categoryName){
    subCategoryList = [];
    subSubCategoryList = [];

    if((widget.subCategory?.subSubCategories?.isNotEmpty ?? false) && widget.id != null){
      subSubCategoryList = widget.subCategory?.subSubCategories?.map((element) => element).toList() ?? [];
      subSubCategoryList?.insert(0, SubSubCategory(
        name: categoryName,
        id: widget.subCategory?.id,
        totalProductCount: widget.subCategory?.totalProductCount,
      ));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        int index = subSubCategoryList!.indexWhere((category) => category.id == widget.id);
        if (index != -1) {
          _horizontalScrollToIndex(index);
        }
      });

    } else if((widget.categoryModel?.subCategories?.isNotEmpty ?? false ) && widget.id != null) {
      subCategoryList = widget.categoryModel?.subCategories?.map((element) => element).toList() ?? [];
      subCategoryList?.insert(0, SubCategory(
        name: categoryName,
        id: widget.categoryModel?.id,
        totalProductCount: widget.categoryModel?.totalProductCount,
      ));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        int index = subCategoryList!.indexWhere((category) => category.id == widget.id);
        if (index != -1) {
          _horizontalScrollToIndex(index);
        }
      });
    }
  }

  void _horizontalScrollToIndex(int index) {
    if(index > 1){
      _categoryScrollController.animateTo(
        index * 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _getProducts(int? id) async {
    await Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(isBrand: widget.isBrand, id: id, offset: 1, isUpdate: false);
  }


  @override
  void initState() {
    if(widget.id != null){
      Provider.of<SearchProductController>(context, listen: false).categoryId=widget.id;
      Provider.of<ProductController>(context, listen: false).updateSelectedCategoryId(id: widget.id!, isUpdate: false);
    }
    _getProducts(widget.id);
    Provider.of<SearchProductController>(context, listen: false).cleanSearchProduct(context);
    Provider.of<SearchProductController>(context, listen: false).setInitialFilerData();


    Provider.of<CategoryController>(context, listen: false).resetChecked(null, false);
    Provider.of<SearchProductController>(context, listen: false).setFilterApply(isFiltered: false);
    Provider.of<CategoryController>(context, listen: false).selectedCategoryIds.clear();
    Provider.of<BrandController>(context, listen: false).selectedBrandIds.clear();
    Provider.of<SearchProductController>(context, listen: false).selectedSellerAuthorIds.clear();
    Provider.of<SearchProductController>(context, listen: false).sellerPublishingHouseIds.clear();
    Provider.of<SearchProductController>(context, listen: false).publishingHouseIds.clear();
    Provider.of<SearchProductController>(context, listen: false).selectedAuthorIds.clear();
    Provider.of<SearchProductController>(context, listen: false).searchProduct(query: "",
      offset: 1,categoryIds: "[${widget.id}]");
    _initializeCategoryList(getTranslated('all_products', Get.context!)!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.name,showActionButton: false,),
      body: SingleChildScrollView(
        child: Consumer<ProductController>(
          builder: (context, productController, child) {
            return Column(children: [
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Consumer<SearchProductController>(
                  builder: (context, searchProvider, child) {
                    return (searchProvider.isLoading && searchProvider.searchedProduct == null) ?
                    ProductShimmer(isHomePage: false, isEnabled : searchProvider.searchedProduct == null) :
                    (searchProvider.searchedProduct != null && searchProvider.isClear) ?
                    ((searchProvider.searchedProduct != null && searchProvider.searchedProduct?.products != null && searchProvider.searchedProduct!.products!.isNotEmpty) || (searchProvider.isSortingApplied || searchProvider.isFilterApplied)) ?
                    SearchProductWidget(isfrom:"category") : const NoInternetOrDataScreenWidget(isNoInternet: false) :Container();
                  },
                ),
              ),

            ]);
          },
        ),
      ),
    );
  }
}

class _CategoryItemWidget extends StatelessWidget {
  final String categoryName;
  final String totalProductCount;
  final bool isSelected;
  final Function()? onTap;
  const _CategoryItemWidget({
    required this.categoryName,
    required this.totalProductCount,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeEight, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              offset: const Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Row(children: [
            Text(categoryName, style: isSelected ? textBold.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).cardColor) : textRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.70),
            )),
            const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),

            Text(totalProductCount, style: isSelected ? textBold.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).cardColor.withValues(alpha: 0.70)) : textRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.70),
            )),

          ]),
        ),
      ),
    );
  }
}
