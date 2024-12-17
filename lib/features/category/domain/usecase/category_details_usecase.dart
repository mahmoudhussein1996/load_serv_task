
import 'package:load_serv_task/core/network/api_response_model.dart';
import 'package:load_serv_task/features/category/domain/repository/cateogy_details_repository.dart';

class CategoryDetailsUseCase{

  final CategoryDetailsRepository _categoryDetailsRepository;

  CategoryDetailsUseCase(this._categoryDetailsRepository);

  Future<ApiResponse> getCategoryDetails(int categoryId){
    return _categoryDetailsRepository.getCategoryDetails(categoryId: categoryId);
  }

}