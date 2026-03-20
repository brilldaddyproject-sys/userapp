

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_request.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/vouchers_response.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../more/screens/html_screen_view.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../../splash/domain/models/business_pages_model.dart';
import '../widgets/voucher_rules_widget.dart';
import '../widgets/voucher_time_card.dart';

class VoucherDetailsPage extends StatefulWidget {

  VoucherModel voucherBean;
  String from;
  VoucherDetailsPage(this.voucherBean, this.from, {super.key});

  @override
  State<VoucherDetailsPage> createState() => _VoucherDetailsPageState();

}

class _VoucherDetailsPageState extends State<VoucherDetailsPage> {

  bool _agreed = false;
  bool _isLoading = false;
  CategoryController? categoryController;
  var amountController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  var _razorpay = Razorpay();
  var request = VoucherRequest();


  BusinessPageModel? getPageBySlug(String slug, List<BusinessPageModel>? pagesList) {
    BusinessPageModel? pageModel;
    if(pagesList != null && pagesList.isNotEmpty){
      for (var page in pagesList) {
        if(page.slug == slug) {
          pageModel = page;
        }
      }
    }
    return pageModel;
  }

  void _onTermsTap(SplashController provider) {

    Navigator.push(context, MaterialPageRoute(builder: (_) =>
        HtmlViewScreen(
            page: getPageBySlug('terms-and-conditions', provider.defaultBusinessPages))));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Provider.of<ProfileController>(context, listen: false).getUserInfo(context);
    categoryController!.doCanBit(widget.voucherBean.id!);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    categoryController!.saveVoucher(request, context,widget.from,widget.voucherBean.value);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    setState(() {
      _isLoading = false;
    });
    showCustomSnackBar("Payment Failed", context, isToaster: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    setState(() {
      _isLoading = false;
    });
    showCustomSnackBar("Payment Failed", context, isToaster: true);
  }

  openRazorpay(String amount){
    String username = Provider.of<ProfileController>(context, listen: false).userInfoModel!.name!;
    String mobileNumber = Provider.of<ProfileController>(context, listen: false).userInfoModel!.phone!;
    String email = Provider.of<ProfileController>(context, listen: false).userInfoModel!.email!;

    var options = {
      'key': 'rzp_live_RPSw9Xc04uoU3V',
      'amount': double.parse(widget.voucherBean.value!) * 100,
      'order_id': categoryController!.razorPayOrderId,
      'name': username,
      'description': '',
      'prefill': {
        'contact': mobileNumber,
        'email': email
      }
    };
    print({
      'key': 'rzp_live_RPSw9Xc04uoU3V',
      'amount': double.parse(widget.voucherBean.value!) * 100,
      'order_id': categoryController!.razorPayOrderId,
      'name': username,
      'description': '',
      'prefill': {
        'contact': mobileNumber,
        'email': email
      }
    });
    _razorpay.open(options);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.voucherBean.title,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<CategoryController>(
            builder: (context, categoryProvider, _) {
                return !categoryProvider.isCanLoading ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const VoucherRulesWidget(),
                    const SizedBox(height: 12),

                    _voucherHeader(context),
                    const SizedBox(height: 16),
                    if(widget.voucherBean.value == "0.00")
                      _termsText(),
                    if(widget.voucherBean.value != "0.00")
                      _paidTermsText(),
                    const SizedBox(height: 12),
                    if(!categoryProvider.isCanBit)
                    Text(
                      "Your limit is exceeded.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    if(categoryProvider.isCanBit)
                    _bidSection(categoryProvider)
                  ],
                ):Center(child: CircularProgressIndicator());
            }),
      ),
    );

  }

  Widget _voucherHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// IMAGE CARD
        Container(
          width: 120,
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomImageWidget(
                image: widget.voucherBean.image!,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        /// DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _priceBadge(context),
              const SizedBox(height: 6),
              Text(
                widget.voucherBean.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.voucherBean.description!,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "Valid until ${widget.voucherBean.endDate}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              VoucherTimerCard(
                endDateString: widget.voucherBean.endDate!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.voucherBean.value == "0.00"
            ? "Free"
            : PriceConverter.convertPrice(
          context,
          double.parse(widget.voucherBean.value!),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _termsText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Terms and Conditions:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Welcome to the Brilldaddy Event, where strategy meets savings in a thrilling dynamic experience!\n\n"
              "If your selection is the single lowest unique amount and you'll win the product absolutely free!\n\n"
              "Check our terms and conditions for the full details and get ready to shine brilliantly!",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _paidTermsText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Terms and Conditions:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Welcome to the Brilldaddy Event, where strategy meets savings in a thrilling dynamic experience!\n\n"
              "The voucher amount will instantly add to your wallet. (No need to pay your enter amount,you need to pay only voucher amount)Participate as many times as you like, shopping our brand products with your voucher amount. If your selection is the single lowest unique amount and you'll win the product absolutely free!\n\n"
              "Check our terms and conditions for the full details and get ready to shine brilliantly!",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _bidSection(CategoryController categoryProvider) {
    return Column(
      children: [

        /// AGREEMENT
        Row(
          children: [
            Checkbox(
              value: _agreed,
              onChanged: (v) => setState(() => _agreed = v ?? false),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "I agree to the ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Terms and Conditions",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _onTermsTap(
                            Provider.of<SplashController>(context, listen: false)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              widget.voucherBean.value == "0.00"
                  ? "Free"
                  : PriceConverter.convertPrice(
                context,
                double.parse(widget.voucherBean.value!),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        /// AMOUNT INPUT
        if (_agreed) ...[
          const SizedBox(height: 10),
          if(Platform.isAndroid)
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: "Enter your Favourite Amount",
              filled: true,
              fillColor: Color(0xFFF1F1F1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if(Platform.isIOS)
            CupertinoTextField(
              controller: amountController,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              placeholder: "Enter your Favourite Amount",
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
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

        const SizedBox(height: 12),

        /// PRIMARY BUTTON (FIXED)
       !_isLoading ? SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed:_onProceedPressed,
            child: Text(
              widget.voucherBean.value == "0.00"
                  ? "Submit"
                  : "Proceed to payment (${PriceConverter.convertPrice(
                context,
                double.parse(widget.voucherBean.value!),
              )})",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ):const Center(
          child: SizedBox(
           height: 40,
             width: 40,
             child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  void _onProceedPressed() {
    if(_agreed) {
      if(amountController.text.isEmpty){
        showCustomSnackBar("Amount required.", context);
        return;
      }
      if (amountController.text.startsWith('0')) {
        showCustomSnackBar("Invalid Amount", context);
        return;
      }
      _isLoading = true;
      request.voucherId = widget.voucherBean.id.toString();
      request.amount = amountController.text;

      if (widget.voucherBean.value == "0.00") {
        categoryController!.saveVoucher(
            request, context, widget.from,widget.voucherBean.value);
      } else {
        categoryController!
            .getRazorpayOrderId(
            widget.voucherBean.value!,
            widget.voucherBean.id!,
            request.amount!)
            .then((_) {
          openRazorpay(request.amount!);
        });
      }
    }else{
      showCustomSnackBar("I agree to continue", context);
    }
  }





}
