import 'package:flutter/material.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartAndProductsProvider>(
      builder: (context, cartAndProductsProvider, _) {
        return InkWell(
          onTap: (){
           if(cartAndProductsProvider.cartProductsList.isNotEmpty){
             Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => const CartScreen()),
             );
           }else{
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                backgroundColor: Colors.red,
                content: TextDefaultWidget(title: "Cart doesn't contain products, add item to cart first",
                color: CustomColors.whiteColor,)),
             );
           }
          },
          child: Container(
            width: 50, height: 50,
            decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.orangeColor),
            child: Center(child: Image.asset("assets/images/cart.png", width: 30, height: 30, fit: BoxFit.scaleDown,),),
          ),
        );
      }
    );
  }
}
