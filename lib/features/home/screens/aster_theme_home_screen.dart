import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banners_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/footer_banner_slider_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/single_banner_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widgets/category_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/clearance_sale/widgets/clearance_sale_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/screens/featured_deal_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/screens/flash_deal_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/widgets/featured_deal_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/flash_deal_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/order_again_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/top_store_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/announcement_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/find_what_you_need_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/more_store_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/order_again_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/featured_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/just_for_you/just_for_you_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/product_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/product_type_popup_menu_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/search_home_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/home_category_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/latest_product_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/recommended_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/screens/search_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/all_shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/more_store_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/top_seller_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/all_vouchers_list_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/voucher_details_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/voucher_banners_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/voucher_rules_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import '../../../helper/date_converter.dart';
import '../../../helper/price_converter.dart';
import '../../notification/screens/notification_screen.dart';
import '../../vouchers/widgets/voucher_time_card.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../../vouchers/widgets/winner_auto_slider.dart';

class AsterThemeHomeScreen extends StatefulWidget {
  const AsterThemeHomeScreen({super.key});

  @override
  State<AsterThemeHomeScreen> createState() => _AsterThemeHomeScreenState();

  static Future<void> loadData(bool reload) async {
    final categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    final bannerController = Provider.of<BannerController>(Get.context!, listen: false);
    final productController = Provider.of<ProductController>(Get.context!, listen: false);
    final cartController = Provider.of<CartController>(Get.context!, listen: false);
    final notificationController = Provider.of<NotificationController>(Get.context!, listen: false);
    final addressController = Provider.of<AddressController>(Get.context!, listen: false);
    cartController.getCartData(Get.context!);
    bannerController.getBannerList();
    categoryController.getCategoryList(reload);
    categoryController.getVouchers();
    categoryController.getWinners();
    productController.getHomeCategoryProductList(reload);
    productController.getLatestProductList(1, isUpdate: false);
    productController.getJustForYouProduct(1, isUpdate: reload);
    productController.getRecommendedProduct();
    notificationController.getNotificationList(1);
    addressController.getDefaultAddress();
  }
}

class _AsterThemeHomeScreenState extends State<AsterThemeHomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _marqueeScrollController = ScrollController();

 // late ScrollController _scrollController;
  late AnimationController _animationController;
  late AnimationController _notificationAnimationController;
  late Animation<double> _notificationPulseAnimation;
  late Animation<double> _notificationTiltAnimation;

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;


  @override
  void initState() {
    super.initState();

    singleVendor = Provider.of<SplashController>(context, listen: false).configModel!.businessMode == "single";
    Provider.of<AddressController>(context, listen: false).getDefaultAddress();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 15))
      ..addListener(_scrollMarquee)
      ..repeat();

    _notificationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _notificationPulseAnimation = Tween<double>(begin: 0.96, end: 1.08).animate(
      CurvedAnimation(parent: _notificationAnimationController, curve: Curves.easeInOut),
    );

    _notificationTiltAnimation = Tween<double>(begin: -0.06, end: 0.06).animate(
      CurvedAnimation(parent: _notificationAnimationController, curve: Curves.easeInOut),
    );
  }

  void _scrollMarquee() {
    if (_marqueeScrollController.hasClients) {
      _marqueeScrollController.jumpTo(
        (_animationController.value *
            _marqueeScrollController.position.maxScrollExtent) +
            0.1,
      );
    }
  }

  String getTimeRemaining(String dateStr) {
    try {
      final endDate = DateTime.parse(dateStr); // Parses ISO date format like "2025-07-31"
      final now = DateTime.now();
      final difference = endDate.difference(now);

      if (difference.isNegative) {
        return "Expired";
      }

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      return "${days}d ${hours}h ${minutes}m ${seconds}s Remaining";
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _notificationAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF2F2F2),

      /// ✅ NORMAL APP BAR
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 68,
        backgroundColor: const Color(0xFFF7F8FB),
        centerTitle: false,
        title: Image.asset(
          Images.logoImage,
          height: 35,
        ),
        actions: [
          TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(
              begin: const Offset(1.2, 0),
              end: Offset.zero,
            ),
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOutCubic,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(offset.dx * 30, 0),
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Consumer<NotificationController>(
                builder: (context, notificationController, _) {
                  final String notificationCount = notificationController.notificationModel?.newNotificationItem.toString() ?? '0';
                  final bool hasNotification = notificationCount != '0';

                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationScreen()),
                      );
                    },
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedBuilder(
                          animation: _notificationAnimationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: hasNotification ? _notificationTiltAnimation.value : 0,
                              child: Transform.scale(
                                scale: hasNotification ? _notificationPulseAnimation.value : 1,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: hasNotification
                                  ? Theme.of(context).primaryColor.withValues(alpha: 0.10)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              Images.notification,
                              height: Dimensions.iconSizeDefault,
                              width: Dimensions.iconSizeDefault,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        if (hasNotification)
                          Positioned(
                            top: -6,
                            right: -8,
                            child: AnimatedBuilder(
                              animation: _notificationAnimationController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _notificationPulseAnimation.value,
                                  child: child,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: <Color>[Color(0xFFFF6B6B), Color(0xFFE03131)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x33E03131),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                constraints: const BoxConstraints(minWidth: 20),
                                child: Text(
                                  notificationCount,
                                  textAlign: TextAlign.center,
                                  style: titilliumSemiBold.copyWith(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await AsterThemeHomeScreen.loadData(true);
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔔 ANNOUNCEMENT
                if (Provider.of<SplashController>(context, listen: false)
                    .configModel
                    ?.announcement
                    ?.status ==
                    '1')
                  Consumer<SplashController>(
                    builder: (context, splash, _) {
                      final announcement =
                          splash.configModel?.announcement;
                      return (announcement?.announcement != null &&
                          splash.onOff)
                          ? AnnouncementWidget(
                        announcement: announcement!,
                      )
                          : const SizedBox();
                    },
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                  child: Consumer<AddressController>(
                    builder: (context, addressController, _) {
                      final address = addressController.defaultAddress;
                      final bool hasAddress = address != null;

                      return InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AddressListScreen()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFFFFF), Color(0xFFF1F4FF)],
                            ),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xFFDDE5FF)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x120F172A),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDF3FF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF2854C5),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: addressController.isDefaultAddressLoading
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(width: 90, height: 10, color: const Color(0xFFE6EBF7)),
                                          const SizedBox(height: 8),
                                          Container(width: double.infinity, height: 12, color: const Color(0xFFE6EBF7)),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hasAddress ? 'Deliver to' : 'Location not set',
                                            style: textBold.copyWith(
                                              color: const Color(0xFF1C274C),
                                              fontSize: Dimensions.fontSizeDefault,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            hasAddress
                                                ? '${address.address ?? ''}, ${address.city ?? ''}'
                                                : 'Add Address',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textRegular.copyWith(
                                              color: hasAddress ? const Color(0xFF5B6480) : const Color(0xFF2854C5),
                                              fontSize: Dimensions.fontSizeDefault,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Color(0xFF7A84A8),
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchScreen(from: "home")),
                    );
                  },
                  child: const Hero(
                    tag: 'search',
                    child: Material(
                      color: Colors.transparent,
                      child: SearchHomePageWidget(),
                    ),
                  ),
                ),

                /// 🏆 WINNER AUTO SLIDER
                Consumer<CategoryController>(
                  builder: (context, categoryProvider, _) {
                    return WinnerAutoSlider(
                      voucherWinnerList:
                      categoryProvider.voucherWinnerList ?? [],
                    );
                  },
                ),

                const BannersWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                const VoucherRulesWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                /// 🎟️ VOUCHERS HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Exclusive vouchers",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                const AllVouchersListPage()),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0059D6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🎫 VOUCHER LIST
                Consumer<CategoryController>(
                  builder: (context, categoryProvider, _) {
                    final list = categoryProvider.voucherList ?? [];
                    return SizedBox(
                      height: 450,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return _voucherCard(
                              context, list[index]);
                        },
                      ),
                    );
                  },
                ),

                /// 📂 CATEGORY
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),
                const CategoryListWidget(isHomePage: true),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                const RecommendedProductWidget(
                    fromAsterTheme: true),
                const LatestProductListWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                const HomeCategoryProductWidget(isHomePage: true),
                const SizedBox(height: Dimensions.paddingSizeDefault),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🎫 SINGLE VOUCHER CARD
Widget _voucherCard(BuildContext context, voucherBean) {
  return InkWell(
    onTap: () {
      if (Provider.of<AuthController>(context, listen: false)
          .isLoggedIn()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                VoucherDetailsPage(voucherBean, "home"),
          ),
        );
      } else {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) =>
          const NotLoggedInBottomSheetWidget(),
        );
      }
    },
    child: Container(
      width: 200,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Theme.of(context).primaryColor,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomImageWidget(
                image: voucherBean.image!,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                voucherBean.value == "0.00"
                    ? "Free"
                    : PriceConverter.convertPrice(
                  context,
                  double.parse(voucherBean.value!),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              voucherBean.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 4),
            child: Text(
              voucherBean.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
              const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.access_time,
                    size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  'Valid until ${voucherBean.endDate}',
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: VoucherTimerCard(
              endDateString: voucherBean.endDate!,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Claim Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
