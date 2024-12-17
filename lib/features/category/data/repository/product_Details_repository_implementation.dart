import 'package:load_serv_task/core/network/api_consts.dart';
import 'package:load_serv_task/core/network/api_response_model.dart';
import 'package:load_serv_task/core/network/dio_handler.dart';
import 'package:load_serv_task/features/category/domain/repository/cateogy_details_repository.dart';
import 'package:load_serv_task/features/category/domain/repository/product_details_repository.dart';

class ProductDetailsRepositoryImplementation implements ProductDetailsRepository{

  final DioHandler dioHandler = DioHandler();

  @override
  Future<ApiResponse> getProductDetails({required int productId}) async {
    final response = await dioHandler.get(
      "${ApiConstants.apiBaseUrl}/${ApiConstants.productDetails(productId)}",
    );
    return ApiResponse.fromJson(response);
  }

  

}