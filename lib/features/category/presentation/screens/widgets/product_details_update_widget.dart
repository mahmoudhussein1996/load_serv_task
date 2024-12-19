import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_button_widget.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/extra_item.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/increment_widget.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/salad_item.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/weight_item.dart';
import 'package:provider/provider.dart';

class ProductDetailsUpdateWidget extends StatelessWidget {
   ProductDetails productInCart;
  ProductDetailsUpdateWidget({super.key, required this.productInCart});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartAndProductsProvider>(
        builder: (context, cartAndProductsProvider, _) {
          return Container(
            color: CustomColors.whiteColor,
            height: context.height * .8,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.clear, size: 27,)),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(color: CustomColors.whiteColor, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4), // changes position of shadow
                      ),
                    ]),
                    child: Row(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(productInCart.image ?? "", width: 132, height: 132, fit: BoxFit.fill,)),
                      const SizedBox(width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        SizedBox(width:177,
                          child: TextDefaultWidget(maxLines: 2,title: productInCart.description ?? "",
                            fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black,),
                        ),
                        const SizedBox(height: 36,),
                        Row(children: [productInCart.isSingle == true ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextDefaultWidget(title: "${productInCart.priceBeforeDiscount} EGP",fontSize: 12, lineThrough: true,fontWeight: FontWeight.w400),
                            const SizedBox(height: 6,),
                            TextDefaultWidget(title: "${productInCart.price} EGP", fontSize: 12, fontWeight: FontWeight.w400),
                          ],
                        ) : const SizedBox(),
                          const SizedBox(width: 100,),
                          IncrementWidget(counter: productInCart.productCount, plusOnTap: ()=> cartAndProductsProvider.incrementProductCounter(productInCart!),
                            minusOnTap: ()=> cartAndProductsProvider.decrementProductCounter(productInCart),)
                        ],)
                      ],)
                    ],),),
                  const SizedBox(height: 20,),
                  productInCart.weights!.isNotEmpty ?
                  const TextDefaultWidget(title: "Weights", fontWeight: FontWeight.w700, fontSize: 15) : const SizedBox(),
                  const SizedBox(height: 10,),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: productInCart.weights!.map((weight) {
                      return InkWell(onTap: ()=> cartAndProductsProvider.selectWeight(productInCart.weights!,weight),
                          child: WeightItem(weight: weight,));
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  TextDefaultWidget(title: "Addition ( select ${productInCart.productSaladCount}):", fontWeight: FontWeight.w700, fontSize: 15),
                  const SizedBox(height: 10,),
                  Wrap(
                    // spacing: 8.0,
                    runSpacing: 4.0,
                    children: productInCart.salads!.map((salad) {
                      return SaladItem(salad: salad,);
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  const TextDefaultWidget(title: "Extras :", fontWeight: FontWeight.w700, fontSize: 15),
                  const SizedBox(width: 10,),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: productInCart.extraItems!.map((extra) {
                      return ExtraItemWidget(extraItem: extra,);
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  CustomButton(title:  "Save Changes", secondTitle: "${productInCart.productTotalPrice} EGP", hasSecondText: true,
                      backgroundColor: CustomColors.orangeColor,horizontalPadding:20,
                      onTap: (){
                          Navigator.pop(context);
                      }
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        }
    );
  }
}
