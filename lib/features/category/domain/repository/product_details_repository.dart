import 'package:load_serv_task/core/network/api_response_model.dart';

abstract class ProductDetailsRepository{
  Future<ApiResponse> getProductDetails({required int productId});
}