import 'package:flutter/material.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/increment_widget.dart';
import 'package:provider/provider.dart';

class SaladItem extends StatelessWidget {
  Salad salad;
  SaladItem({super.key, required this.salad});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartAndProductsProvider>(
      builder: (context, cartAndProductsProvider, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: CustomColors.whiteColor,borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  salad.image??"",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextDefaultWidget(title: salad.name ?? "", fontWeight: FontWeight.w700, fontSize: 12,),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextDefaultWidget(title: "${salad.price.toString()} EGP", fontWeight: FontWeight.w700, fontSize: 12,),
                        IncrementWidget(counter: salad.saladCounter,
                        plusOnTap: ()=> cartAndProductsProvider.incrementProductSalad(salad),
                        minusOnTap: ()=> cartAndProductsProvider.decrementProductSalad(salad),)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
