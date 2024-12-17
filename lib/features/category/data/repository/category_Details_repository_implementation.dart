import 'package:load_serv_task/core/network/api_consts.dart';
import 'package:load_serv_task/core/network/api_response_model.dart';
import 'package:load_serv_task/core/network/dio_handler.dart';
import 'package:load_serv_task/features/category/domain/repository/cateogy_details_repository.dart';

class CategoryDetailsRepositoryImplementation implements CategoryDetailsRepository{

  final DioHandler dioHandler = DioHandler();

  @override
  Future<ApiResponse> getCategoryDetails({required int categoryId}) async {
    final response = await dioHandler.get(
      "${ApiConstants.apiBaseUrl}/${ApiConstants.categoryDetails(categoryId)}",
    );
    return ApiResponse.fromJson(response);
  }
  

}