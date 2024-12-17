import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:provider/provider.dart';

class WeightItem extends StatelessWidget {
  Weight weight;
  WeightItem({super.key, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartAndProductsProvider>(
      builder: (context, cartAndProductsProvider, _) {
        return Container(
        width: context.width * .43,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: CustomColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        border: Border.all(color: weight.isSelected ? Colors.transparent : CustomColors.borderColor),
        borderRadius: BorderRadius.circular(8),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextDefaultWidget(title: weight.name ?? "",
            fontSize: 11, fontWeight: FontWeight.w500),
            TextDefaultWidget(title: "${weight.price} EGP",
             fontSize: 11, fontWeight: FontWeight.w500),
            Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                color: weight.isSelected ? CustomColors.orangeColor : Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
              child: weight.isSelected ? Icon(Icons.check, size: 10,color: CustomColors.whiteColor,) : const SizedBox(),
            ),
          ],
        ),
                );
      }
    );
  }
}
