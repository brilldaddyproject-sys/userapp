
import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_request.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/vouchers_response.dart';

abstract class CategoryServiceInterface {

  Future<dynamic> getSellerWiseCategoryList(int sellerId);
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source});
  Future<ApiResponseModel<T>> getVouchersList<T>();
  Future<ApiResponseModel<T>> getWinners<T>();
  Future<ApiResponseModel<T>> getWinnersList<T>();
  Future<ApiResponseModel<T>> doCanBit<T>(int id);
  Future<dynamic> saveVouchers<T>(VoucherRequest model, String from);
  Future<ApiResponseModel<T>> myVouchers<T>();
  Future<ApiResponseModel<T>> myClaims<T>();
  Future<ApiResponseModel<T>> myClaimsDetails<T>(String id);
  Future<ApiResponseModel<T>> myVouchersDetails<T>(String id);
  Future<ApiResponseModel<T>> getRazorpayOrderId<T>(String amount, int id, String bidAmount, String type);


}