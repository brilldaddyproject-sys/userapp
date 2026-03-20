import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/domain/services/cart_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/domain/models/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shipping/controllers/shipping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/data_sync_helper.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';

import '../screens/cart_screen.dart';

class CartController extends ChangeNotifier {

  final CartServiceInterface? cartServiceInterface;

  CartController({required this.cartServiceInterface});

  List<CartModel> _cartList = [];
  List<bool> isSelectedList = [];
  double amount = 0.0;
  bool isSelectAll = true;
  bool _cartLoading = false;
  bool  get cartLoading => _cartLoading;
  CartModel? cart;
  String? _updateQuantityErrorText;
  String? get addOrderStatusErrorText => _updateQuantityErrorText;
  bool _getData = true;
  bool _addToCartLoading = false;
  bool get addToCartLoading => _addToCartLoading;
  List<CartModel> get cartList => _cartList;
  bool get getData => _getData;
  int? get referralDiscount => _referralDiscount;
  int? _referralDiscount;
  double? get brillDaddyWalletAmount => _brillDaddyWalletAmount;
  double? _brillDaddyWalletAmount;


  void setCartData(){
    _getData = true;
  }

  void getCartDataLoaded(){
    _getData = false;
  }

  Future<ApiResponseModel> getCartData(BuildContext context, {bool reload = true}) async {
    if(reload){
      _cartLoading = true;
    }
    ApiResponseModel apiResponse = await cartServiceInterface!.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _cartList = [];
      apiResponse.response!.data.forEach((cart) => _cartList.add(CartModel.fromJson(cart)));
      _cartLoading = false;
    } else {
      _cartLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    _cartLoading = false;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponseModel> getReferralData(BuildContext context) async {
    ApiResponseModel apiResponse = await cartServiceInterface!.getReferralData();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response!.data['referral_discount']!=null) {
        _referralDiscount = apiResponse.response!.data['referral_discount'];
      }else{
        _referralDiscount = 0;
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponseModel> getBrillDaddyWalletAmount(BuildContext context) async {
    ApiResponseModel apiResponse = await cartServiceInterface!.getBrillDaddyWalletAmount();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response!.data['brilldadywalletamount']!=null) {
        _brillDaddyWalletAmount = double.parse(apiResponse.response!.data['brilldadywalletamount'].toString());
        //Provider.of<CheckoutController>(context, listen: false).brillDaddyAmount = _brillDaddyWalletAmount;
      }else{
        _brillDaddyWalletAmount = 0;
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
    return apiResponse;
  }


  void setIsCartLoading() {
    _cartLoading = true;
  }

  bool updatingIncrement = false;
  bool updatingDecrement = false;



  Future<ApiResponseModel> updateCartProductQuantity(int? key, int quantity, BuildContext context, bool increment, int index) async{
    if(increment){
      cartList[index].increment = true;
    }else{
      cartList[index].decrement = true;
    }
    notifyListeners();
    ApiResponseModel apiResponse;
    apiResponse = await cartServiceInterface!.updateQuantity(key, quantity);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      cartList[index].increment  = false;
      cartList[index].decrement = false;
      String message = apiResponse.response!.data['message'].toString();
      showCustomSnackBar(message, Get.context!, isError: false);
      await getCartData(Get.context!);

    } else {
      cartList[index].increment  = false;
      cartList[index].decrement = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




  Future<ApiResponseModel> addToCartAPI(CartModelBody cart, BuildContext context, List<ChoiceOptions> choices, List<int>? variationIndexes, {int buyNow = 0, int? shippingMethodExist, int? shippingMethodId}) async {
    _addToCartLoading = true;
    notifyListeners();
    ApiResponseModel apiResponse = await cartServiceInterface!.addToCartListData(cart, choices, variationIndexes, buyNow, shippingMethodExist, shippingMethodId);
    _addToCartLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _addToCartLoading = false;
      print(apiResponse.response.toString());
      if(buyNow == 0) {
        showSuccessDialog(context, apiResponse.response!.data['message'],cart);
      }
     // showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: apiResponse.response!.data['status'] == 0, isToaster: true);
      getCartData(Get.context!);
    } else {
      _addToCartLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  void showSuccessDialog(BuildContext context, String message, CartModelBody cart) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  child: Icon(Icons.check_rounded, color: Colors.green, size: 50),
                ),
                const SizedBox(height: 20),
                Text(
                  "Success!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton( style: ElevatedButton.styleFrom( backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)), ),
                      onPressed: (){
                        Navigator.pop(context);
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CartScreen()));
                      },
                      child: const Text("Go to Cart"), ),

                    ElevatedButton( style: ElevatedButton.styleFrom( backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)), ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("OK"), ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildGradientButton({
    required BuildContext context,
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }



  Future<ApiResponseModel> restockRequest(CartModelBody cart, BuildContext context, List<ChoiceOptions> choices, List<int>? variationIndexes, {int buyNow = 0, int? shippingMethodExist, int? shippingMethodId, String? variationType}) async {
    _addToCartLoading = true;
    notifyListeners();
    ApiResponseModel apiResponse = await cartServiceInterface!.restockRequest(cart, choices, variationIndexes, buyNow, shippingMethodExist, shippingMethodId);

    _addToCartLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _addToCartLoading = false;
      if(context.mounted) {
        Provider.of<ProductDetailsController>(context, listen: false).updateProductRestock(variantKey: variationType);
      }

      await FirebaseMessaging.instance.subscribeToTopic(apiResponse.response!.data['topic']);
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: apiResponse.response!.data['status'] == 0, isToaster: true);
    } else {
      _addToCartLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<void> removeFromCartAPI(int? key, int index) async{
    cartList[index].decrement = true;
    notifyListeners();
    ApiResponseModel apiResponse = await cartServiceInterface!.delete(key!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      cartList[index].decrement = false;
      getCartData(Get.context!);
    } else {
      cartList[index].decrement = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

  }

  Future<void> deleteCartAll() async{
    notifyListeners();
    ApiResponseModel apiResponse = await cartServiceInterface!.deleteAllCart();
    _cartList.clear();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getCartData(Get.context!);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

  }


  Future<void> addRemoveCartSelectedItem(List<int> ids, bool action) async{
    notifyListeners();
    Map<String, dynamic> data = {
      'ids' : ids,
      'action' : action ? 'checked' : 'unchecked'
    };
    ApiResponseModel apiResponse = await cartServiceInterface!.addRemoveCartSelectedItem(data);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      await Future.wait([
        Provider.of<ShippingController>(Get.context!, listen: false).getChosenShippingMethod(Get.context!),
        getCartData(Get.context!),
      ]);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


}
