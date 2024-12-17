import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load_serv_task/core/dependency_injections/dependency_injection.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/category_model.dart';
import 'package:load_serv_task/features/category/presentation/cubit/product_details_cubit.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/product_details_update_widget.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/product_details_widget.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartAndProductsProvider>(
        builder: (context, cartAndProductsProvider, _) {
      return InkWell(
         onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            // Check if product exists in the cart
            final cartProductExists = cartAndProductsProvider.cartProductsList
                .any((cartProduct) => cartProduct.id == product.id);

            if (cartProductExists) {
              // Retrieve the cart product
              final cartProduct = cartAndProductsProvider.cartProductsList.firstWhere(
                    (cartProduct) => cartProduct.id == product.id,
              );
              // Pass the cart product to ProductDetailsUpdateWidget
              return ProductDetailsUpdateWidget(productInCart: cartProduct);
            } else {
              // Show the ProductDetailsWidget when product is not in cart
              return BlocProvider(
                create: (BuildContext context) =>
                sl<ProductDetailsCubit>()..getProductDetails(productId: product.id, context: context),
                child: ProductDetailsWidget(openForAddToCart: true),
              );
            }
          },
        );
      }, child: Container(
          width: 173,
          height: 234,
          decoration: BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              PositionedDirectional(
                start: 8,
                top: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 173,
                          child: TextDefaultWidget(
                              title: "${product.name}",
                              maxLines: 1,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 173,
                          child: TextDefaultWidget(
                              title: "${product.description}",
                              maxLines: 1,
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.network(
                          fit: BoxFit.fill,
                          width: 185,
                          height: 110,
                          product.image ?? ""))),
              PositionedDirectional(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 183,
                  height: 33,
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          spreadRadius: 0,
                          blurRadius: 15,
                          offset:
                              const Offset(0, -5), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: TextDefaultWidget(
                      title: product.isSingle == true
                          ? "\$${product.price}"
                          : "price upon selection",
                      color: CustomColors.orangeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: product.isSingle == true ? 24 : 14),
                ),
              ),
              PositionedDirectional(
                top: 5,
                end: 5,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      product.isFavorite == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: CustomColors.orangeColor,
                    )),
              ),
              PositionedDirectional(
                bottom: 20,
                end: 5,
                child: Image.asset(
                  "assets/images/plus.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
