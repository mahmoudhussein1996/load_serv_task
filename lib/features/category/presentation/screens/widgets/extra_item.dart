import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:provider/provider.dart';

class ExtraItemWidget extends StatelessWidget {
  ExtraItem extraItem;
  ExtraItemWidget({super.key, required this.extraItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // todo: if extra item has color uncomment widget
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image.network(
          //     "https://www.trendapp.org/test-project/public/storage/salad/TyRy0CL6su0tEGua06lWNVC3vKrquesemdgGY5TD.jpg",
          //     width: 80,
          //     height: 80,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // const SizedBox(width: 16),
          SizedBox(width: context.width * .3,child: TextDefaultWidget(title: extraItem.name ?? "", fontWeight: FontWeight.w700, fontSize: 12,)),
          TextDefaultWidget(title: "${extraItem.price} EGP", fontWeight: FontWeight.w700, fontSize: 12,),
          Consumer<CartAndProductsProvider>(
            builder: (context, cartAndProductsProvider, _) {
              return Checkbox(value: extraItem.isSelected,
              onChanged: (_)=> cartAndProductsProvider.selectExtra(extraItem),
              checkColor: CustomColors.whiteColor,
              activeColor: CustomColors.orangeColor,
              side:  BorderSide(color: extraItem.isSelected ? Colors.transparent : CustomColors.orangeColor),
              );
            }
          )
        ],
      ),
    );
  }
}
