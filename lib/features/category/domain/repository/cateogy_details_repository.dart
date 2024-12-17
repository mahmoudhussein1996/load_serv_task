import 'package:load_serv_task/core/network/api_response_model.dart';

abstract class CategoryDetailsRepository{
  Future<ApiResponse> getCategoryDetails({required int categoryId});
}