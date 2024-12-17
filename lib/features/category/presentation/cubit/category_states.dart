
import 'package:load_serv_task/features/category/data/model/category_model.dart';

sealed class CategoryDetailsStates{}

class CategoryDetailsInitial extends CategoryDetailsStates{}
class CategoryDetailsLoading extends CategoryDetailsStates{}

class CategoryDetailsSuccess extends CategoryDetailsStates{
  Category categoryDetails;
  CategoryDetailsSuccess({required this.categoryDetails});
}

class CategoryDetailsError extends CategoryDetailsStates{
  String errorMessage;
  CategoryDetailsError({required this.errorMessage});
}