import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/services/category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_winner_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/vouchers_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/my_vouchers_list_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/voucher_success_page.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/data_sync_helper.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../../vouchers/model/razor_order_model.dart';
import '../../vouchers/model/my_claim_model.dart';
import '../../vouchers/model/my_claim_details_model.dart';
import '../../vouchers/model/voucher_bid_details_model.dart';
import '../../vouchers/model/voucher_bid_model.dart';
import '../../vouchers/model/voucher_request.dart';
import '../../vouchers/model/winner_gallery_response.dart';

class CategoryController extends ChangeNotifier {
  final CategoryServiceInterface? categoryServiceInterface;
  CategoryController({required this.categoryServiceInterface});


  bool _isLoading = false;
  bool _isMyClaimsLoading = false;
  bool _isMyClaimDetailsLoading = false;
  final List<CategoryModel> _filteredCategoryList = [];
  final List<CategoryModel> _categoryList = [];
  final List<VoucherModel>? _voucherList = [];
  final List<VoucherModel>? _doCanvoucherList = [];
  final List<VoucherBidModel>? _myVoucherList = [];
  final List<MyClaimModel>? _myClaimList = [];
  MyClaimDetailsModel? _myClaimDetails;
  final List<VoucherBidDetailModel>? _myVoucherDetailsList = [];
  final List<CategoryModel> _sellerWiseCategoryList = [];
  final List<VoucherWinnerModel> _voucherWinnerList = [];
  List<WinnerData>? _winnerGalleryList = [];
  int? _categorySelectedIndex;
  int? _currentIndex;
  int? get currentIndex => _currentIndex;
  List<CategoryModel> get categoryList => _categoryList;
  List<VoucherBidModel>? get myVoucherList => _myVoucherList;
  List<MyClaimModel>? get myClaimList => _myClaimList;
  MyClaimDetailsModel? get myClaimDetails => _myClaimDetails;
  List<VoucherBidDetailModel>? get myVoucherDetailsList => _myVoucherDetailsList;
  List<VoucherModel>? get voucherList => _voucherList;
  List<VoucherModel>? get doCanvoucherList => _doCanvoucherList;
  List<VoucherWinnerModel>? get voucherWinnerList => _voucherWinnerList;
  List<WinnerData>? get winnerGalleryList => _winnerGalleryList;
  List<CategoryModel> get sellerWiseCategoryList => _sellerWiseCategoryList;
  List<CategoryModel> get filteredCategoryList => _filteredCategoryList;
  bool get isLoading => _isLoading;
  bool get isMyClaimsLoading => _isMyClaimsLoading;
  bool get isMyClaimDetailsLoading => _isMyClaimDetailsLoading;
  int? get categorySelectedIndex => _categorySelectedIndex;
  RazorOrderModel? _razorModel;
  RazorOrderModel? get razorModel => _razorModel;
  bool get isCanBit => _isCanBit;
  bool _isCanBit = true;
  String razorPayOrderId= "";

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> getCategoryList(bool reload) async {
    if(_categoryList.isEmpty || reload) {
      DataSyncHelper.fetchAndSyncData(
        fetchFromLocal: ()=> categoryServiceInterface!.getList(source: DataSourceEnum.local),
        fetchFromClient: ()=> categoryServiceInterface!.getList(source: DataSourceEnum.client),
        onResponse: (data, source) {
          if(data != null) {
            _categoryList.clear();

            data.forEach((category) => _categoryList.add(CategoryModel.fromJson(category)));
            _categorySelectedIndex = 0;

            onUpdateFilteredCategoryList(isSeller: false);
            notifyListeners();

          }
        },
      );
    }

  }

  Future<void> getVouchers() async {
    ApiResponseModel apiResponse = await categoryServiceInterface!.getVouchersList();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _voucherList!.clear();
      apiResponse.response!.data.forEach((category) => _voucherList.add(VoucherModel.fromJson(category)));

    } else {
      ApiChecker.checkApi( apiResponse);
    }

   // onUpdateFilteredCategoryList(isSeller: true);

    notifyListeners();
  }

  Future<void> getWinners() async {
    ApiResponseModel apiResponse = await categoryServiceInterface!.getWinners();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _voucherWinnerList!.clear();
      apiResponse.response!.data.forEach((category) => _voucherWinnerList.add(VoucherWinnerModel.fromJson(category)));

    } else {
      ApiChecker.checkApi( apiResponse);
    }

    //onUpdateFilteredCategoryList(isSeller: true);

    notifyListeners();
  }

  Future<void> getWinnerList() async {
    ApiResponseModel apiResponse = await categoryServiceInterface!.getWinnersList();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _winnerGalleryList!.clear();
        var winnerResponse = WinnerGalleryResponse.fromJson(apiResponse.response!.data);
        _winnerGalleryList = winnerResponse.data!;

    } else {
      ApiChecker.checkApi( apiResponse);
    }

    //onUpdateFilteredCategoryList(isSeller: true);

    notifyListeners();
  }
  bool isCanLoading = true;
  Future<void> doCanBit(int id) async {
    isCanLoading = true;
    _doCanvoucherList!.clear();
    //_isLoading = true;
    ApiResponseModel apiResponse = await categoryServiceInterface!.doCanBit(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((category) => _doCanvoucherList.add(VoucherModel.fromJson(category)));
      if(_doCanvoucherList[0].canbid ==  "true"){
        _isCanBit = true;
      }else{
        _isCanBit = false;
      }
      isCanLoading = false;
     //
     // _isLoading = false;
      print(isCanBit);
      notifyListeners();
    } else {
     // _isLoading = false;
      isCanLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    //onUpdateFilteredCategoryList(isSeller: true);
  }

  Future<ApiResponseModel> saveVoucher(VoucherRequest request, BuildContext context, String from, String? value) async {
    _isLoading = true;
    notifyListeners();
    ApiResponseModel apiResponse = await categoryServiceInterface?.saveVouchers(request,from);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      //showCustomSnackBar(apiResponse.response!.data["message"], Get.context!, isError: false);
      Provider.of<ProfileController>(context, listen: false).getUserInfo(context).then((e){
        if(from == "details"){
          Navigator.pop(context);
        }
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherSuccessPage(value)));
      });
    } else {
      _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<void> getMyVouchers() async {
    ApiResponseModel apiResponse = await categoryServiceInterface!.myVouchers();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _myVoucherList!.clear();
      apiResponse.response!.data.forEach((category) => _myVoucherList.add(VoucherBidModel.fromJson(category)));

    } else {
      ApiChecker.checkApi( apiResponse);
    }

    notifyListeners();
  }

  Future<void> getMyClaims() async {
    _isMyClaimsLoading = true;
    notifyListeners();

    ApiResponseModel apiResponse = await categoryServiceInterface!.myClaims();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _myClaimList!.clear();
      final List<dynamic> claims = apiResponse.response!.data['data'] ?? [];
      for (final claim in claims) {
        _myClaimList!.add(MyClaimModel.fromJson(claim));
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }

    _isMyClaimsLoading = false;
    notifyListeners();
  }

  void clearMyClaimDetails() {
    _myClaimDetails = null;
    _isMyClaimDetailsLoading = false;
    notifyListeners();
  }

  Future<void> getMyClaimsDetails(String id) async {
    _isMyClaimDetailsLoading = true;
    notifyListeners();

    ApiResponseModel apiResponse = await categoryServiceInterface!.myClaimsDetails(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _myClaimDetails = MyClaimDetailsModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi(apiResponse);
    }

    _isMyClaimDetailsLoading = false;
    notifyListeners();
  }

  Future<void> getMyVouchersDetails(String id) async {
    ApiResponseModel apiResponse = await categoryServiceInterface!.myVouchersDetails(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _myVoucherDetailsList!.clear();
      apiResponse.response!.data.forEach((category) => _myVoucherDetailsList.add(VoucherBidDetailModel.fromJson(category)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }

   // onUpdateFilteredCategoryList(isSeller: true);

    notifyListeners();
  }

  Future<void> getRazorpayOrderId(String amount, int id, String bidAmount,String type) async {
    _isLoading =true;
    notifyListeners();
    ApiResponseModel apiResponse = await categoryServiceInterface!.getRazorpayOrderId(amount,id,bidAmount,type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      razorPayOrderId = apiResponse.response!.data['order_id'];
      _isLoading = false;
      print(razorPayOrderId);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    //onUpdateFilteredCategoryList(isSeller: true);


  }




  void onUpdateFilteredCategoryList({required bool isSeller}) {
    _filteredCategoryList.clear();
    _filteredCategoryList.addAll(isSeller ? _sellerWiseCategoryList : _categoryList);
  }




  Future<void> getSellerWiseCategoryList(int sellerId) async {
      ApiResponseModel apiResponse = await categoryServiceInterface!.getSellerWiseCategoryList(sellerId);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _sellerWiseCategoryList.clear();
        apiResponse.response!.data.forEach((category) => _sellerWiseCategoryList.add(CategoryModel.fromJson(category)));

      } else {
        ApiChecker.checkApi( apiResponse);
      }

      onUpdateFilteredCategoryList(isSeller: true);

      notifyListeners();

  }

  final List<int> _selectedCategoryIds = [];
  List<int> get selectedCategoryIds => _selectedCategoryIds;

  void checkedToggleCategory(int index){
    _filteredCategoryList[index].isSelected = !_filteredCategoryList[index].isSelected!;

    if(_filteredCategoryList[index].isSelected ?? false) {
      if(!_selectedCategoryIds.contains(index)) {
        _selectedCategoryIds.add(index);
      }

    }else {
      _selectedCategoryIds.remove(index);

      _onDisableSubCategorySelection(index);


    }
    notifyListeners();
  }

  void _onDisableSubCategorySelection(int index) {
    _filteredCategoryList[index].subCategories?.forEach((subCategory){
      subCategory.isSelected = false;
    });
  }

  void checkedToggleSubCategory(int index, int subCategoryIndex){
    _filteredCategoryList[index].subCategories![subCategoryIndex].isSelected = !_filteredCategoryList[index].subCategories![subCategoryIndex].isSelected!;
    notifyListeners();
  }

  Future<void> resetChecked(int? id, bool fromShop) async {
    if(fromShop){
      await getSellerWiseCategoryList(id!);
      Provider.of<BrandController>(Get.context!, listen: false).getSellerWiseBrandList(id);
      Provider.of<SellerProductController>(Get.context!, listen: false).getSellerProductList(id.toString(), 1, "");
    }else{
      await getCategoryList(true);
      Provider.of<BrandController>(Get.context!, listen: false).getBrandList(offset: 1);
    }

  }

  void onChangeSelectedIndex(int selectedIndex, {bool isUpdate = true}) {
    _categorySelectedIndex = selectedIndex;
    if(isUpdate){
      notifyListeners();
    }
  }


}
