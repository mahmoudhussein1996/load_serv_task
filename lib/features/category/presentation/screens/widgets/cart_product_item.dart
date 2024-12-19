import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_button_widget.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/product_details_widget.dart';
import 'package:provider/provider.dart';

class CartProductItem extends StatelessWidget {
  ProductDetails product;
  CartProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // product.weights!.forEach((weigh){
    //   print("weigh = ${weigh.isSelected}");
    // });
    return InkWell(
      onTap: ()=> showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => ProductDetailsWidget(openForAddToCart: false, productInCart: product,),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: CustomColors.whiteColor,borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],),
        child: Consumer<CartAndProductsProvider>(
          builder: (context, cartAndProductsProvider, _) {
            return Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius:  BorderRadius.circular(10),
                        child: Image.network(fit: BoxFit.fill,width: 138,height: 138, product.image!)),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 190,child: TextDefaultWidget(title:  product.description!, maxLines: 2,fontWeight: FontWeight.w700, fontSize: 14,)),
                        const SizedBox(height: 10,),
                        product.isSingle == true ? const SizedBox():
                        Row(children: [
                          const TextDefaultWidget(title: "Weight: ", fontWeight: FontWeight.w600, fontSize: 12,),
                          TextDefaultWidget(title: cartAndProductsProvider.getSelectedWeightName(product) ?? "" , color: CustomColors.greyColor, fontWeight: FontWeight.w500, fontSize: 12,),
                        ],),
                        const SizedBox(height: 10,),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          const TextDefaultWidget(title: "Salads: ", fontWeight: FontWeight.w600, fontSize: 12,),
                          SizedBox(width: 160,child: TextDefaultWidget(title: cartAndProductsProvider.getSalads(product.salads ?? []), color: CustomColors.greyColor, fontWeight: FontWeight.w500, fontSize: 12,)),
                        ],),
                        const SizedBox(height: 10,),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          const TextDefaultWidget(title: "Extras: ", fontWeight: FontWeight.w600, fontSize: 12,),
                          SizedBox(width: 160,child: TextDefaultWidget(title: cartAndProductsProvider.getExtras(product.extraItems ?? []), color: CustomColors.greyColor, fontWeight: FontWeight.w500, fontSize: 12,)),
                        ],),
                        const SizedBox(height: 10,),
                        Row(children: [
                          TextDefaultWidget(title: "${product.productTotalPrice} EGP", fontWeight: FontWeight.w600, fontSize: 12,),
                          const SizedBox(width: 20,),
                          InkWell(onTap: ()=> showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => ProductDetailsWidget(openForAddToCart: false, productInCart: product,),
                          ),child: Image.asset("assets/images/edit.png", width: 32, height: 32,)),
                          const SizedBox(width: 20,),
                          InkWell(onTap: ()=>  showAddNoteDialog(context),child: Image.asset(product.haveNote ?
                          "assets/images/message_filled.png" : "assets/images/message.png", width: 28, height: 28,)),

                        ],),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(onTap: ()=> cartAndProductsProvider.incrementProductCounter(product),child: Image.asset("assets/images/plus.png")),
                        const SizedBox(height: 10,),
                        TextDefaultWidget(title: "${product.productCount}", fontWeight: FontWeight.w400, fontSize: 15,),
                        const SizedBox(height: 10,),
                        InkWell(onTap: ()=> cartAndProductsProvider.decrementProductCounter(product),child: Image.asset("assets/images/minus.png")),
                      ],
                    )

                  ],
                ),
                PositionedDirectional(start: 10,top: 4,child: InkWell(onTap: (){
                  cartAndProductsProvider.cartProductsList.remove(product);
                  cartAndProductsProvider.incrementTotalPrice(-product.productTotalPrice);
                  cartAndProductsProvider.listen();
                },
                child: Image.asset(width: 24,height: 24,"assets/images/Delete.png", fit: BoxFit.scaleDown,),))
              ],
            );
          }
        ),
      ),
    );
  }

  showAddNoteDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<CartAndProductsProvider>(
          builder: (context, cartAndProductsProvider, _) {
            return AlertDialog(
              backgroundColor: CustomColors.whiteColor,
              title: const Center(child: TextDefaultWidget(title: "Add Note", fontWeight: FontWeight.w700, fontSize: 14,)),
              content: ConstrainedBox(
                constraints: BoxConstraints(minWidth: context.width), // Adjust the maximum width as needed),
                child: TextFormField(
                controller: cartAndProductsProvider.noteController..text =
                cartAndProductsProvider.selectedProduct.haveNote ?  cartAndProductsProvider.selectedProduct.note : "",
                maxLines: 5,
                decoration: InputDecoration(
                fillColor: CustomColors.textFieldColor, filled: true,enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)))),
              ),
              actions: [
                CustomButton(title: "Cancel", width: context.width * .25,
                backgroundColor: CustomColors.greyColor,onTap: ()=> Navigator.pop(context)),
                const SizedBox(width: 40,),
                CustomButton(title: "Confirm", width: context.width * .25,
                backgroundColor: CustomColors.orangeColor,onTap: (){
                 cartAndProductsProvider.setNoteForProduct(product,cartAndProductsProvider.noteController.text);
                  Navigator.pop(context);
                }),
              ],
            );
          }
        );
      },
    );
  }

}
