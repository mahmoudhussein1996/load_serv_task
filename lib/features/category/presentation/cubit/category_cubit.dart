import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_serv_task/features/category/data/model/category_model.dart';
import 'package:load_serv_task/features/category/domain/usecase/category_details_usecase.dart';
import 'package:load_serv_task/features/category/presentation/cubit/category_states.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates>{

  final CategoryDetailsUseCase _categoryDetailsUseCase;


  CategoryDetailsCubit(this._categoryDetailsUseCase) : super(CategoryDetailsInitial());

  Future getCategoryDetails(int categoryId) async {
    emit(CategoryDetailsLoading());
    final response = await _categoryDetailsUseCase.getCategoryDetails(categoryId);

    if(response.message != "Category not found"){
      emit(CategoryDetailsSuccess(categoryDetails: Category.fromJson(response.data)));
    }else{
      emit(CategoryDetailsError(errorMessage: response.message));
     // ToastHelper.showError(message: response.message);
    }
  }

}
