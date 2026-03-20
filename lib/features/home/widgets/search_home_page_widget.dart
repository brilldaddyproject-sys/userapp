import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SearchHomePageWidget extends StatelessWidget {
  const SearchHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(padding:  const EdgeInsets.symmetric(
          horizontal: Dimensions.homePagePadding, vertical: Dimensions.paddingSizeSmall),

        alignment: Alignment.center,
        child: Container(padding:  EdgeInsets.only(
          left: Provider.of<LocalizationController>(context, listen: false).isLtr?
          Dimensions.homePagePadding : Dimensions.paddingSizeExtraSmall,
            right: Provider.of<LocalizationController>(context, listen: false).isLtr? Dimensions.paddingSizeExtraSmall : Dimensions.homePagePadding),
          height: 65, alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color:  Theme.of(context).primaryColor, // Light cream background
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Text(
                "Search Product",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),

              // Search Button
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726), // Orange color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset("assets/images/search-home.png",),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
