import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_button_widget.dart';
import 'package:load_serv_task/core/shared_widgets/general_appbar_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/cart_product_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
        child: Consumer<CartAndProductsProvider>(
          builder: (context, cartAndProductsProvider, _) {
            return Column(
              children: [
                const SizedBox(height: 20,),
                GeneralAppbarWidget(title: "Cart Screen", titleColor: Colors.black, backOnTap: (){
                 // cartAndProductsProvider.resetData();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },),
                const SizedBox(height: 40,),
                Expanded(child: ListView.builder(
                  itemCount: cartAndProductsProvider.cartProductsList.length,
                  itemBuilder: (context, index) {
                     return CartProductItem(product: cartAndProductsProvider.cartProductsList[index],);
                  },
                )),
                const SizedBox(height: 40),
                CustomButton(title: "Checkout",secondTitle: "${cartAndProductsProvider.totalPrice} EGP",horizontalPadding: 20,width: context.width * .9,
                hasSecondText: true,backgroundColor: CustomColors.orangeColor ,onTap: (){
                    cartAndProductsProvider.showSendDialog(context);
                    Navigator.pop(context);
                }),
                const SizedBox(height: 10,),
                CustomButton(title: "Delete All",horizontalPadding: 20,width: context.width * .9,
                    hasSecondText: false,backgroundColor: CustomColors.pinkColor ,onTap: ()=> cartAndProductsProvider.clearProductsInCart()),
                const SizedBox(height: 20,),

              ],
            );
          }
        ),
      ),
    );
  }
}
