
import 'package:load_serv_task/core/network/api_response_model.dart';
import 'package:load_serv_task/features/category/domain/repository/cateogy_details_repository.dart';
import 'package:load_serv_task/features/category/domain/repository/product_details_repository.dart';

class ProductDetailsUseCase{

  final ProductDetailsRepository _productDetailsRepository;

  ProductDetailsUseCase(this._productDetailsRepository);

  Future<ApiResponse> getProductDetails(int productId){
    return _productDetailsRepository.getProductDetails(productId: productId);
  }

}