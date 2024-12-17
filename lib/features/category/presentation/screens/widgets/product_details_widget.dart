import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_button_widget.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/cubit/product_details_cubit.dart';
import 'package:load_serv_task/features/category/presentation/cubit/product_details_states.dart';
import 'package:load_serv_task/features/category/presentation/provider/cart_and_products_provider.dart';
import 'package:load_serv_task/features/category/presentation/screens/cart_screen.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/extra_item.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/product_details_update_widget.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/salad_item.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/increment_widget.dart';
import 'package:load_serv_task/features/category/presentation/screens/widgets/weight_item.dart';
import 'package:provider/provider.dart';

class ProductDetailsWidget extends StatelessWidget {
  bool openForAddToCart;
  ProductDetails? productInCart;

  ProductDetailsWidget(
      {super.key, required this.openForAddToCart, this.productInCart});

  @override
  Widget build(BuildContext context) {
    if (openForAddToCart == true && productInCart == null) {
      return BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
          builder: (context, state) {
        switch (state) {
          case ProductDetailsLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ProductDetailsSuccess():
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
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            cartAndProductsProvider.resetData();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 27,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 4), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  state.productDetails.image ?? "",
                                  width: 132,
                                  height: 132,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 177,
                                  child: TextDefaultWidget(
                                    maxLines: 2,
                                    title:
                                        state.productDetails.description ?? "",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 36,
                                ),
                                Row(
                                  children: [
                                    state.productDetails.isSingle == true
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextDefaultWidget(
                                                  title:
                                                      "${state.productDetails.priceBeforeDiscount} EGP",
                                                  fontSize: 12,
                                                  lineThrough: true,
                                                  fontWeight: FontWeight.w400),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              TextDefaultWidget(
                                                  title:
                                                      "${state.productDetails.price} EGP",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    IncrementWidget(
                                      counter:cartAndProductsProvider.selectedProduct.productCount,
                                      plusOnTap: () => cartAndProductsProvider
                                          .incrementProductCounter(cartAndProductsProvider.selectedProduct),
                                      minusOnTap: () => cartAndProductsProvider
                                          .decrementProductCounter(cartAndProductsProvider.selectedProduct),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state.productDetails.weights!.isNotEmpty
                          ? const TextDefaultWidget(
                              title: "Weights",
                              fontWeight: FontWeight.w700,
                              fontSize: 15)
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 12,
                        runSpacing: 6,
                        children: cartAndProductsProvider.selectedProduct.weights!.map((weight) {
                          return InkWell(
                              onTap: () =>
                                  cartAndProductsProvider.selectWeight(cartAndProductsProvider.selectedProduct.weights!,weight),
                              child: WeightItem(
                                weight: weight,
                              ));
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextDefaultWidget(
                          title:
                              "Addition ( select ${state.productDetails.salads?.length}):",
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        // spacing: 8.0,
                        runSpacing: 4.0,
                        children: cartAndProductsProvider.selectedProduct.salads!.map((salad) {
                          return SaladItem(
                            salad: salad,
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextDefaultWidget(
                          title: "Extras :",
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                      const SizedBox(
                        width: 10,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: cartAndProductsProvider.selectedProduct.extraItems!.map((extra) {
                          return ExtraItemWidget(
                            extraItem: extra,
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          title:
                              openForAddToCart ? "Add To Cart" : "Save Changes",
                          secondTitle:
                              "${cartAndProductsProvider.selectedProduct.productTotalPrice} EGP",
                          hasSecondText: true,
                          backgroundColor: CustomColors.orangeColor,
                          horizontalPadding: 20,
                          onTap: () {
                            if (openForAddToCart == true) {
                              if (cartAndProductsProvider
                                      .selectedProduct.productTotalPrice !=
                                  0.0) {
                                // Check if the product already exists in the cart
                                bool productExists = cartAndProductsProvider
                                    .cartProductsList
                                    .any(
                                  (product) =>
                                      product.id ==
                                      cartAndProductsProvider
                                          .selectedProduct.id,
                                );

                                if (!productExists) {
                                  // Add a  the selected product to the cart
                                  cartAndProductsProvider.cartProductsList.add(
                                    cartAndProductsProvider.selectedProduct,
                                  );
                                  cartAndProductsProvider.incrementTotalPrice(
                                      cartAndProductsProvider
                                          .selectedProduct.productTotalPrice);
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartScreen()),
                                );
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please select a weight first")),
                                );
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            });
          case ProductDetailsError():
            return const Center(
                child: TextDefaultWidget(
              title: "error in product",
            ));
          default:
            return const SizedBox();
        }
      });
    } else {
      return ProductDetailsUpdateWidget(
        productInCart: productInCart!,
      );
    }
  }
}
