import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/wishlist_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/wishlist_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
      Provider.of<WishListController>(context, listen: false).getWishList();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('wishList', context)),
      resizeToAvoidBottomInset: true,
      body: Column(children: [
        Consumer<WishListController>(builder: (context, wishListProvider, child) {
       return  wishListProvider.wishList!=null && wishListProvider.wishList!.isNotEmpty ?InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
           _showClearCartDialog(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete_outline, size: 18, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  'Clear All',
                  style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ):Container();
    }),
        SizedBox(height: 10,),
        Expanded(child: !Provider.of<AuthController>(context, listen: false).isLoggedIn()
            ? const NotLoggedInWidget()
            : Consumer<WishListController>(builder: (context, wishListProvider, child) {
          return wishListProvider.wishList != null
              ? wishListProvider.wishList!.isNotEmpty
              ? RefreshIndicator(
              onRefresh: () async => await  wishListProvider.getWishList(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: wishListProvider.wishList!.length,
                itemBuilder: (context, index) => WishListWidget(wishlistModel: wishListProvider.wishList?[index], index: index),
              ))
              : const NoInternetOrDataScreenWidget(isNoInternet: false, message: 'no_wishlist_product', icon: Images.noWishlist)
              : const WishListShimmer();
        })),
      ]),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 50),
                const SizedBox(height: 16),
                Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Do you really want to clear the data?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                         // cart.deleteCartAll();
                          Provider.of<WishListController>(context, listen: false).clearWishList();
                        },
                        child: const Text("Clear", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


}


