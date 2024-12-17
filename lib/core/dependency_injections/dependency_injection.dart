
import 'package:get_it/get_it.dart';
import 'package:load_serv_task/features/category/data/repository/category_Details_repository_implementation.dart';
import 'package:load_serv_task/features/category/data/repository/product_Details_repository_implementation.dart';
import 'package:load_serv_task/features/category/domain/repository/cateogy_details_repository.dart';
import 'package:load_serv_task/features/category/domain/repository/product_details_repository.dart';
import 'package:load_serv_task/features/category/domain/usecase/category_details_usecase.dart';
import 'package:load_serv_task/features/category/domain/usecase/product_details_usecase.dart';
import 'package:load_serv_task/features/category/presentation/cubit/category_cubit.dart';
import 'package:load_serv_task/features/category/presentation/cubit/product_details_cubit.dart';


final sl = GetIt.instance;

void setupServiceLocator() {
  // category repository
  sl.registerLazySingleton<CategoryDetailsRepository>(() => CategoryDetailsRepositoryImplementation());

  // category useCases
  sl.registerLazySingleton<CategoryDetailsUseCase>(() => CategoryDetailsUseCase(sl<CategoryDetailsRepository>()));

  // category cubits
  sl.registerFactory<CategoryDetailsCubit>(() => CategoryDetailsCubit(sl<CategoryDetailsUseCase>()));


  // product repository
  sl.registerLazySingleton<ProductDetailsRepository>(() => ProductDetailsRepositoryImplementation());

  // product useCases
  sl.registerLazySingleton<ProductDetailsUseCase>(() => ProductDetailsUseCase(sl<ProductDetailsRepository>()));

  // category cubits
  sl.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(sl<ProductDetailsUseCase>()));

}