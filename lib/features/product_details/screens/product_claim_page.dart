import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/html_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/business_pages_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../vouchers/model/voucher_request.dart';
import '../../vouchers/widgets/voucher_rules_widget.dart';

class ProductClaimPage extends StatefulWidget {
  final ProductDetailsModel product;
  const ProductClaimPage({super.key, required this.product});

  @override
  State<ProductClaimPage> createState() => _ProductClaimPageState();
}

class _ProductClaimPageState extends State<ProductClaimPage> {
  bool _agreed = false;
  bool _isLoading = false;
  late Razorpay _razorpay;
  late TextEditingController _amountController = TextEditingController();
  CategoryController? _categoryController;
  final FocusNode focusNode = FocusNode();
  var request = VoucherRequest();
  @override
  void initState() {
    super.initState();
    _categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    Provider.of<ProfileController>(context, listen: false).getUserInfo(context);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  BusinessPageModel? getPageBySlug(String slug, List<BusinessPageModel>? pagesList) {
    BusinessPageModel? pageModel;
    if (pagesList != null && pagesList.isNotEmpty) {
      for (var page in pagesList) {
        if (page.slug == slug) {
          pageModel = page;
        }
      }
    }
    return pageModel;
  }

  void _onTermsTap(SplashController provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HtmlViewScreen(
          page: getPageBySlug('terms-and-conditions', provider.defaultBusinessPages),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    _categoryController?.saveVoucher(request, context, "product", "");
    showCustomSnackBar('Payment successful', context, isError: false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    showCustomSnackBar('Payment failed', context, isToaster: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    showCustomSnackBar('External wallet payment cancelled', context, isToaster: true);
  }

  void _openRazorpay(String payableAmount) {
    final profile = Provider.of<ProfileController>(context, listen: false).userInfoModel;
    final String username = profile?.name ?? 'Brilldaddy User';
    final String mobileNumber = profile?.phone ?? '';
    final String email = profile?.email ?? '';

    final options = {
      'key': 'rzp_live_RPSw9Xc04uoU3V',
      'amount': (double.tryParse(payableAmount) ?? 0) * 100,
      'order_id': _categoryController?.razorPayOrderId,
      'name': username,
      'description': widget.product.productVoucherTitle ?? widget.product.name ?? '',
      'prefill': {
        'contact': mobileNumber,
        'email': email,
      }
    };

    _razorpay.open(options);
  }

  Future<void> _onProceedPressed() async {
    if (!_agreed) {
      showCustomSnackBar('I agree to continue', context);
      return;
    }

    final String payableAmount = _amountController.text.trim();
    final String claimAmount = widget.product.claimAmount ?? widget.product.productVoucherAmount ?? payableAmount;
    request.amount = widget.product.productVoucherPaymentAmount;
    request.voucherId = widget.product.id.toString();
    if ((double.tryParse(payableAmount) ?? 0) <= 0) {
      showCustomSnackBar('Invalid payable amount', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });



    await _categoryController?.getRazorpayOrderId(
        widget.product.productVoucherPaymentAmount.toString() ,
      widget.product.id ?? 0,
      claimAmount,
      "product"
    );

    if (!mounted) return;

    if ((_categoryController?.razorPayOrderId ?? '').isNotEmpty) {
      _openRazorpay(widget.product.productVoucherPaymentAmount.toString());
    } else {
      setState(() {
        _isLoading = false;
      });
      showCustomSnackBar('Unable to start payment', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String payableAmount = widget.product.productVoucherPaymentAmount ?? '0.00';

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.product.name ?? getTranslated('product_details', context),
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VoucherRulesWidget(),
            const SizedBox(height: 12),
            ProductImageWidget(productModel: widget.product),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productVoucherTitle?.isNotEmpty == true
                        ? widget.product.productVoucherTitle!
                        : (widget.product.name ?? 'Product claim'),
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.productVoucherDescription?.isNotEmpty == true
                        ? widget.product.productVoucherDescription!
                        : 'Claim this product by completing the payment below.',
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).hintColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _ClaimInfoCard(
                    title: 'Payable amount',
                    value: PriceConverter.convertPrice(
                      context,
                      double.tryParse(payableAmount),
                    ),
                    accentColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: .15)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreed,
                          onChanged: (v) => setState(() => _agreed = v ?? false),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree to the ',
                                style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: textBold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => _onTermsTap(
                                            Provider.of<SplashController>(context, listen: false),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E8),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFFFE1A8)),
                    ),
                    child: Text(
                      'You need to pay only the payable amount to continue the claim process.',
                      style: textRegular.copyWith(
                        color: const Color(0xFF8A5A00),
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_agreed) ...[
                    const SizedBox(height: 10),
                    if(_agreed)
                      Container(
                        width: double.infinity,
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            widget.product.productVoucherPaymentAmount == "0.00"
                                ? "Free"
                                : PriceConverter.convertPrice(
                              context,
                              double.parse(widget.product.productVoucherPaymentAmount!),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if(Platform.isAndroid)
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: "Enter your Favourite Amount",
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    if(Platform.isIOS)
                      CupertinoTextField(
                        controller: _amountController,
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        placeholder: "Enter your Favourite Amount",
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        /// 🔥 iOS DONE BUTTON
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text("Done"),
                          onPressed: () => focusNode.unfocus(),
                        ),
                      )
                  ],
                  SizedBox(height: 20,),
                  if (_agreed)
                    (!_isLoading
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: _onProceedPressed,
                              child: Text(
                                'Proceed to payment (${PriceConverter.convertPrice(context, double.tryParse(payableAmount))})',
                                style: textBold.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        : const Center(
                            child: SizedBox(
                              height: 42,
                              width: 42,
                              child: CircularProgressIndicator(),
                            ),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color accentColor;

  const _ClaimInfoCard({
    required this.title,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withValues(alpha: .20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textRegular.copyWith(
              color: Theme.of(context).hintColor,
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: textBold.copyWith(
              color: accentColor,
              fontSize: Dimensions.fontSizeExtraLarge,
            ),
          ),
        ],
      ),
    );
  }
}
