import 'package:flutter_sixvalley_ecommerce/common/enums/data_source_enum.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/services/data_sync_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/repositories/category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_request.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class CategoryRepository extends DataSyncService implements CategoryRepoInterface {
  final DioClient? dioClient;
  CategoryRepository({required this.dioClient, required super.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(
        AppConstants.categoriesUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getSellerWiseCategoryList(int sellerId) async {
    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseCategoryList}$sellerId');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }



  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseModel<T>> getCategoryList<T>({required DataSourceEnum source}) async {
    return await fetchData<T>('${AppConstants.categoriesUri}?guest_id=1',  source);
  }

  @override
  Future getVouchersList() async{
    try {
      final response = await dioClient!.get(
          AppConstants.vouchersUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> saveVoucher(
      VoucherRequest model, String from) async {
    try {
      String url;

      if (from == "product") {
        url = AppConstants.productvoucherbidsubmit;
      } else {
        url = AppConstants.saveVoucherUri;
      }

      final response = await dioClient!.post(
        url,
        data: model.toJson(),
      );

      return ApiResponseModel.withSuccess(response);

    } catch (e) {
      return ApiResponseModel.withError(
          ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getMyVouchersList() async{
    try {
      final response = await dioClient!.get(
          AppConstants.listmyvoucherbids);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  
  Future getMyClaimsList() async{
    try {
      final response = await dioClient!.get(
          AppConstants.productlistmyvoucherbids);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getMyClaimsDetails(String id) async{
    try {
      final response = await dioClient!.get(
          AppConstants.productlistmyvoucherbidsdetails + id);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getMyVouchersDetails(String id) async{
    try {
      final response = await dioClient!.get(
          AppConstants.listmyvoucherbidsdetails+"$id");
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getWinners() async{
    try {
      final response = await dioClient!.get(
          AppConstants.listvoucherwinner);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getWinnersList() async{
    try {
      final response = await dioClient!.get(
          AppConstants.winnergallerylist);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getRazorpayOrderId(
      String amount, int id, String bidAmount, String type) async {
    try {
      String url;

      if (type == "voucher") {
        url =
        "${AppConstants.voucherrazorpayorderid}$amount/$id/$bidAmount";
      } else {
        url =
        "${AppConstants.productvoucherrazorpayorderid}$amount/$id/$bidAmount";
      }

      final response = await dioClient!.get(url);

      return ApiResponseModel.withSuccess(response);

    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future doCanBit(int id) async{
    try {
      final response = await dioClient!.get(
          AppConstants.listvoucherdetails+id.toString());
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}