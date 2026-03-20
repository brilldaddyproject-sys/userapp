import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

import '../../../vouchers/model/voucher_request.dart';

abstract class CategoryRepoInterface extends RepositoryInterface{
  Future<dynamic> getSellerWiseCategoryList(int sellerId);
  Future<dynamic> getVouchersList();
  Future<dynamic> getWinners();
  Future<dynamic> doCanBit(int id);
  Future<dynamic> getWinnersList();
  Future<dynamic> getMyVouchersList();
  Future<dynamic> getMyVouchersDetails(String id);
  Future<dynamic> getRazorpayOrderId(String amount,int id,String bidAmount);
  Future<dynamic> saveVoucher(VoucherRequest model);

  Future<ApiResponseModel<T>> getCategoryList<T>({required DataSourceEnum source});


}