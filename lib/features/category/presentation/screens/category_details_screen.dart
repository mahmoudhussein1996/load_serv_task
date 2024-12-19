import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_serv_task/core/dependency_injections/dependency_injection.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/shared_widgets/custom_textfeild_widget.dart';
import 'package:load_serv_task/core/shared_widgets/general_appbar_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/presentation/cubit/category_cubit.dart';
import 'package:load_serv_task/features/category/presentation/cubit/category_states.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/floating_button_widget.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/product_item.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryDetailsCubit>(
        create: (BuildContext context) => sl<CategoryDetailsCubit>()..getCategoryDetails(11),
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsStates>(
        builder: (context, state) {
        switch (state) {
          case CategoryDetailsLoading():
          return const Center(child: CircularProgressIndicator(),);
          case CategoryDetailsSuccess():
          return Stack(
            children: [
              Scaffold(
                body: Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * .25,
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                        image:  DecorationImage(fit: BoxFit.fill,image: NetworkImage("${state.categoryDetails.backgroundImage}")),
                      ),
                      child: Stack(
                        children: [
                          Container(color: CustomColors.orangeColor.withOpacity(.38),),
                          PositionedDirectional(
                            top: 100, start: 0, end: 0,
                            child: GeneralAppbarWidget(title: state.categoryDetails.name ?? "",
                            titleColor: CustomColors.whiteColor, backOnTap: ()=> Navigator.pop(context),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWidget(backGroundColor: CustomColors.whiteColor,hint: "Search here", prefixIcon: Icon(Icons.search, size: 30,),
                              suffixIcon: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.greyColor.withOpacity(.8)),
                                  child: IconButton(onPressed: (){}, icon: Icon(Icons.close))),),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(color: CustomColors.orangeColor,borderRadius: BorderRadius.circular(6)),
                            width: 44, height: 44,
                            alignment:Alignment.center,
                            child: const Icon(Icons.tune, size: 20,),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          itemCount: state.categoryDetails.products?.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            mainAxisExtent: 220
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              // index < state.allExperiments.length ?
                              return ProductItem(product: state.categoryDetails.products![index],);

                            }),
                      ),
                    )

                  ],
                ),
                floatingActionButton: const FloatingButtonWidget(),
              ),
              PositionedDirectional(top: 150,start: 0,end: 0,
                  child: Container(width: 132, height: 132,decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          spreadRadius: 12,
                          blurRadius: 4,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage("${state.categoryDetails.image}"))
                  ),))
            ],
          );
          case CategoryDetailsError():
          return const Center(child: TextDefaultWidget(
          title: "error in category", color: Colors.black,));
          default:
          return const SizedBox();
        }
        }
      ),
    );
  }
}
