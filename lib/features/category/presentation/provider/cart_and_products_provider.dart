import 'package:flutter/material.dart';
import 'package:load_serv_task/features/category/data/model/product_Details_model.dart';

class CartAndProductsProvider extends ChangeNotifier{
  factory CartAndProductsProvider() {
    _this ??= CartAndProductsProvider._();
    return _this!;
  }

  static CartAndProductsProvider? _this;
  CartAndProductsProvider._();


  List<ProductDetails> cartProductsList = [];


  ProductDetails _selectedProduct =  ProductDetails();
  ProductDetails get  selectedProduct => _selectedProduct;
  setSelectedProduct(ProductDetails productDetails){
    _selectedProduct = productDetails;
    if(productDetails.isSingle == true){
      productDetails.productTotalPrice+= productDetails.price!.toDouble();
    }
    notifyListeners();
  }
  setWeight(String selectedWeight){
    _selectedProduct.selectedWeight = selectedWeight;
    notifyListeners();
  }
  incrementProductSalad(Salad salad){
    salad.saladCounter++;
    _selectedProduct.productSaladCount++;
    _selectedProduct.productTotalPrice += salad.price!;
    notifyListeners();
  }

  decrementProductSalad(Salad salad){
    salad.saladCounter--;
    _selectedProduct.productSaladCount--;
    _selectedProduct.productTotalPrice -= salad.price!;
    notifyListeners();
  }

  setExtra(String selectedExtra){
    _selectedProduct.selectedExtra += ",$selectedExtra";
    notifyListeners();
  }

  removeExtra(String selectedExtra){
    _selectedProduct.selectedExtra.replaceAll(selectedExtra, " ");
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

    // Update the selected weight and product price
    setWeight(selectedWeight.name!);
    incrementProductPrice(selectedWeight.price!.toDouble());

    // Persist the change (this ensures state consistency)
    notifyListeners();
  }


  selectExtra(ExtraItem extra){
    extra.isSelected = !extra.isSelected;
    if(extra.isSelected == true){
      incrementProductPrice(extra.price!.toDouble());
      setExtra(extra.name!);
    }else{
      incrementProductPrice(-extra.price!.toDouble());
      removeExtra(extra.name!);
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


}