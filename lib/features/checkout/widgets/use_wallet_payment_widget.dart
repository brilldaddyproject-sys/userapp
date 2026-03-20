


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../controllers/checkout_controller.dart';

class UseWalletPaymentWidget extends StatefulWidget {
  final double rotateAngle;
  final double orderAmount;
  final double currentBalance;
  final Function(double amount)? onTap;

  const UseWalletPaymentWidget({
    super.key,
    this.rotateAngle = 0,
    required this.onTap,
    required this.orderAmount,
    required this.currentBalance,
  });

  @override
  State<UseWalletPaymentWidget> createState() => _UseWalletPaymentWidgetState();
}

class _UseWalletPaymentWidgetState extends State<UseWalletPaymentWidget> {
  late TextEditingController amountController;
  late FocusNode amountFocus;

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController();
    amountFocus = FocusNode();

    // 🔑 Auto focus after dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(amountFocus);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    amountFocus.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (amountController.text.isNotEmpty && amountController.text != "0") {
      double enteredAmount = double.tryParse(amountController.text) ?? 0;
      widget.onTap?.call(enteredAmount);
      Navigator.pop(context);
    } else {
      showCustomSnackBar("Invalid Amount", Get.context!, isToaster: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green, // Orange color
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated('wallet_payment', context)!,
                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Colors.white),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(child: Icon(Icons.clear,color: Colors.white,)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                Text(getTranslated('your_current_balance', context)!,
                    style: textRegular),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withValues(alpha: .1),
                    border: Border.all(width: .5, color: Theme.of(context).hintColor),
                    borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  ),
                  child: Text(
                      PriceConverter.convertPrice(context, widget.currentBalance)),
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(
                  children: [
                    Text("Wallet Amount Applied", style: textRegular),
                  ],
                ),
                const Text(
                  "[You can use your wallet amount only for brilldaddy brand products.]",
                  style: TextStyle(fontSize: 10, color: Colors.red),
                ),

                const SizedBox(height: Dimensions.paddingSizeSmall),

                // ---- TextField ----
                TextField(
                  controller: amountController,
                  focusNode: amountFocus, // ✅ Auto focus here
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submit(context),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    filled: true,
                    fillColor: Theme.of(context).hintColor.withValues(alpha: .1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Theme.of(context).hintColor),
                      borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0, color: Theme.of(context).primaryColor),
                      borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),

                Text("Remaining Amount to Pay.", style: textRegular),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withValues(alpha: .1),
                    border: Border.all(width: .5, color: Theme.of(context).hintColor),
                    borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  ),
                  child: Text(PriceConverter.convertPrice(
                      context, (widget.currentBalance - widget.orderAmount))),
                ),

                const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                // ---- Buttons ----
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: getTranslated('cancel', context),
                        backgroundColor: Theme.of(context).hintColor,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: CustomButton(
                        buttonText: getTranslated('submit', context),
                        onTap: () => _submit(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

