import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';

sealed class ProductDetailsStates{}

class ProductDetailsInitial extends ProductDetailsStates{}
class ProductDetailsLoading extends ProductDetailsStates{}

class ProductDetailsSuccess extends ProductDetailsStates{
  ProductDetails productDetails;
  ProductDetailsSuccess({required this.productDetails});
}

class ProductDetailsError extends ProductDetailsStates{
  String errorMessage;
  ProductDetailsError({required this.errorMessage});
}