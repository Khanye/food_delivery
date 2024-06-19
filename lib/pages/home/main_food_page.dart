import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column (
      children: [
        //Showing the Header
        Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.width15,bottom: Dimensions.width15),
            padding:EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    /*
                      Re-Usable Custom Widgets
                      */
                    BigText(text: "South Africa",color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: 'Johannesburg',color: Colors.black54,),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    child: const Icon(Icons.search,color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // Showing the Body
        Expanded(child: SingleChildScrollView(
          child: const FoodPageBody(),
        ))
      ],
    ),
        onRefresh: _loadResource);
  }
}
