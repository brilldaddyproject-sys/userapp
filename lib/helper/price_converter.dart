import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:provider/provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' || discountType == 'flat') {
        price = price! - discount;
      }else if(discountType == 'percent' || discountType == 'percentage') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool singleCurrency = Provider.of<SplashController>(context, listen: false).configModel!.currencyModel == 'single_currency';
    bool inRight = Provider.of<SplashController>(context, listen: false).configModel!.currencySymbolPosition == 'right';

    // return '${inRight ? '' : Provider.of<SplashController>(context, listen: false).myCurrency!.symbol}'
    //     '${(singleCurrency? price : price! * Provider.of<SplashController>(context, listen: false).myCurrency!.exchangeRate!
    //     * (1/Provider.of<SplashController>(context, listen: false).usdCurrency!.exchangeRate!))!.toStringAsFixed(Provider.of<SplashController>(context,listen: false).configModel!.decimalPointSettings??1).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
    //     '${inRight ? Provider.of<SplashController>(context, listen: false).myCurrency!.symbol : ''}';

    try{
      return '${inRight ? '' : Provider.of<SplashController>(context, listen: false).myCurrency!.symbol}'
          '${(singleCurrency? price : price! * Provider.of<SplashController>(context, listen: false).myCurrency!.exchangeRate!
          * (1/Provider.of<SplashController>(context, listen: false).usdCurrency!.exchangeRate!))!.toStringAsFixed(Provider.of<SplashController>(context,listen: false).configModel!.decimalPointSettings??1).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
          '${inRight ? Provider.of<SplashController>(context, listen: false).myCurrency!.symbol : ''}';
    }catch(e) {
      return price.toString();
      // print(e.toString());
    }

  }

  static double? convertWithDiscount(BuildContext context, double? price, double? discount, String? discountType) {
    if(discountType == 'amount' || discountType == 'flat') {
      price = price! - discount!;
    }else if(discountType == 'percent' || discountType == 'percentage') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    if (discount == null) return '';

    if (discountType == 'percent' || discountType == 'percentage') {
      // Remove trailing zeros and decimal point if unnecessary
      String discountStr = discount.toStringAsFixed(0).replaceAll(RegExp(r'\.0+$'), '');
      return '$discountStr %';
    } else {
      String discountStr = double.parse(convertPrice(context, discount)).toStringAsFixed(2).replaceAll(RegExp(r'\.0+$'), '');
      return '$discountStr %';
    }
  }

  static String? getFormattedDiscount(double? discount, String? discountType) {
    if (discount != null && discountType != null) {
      if (discountType == 'percent' || discountType == 'percentage') {
        return '${discount.toStringAsFixed(0)}%'; // e.g., "25%"
      } else if (discountType == 'amount' || discountType == 'flat') {
        return '₹${discount.toStringAsFixed(0)}'; // e.g., "₹50"
      }
    }
    return null;
  }

  static String getUnitCurrency (BuildContext context, double? price) {
    bool singleCurrency = Provider.of<SplashController>(context, listen: false).configModel!.currencyModel == 'single_currency';
    bool inRight = Provider.of<SplashController>(context, listen: false).configModel!.currencySymbolPosition == 'right';

    return '${inRight ? '' : Provider.of<SplashController>(context, listen: false).myCurrency!.symbol}'
      '${(singleCurrency? price : price!)!
        .toStringAsFixed(Provider.of<SplashController>(context,listen: false).configModel!.decimalPointSettings??1).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
      '${inRight ? Provider.of<SplashController>(context, listen: false).myCurrency!.symbol : ''}';
  }


}