import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/domain/usecase/product_details_usecase.dart';
import 'package:load_serv_task/features/category/presentation/cubit/product_details_states.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates>{

  final ProductDetailsUseCase _productDetailsUseCase;


  ProductDetailsCubit(this._productDetailsUseCase) : super(ProductDetailsInitial());

  Future getProductDetails({required int productId, required BuildContext context}) async {
    CartAndProductsProvider cartAndProductsProvider = Provider.of<CartAndProductsProvider>(context, listen: false);
    emit(ProductDetailsLoading());
    final response = await _productDetailsUseCase.getProductDetails(productId);
    if(response.message != "Product not found."){
      emit(ProductDetailsSuccess(productDetails: ProductDetails.fromJson(response.data)));
      cartAndProductsProvider.setSelectedProduct(ProductDetails.fromJson(response.data));
    }else{
      emit(ProductDetailsError(errorMessage: response.message));
     // ToastHelper.showError(message: response.message);
    }
  }

}
