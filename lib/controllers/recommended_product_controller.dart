import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList =[];
  List<ProductModel> get recommendedProductList => _recommendedProductList;


  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> getRecommendedProductList()async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      //print("got products");
      _recommendedProductList =[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products );
      // print(_recommendedProductList);
      _isLoaded = true;
      update();
    }else{
      // print("failed getting products");
      print(response.statusText);
    }
  }

}