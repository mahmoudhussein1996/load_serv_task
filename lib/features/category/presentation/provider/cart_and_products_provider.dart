import 'package:flutter/material.dart';
import 'package:load_serv_task/core/helpers/general_helper.dart';
import 'package:load_serv_task/core/shared_widgets/custom_button_widget.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';
import 'package:load_serv_task/features/category/presentation/screens/cart_screen.dart';

class CartAndProductsProvider extends ChangeNotifier{
  factory CartAndProductsProvider() {
    _this ??= CartAndProductsProvider._();
    return _this!;
  }

  static CartAndProductsProvider? _this;
  CartAndProductsProvider._();

  TextEditingController noteController = TextEditingController();

  List<ProductDetails> cartProductsList = [];


  ProductDetails _selectedProduct =  ProductDetails();
  ProductDetails get  selectedProduct => _selectedProduct;
  setSelectedProduct(ProductDetails productDetails){
    _selectedProduct = productDetails;
    if(productDetails.isSingle == true){
      _selectedProduct.productSaladCount = productDetails.numOfSalad!;
      productDetails.productTotalPrice+= productDetails.price!.toDouble();
    }
    notifyListeners();
  }

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;
  incrementTotalPrice(double price){
    _totalPrice+= price;
    notifyListeners();
  }

  incrementProductPrice(double price){
    _selectedProduct.productTotalPrice+= price;
    notifyListeners();
  }
  void incrementProductCounter(ProductDetails product) {
      product.productCount++;
      // check if product has single price
      if(product.isSingle == true){
        product.productSaladCount = product.numOfSalad! * product.productCount;
      }else{
        // this product need weights
        Weight?  selectedWeight = product.weights?.firstWhere((weight) => weight.isSelected);

        if (selectedWeight!.isSelected == true) {
          // Update salad count based on selected weight
          product.productSaladCount = selectedWeight.numberOfSalad! * product.productCount;
        }else{
          ///todo: show error you shoud select weight first
        }

      }
      if(product.price != null){
        product.productTotalPrice += product.price!.toDouble();
        //incrementTotalPrice(product.price!.toDouble());
      }else{
        product.productTotalPrice+=product.productTotalPrice;
        //incrementTotalPrice(_totalPrice.toDouble());
      }
      notifyListeners();
  }
  void decrementProductCounter(ProductDetails product) {
    if (product.productCount > 1) {
      product.productCount--;
      if(product.isSingle == true){
        product.productSaladCount = product.numOfSalad! * product.productCount;
      }else{
        // this product need weights
        Weight?  selectedWeight = product.weights?.firstWhere((weight) => weight.isSelected);

        if (selectedWeight!.isSelected == true) {
          // Update salad count based on selected weight
          product.productSaladCount = selectedWeight.numberOfSalad! * product.productCount;
        }else{
          ///todo: show error you shoud select weight first
        }
      }
      if(product.price != null){
        product.productTotalPrice -= product.price!.toDouble();
        //incrementTotalPrice(-product.price!.toDouble());
      }else{
        product.productTotalPrice-=product.productTotalPrice;
        //incrementTotalPrice(-_totalPrice.toDouble());
      }
      notifyListeners();
    }
  }

  void incrementProductSalad(Salad salad) {
    // Calculate the total count of all selected salads
    int currentTotalSaladCount = selectedProduct.salads!
        .fold(0, (sum, currentSalad) => sum + currentSalad.saladCounter);

    // Check if increment is allowed based on total salad count limit
    if (currentTotalSaladCount < selectedProduct.productSaladCount) {
      salad.saladCounter++; // Increment the current salad count
      _selectedProduct.productTotalPrice += salad.price ?? 0.0; // Add salad price
      notifyListeners(); // Notify listeners to update the UI
    }
  }


  decrementProductSalad(Salad salad){
    if(salad.saladCounter >0){
      salad.saladCounter--;
    }
    // _selectedProduct.productSaladCount--;
    _selectedProduct.productTotalPrice -= salad.price!;
    notifyListeners();
  }

  void selectWeight(List<Weight> allWeights,Weight selectedWeight) {

    // Set all weights' isSelected to false
    allWeights.forEach((weight){
      if(weight.isSelected == true){
        incrementProductPrice(-weight.price!.toDouble());
      }
      weight.isSelected = false;
    });
    // Set the selected weight's isSelected to true
    selectedWeight.isSelected = true;
    selectedProduct.productSaladCount = selectedWeight.numberOfSalad! * selectedProduct.productCount;
    // Update the selected weight and product price
    incrementProductPrice(selectedWeight.price!.toDouble());

    // Persist the change (this ensures state consistency)
    notifyListeners();
  }


  selectExtra(ExtraItem extra){
    extra.isSelected = !extra.isSelected;
    if(extra.isSelected == true){
      incrementProductPrice(extra.price!.toDouble());
    }else{
      incrementProductPrice(-extra.price!.toDouble());
    }
    notifyListeners();
  }

  void listen(){
    notifyListeners();
  }

  clearProductsInCart(){
    cartProductsList.clear();
    resetData();
    notifyListeners();
  }

  resetData(){
    _totalPrice = 0;
    // _selectedWeight = "";
    // _totalSaladCount = 0;
    // _selectedExtra = "";
    notifyListeners();

  }

  void validateProductDetails(BuildContext context) {
    // Calculate total salads added
    int totalSalads = _selectedProduct.salads?.fold(0, (sum, salad) => sum! + salad.saladCounter) ?? 0;

    // Check if total salads match the required salad count
    if (totalSalads != _selectedProduct.productSaladCount) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: TextDefaultWidget(
      title: 'Please adjust the number of salads to match the required count (${_selectedProduct.productSaladCount}).',
      color: CustomColors.whiteColor,), duration: const Duration(seconds: 2),),);

    }else{
      if (_selectedProduct.productTotalPrice != 0.0) {
        // Check if the product already exists in the cart
        bool productExists = cartProductsList.any((product) => product.id == _selectedProduct.id,);

        if (!productExists) {
          // Add a  the selected product to the cart
          cartProductsList.add(_selectedProduct,);
          incrementTotalPrice(_selectedProduct.productTotalPrice);
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
            content: TextDefaultWidget(title: "Please select a weight first", color: CustomColors.whiteColor,)),);
      }
    }
  }

  String getSalads(List<Salad> salads) {
    final selectedSalads = salads.where((salad) => salad.saladCounter >0).toList();

    if (selectedSalads.length > 1) {
      return "${selectedSalads.length} items";
    } else {
      return selectedSalads.first.name!;
    }
  }

  String getExtras(List<ExtraItem> extras) {
    // Check if all extras have been selected
    final selectedExtras = extras.where((extra) => extra.isSelected).toList();

    if (selectedExtras.isEmpty) {
      return "No extras";
    }

    if (selectedExtras.length > 1) {
      return "${selectedExtras.length} items";
    } else {
      // Return the name of the single selected extra
      return selectedExtras.first.name!;
    }
  }

  String? getSelectedWeightName(ProductDetails product) {
    try {
      return product.weights!.firstWhere((weight) => weight.isSelected).name;
    } catch (e) {
      return null; // No weight is selected
    }
  }

  setNoteForProduct(ProductDetails product ,String note){
    product.note = note;
    product.haveNote = true;
    notifyListeners();
  }

  showSendDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.whiteColor,
          title: const Center(child: TextDefaultWidget(title: "Success", color: Colors.green,fontWeight: FontWeight.w700, fontSize: 14,)),
          content: SizedBox(height: context.height * .1,child: const Center(child: TextDefaultWidget(title: "Order sent successfully",fontWeight: FontWeight.w700, fontSize: 14,))),
          actions: [
            Center(
              child: CustomButton(title: "Confirm", width: context.width * .25,
                  backgroundColor: CustomColors.orangeColor,onTap: ()=> Navigator.pop(context)),
            ),
          ],
        );
      },
    );
  }

}