import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/repositories/category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/services/category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_request.dart';

class CategoryService implements CategoryServiceInterface{
  CategoryRepoInterface categoryRepoInterface;
  CategoryService({required this.categoryRepoInterface});

  @override
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source}) async{
    return await categoryRepoInterface.getCategoryList(source: source);
  }

  @override
  Future getSellerWiseCategoryList(int sellerId) async{
    return await categoryRepoInterface.getSellerWiseCategoryList(sellerId);
  }

  @override
  Future<ApiResponseModel<T>> getVouchersList<T>() async{
    return await categoryRepoInterface.getVouchersList();
  }

  @override
  Future saveVouchers<T>(VoucherRequest model) async{
    return await categoryRepoInterface.saveVoucher(model);
  }

  @override
  Future<ApiResponseModel<T>> myVouchers<T>() async{
    return await categoryRepoInterface.getMyVouchersList();
  }

  @override
  Future<ApiResponseModel<T>> myVouchersDetails<T>(String id) async{
    return await categoryRepoInterface.getMyVouchersDetails(id);
  }

  @override
  Future<ApiResponseModel<T>> getWinners<T>() async {
    return await categoryRepoInterface.getWinners();
  }

  @override
  Future<ApiResponseModel<T>> getWinnersList<T>() async {
    return await categoryRepoInterface.getWinnersList();
  }

  @override
  Future<ApiResponseModel<T>> getRazorpayOrderId<T>(String amount,int id,String bidAmount) async{
    return await categoryRepoInterface.getRazorpayOrderId(amount,id,bidAmount);
  }

  @override
  Future<ApiResponseModel<T>> doCanBit<T>(int id) async {
    return await categoryRepoInterface.doCanBit(id);
  }

}