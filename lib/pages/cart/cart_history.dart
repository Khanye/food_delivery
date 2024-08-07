import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
   CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String,int> cartItemsPerOrder= Map();
    for(int i=0; i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time! ,()=>1);
      }
    }

    List<int> cartItemsPerToList(){
      // shorthand return cartItemsPerOrder.entries.map((e) => e.value).toList();
      return cartItemsPerOrder.entries.map((e){
        return e.value;
      }).toList();
    }


    List<String> cartOrderTimeToList(){
     return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerToList();//3,2,3
    //print(orderTimes);
    var listCounter=0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat =  DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
            Container(
              height: Dimensions.height10*10,
              color: AppColors.mainColor,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: "Cart History",color: Colors.white,),
                  AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,)
                ],
              ),
            ),
            GetBuilder<CartController>(builder: (_cartController){
              return _cartController.getCartHistoryList().length>0?
              Expanded(child: Container (
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,child: ListView (
                      children: [
                        for(int i =0;i<itemsPerOrder.length;i++)
                          Container(
                            height: Dimensions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index){
                                        if(listCounter<getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index<=2?Container(
                                          margin: EdgeInsets.only(right:Dimensions.width10/2),
                                          height: Dimensions.height20*4,
                                          width: Dimensions.width20*4,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.height15/2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                   image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URI+getCartHistoryList[listCounter-1].img!
                                                  )
                                              )
                                          ),
                                        ):Container();
                                      }),
                                    ),
                                    Container(
                                      height: Dimensions.height20*4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "Total",color: AppColors.titleColor),
                                          BigText(text: itemsPerOrder[1].toString()+" Items",color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap:(){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int,CartModel> moreOrder ={};
                                              for(int j=0;j<getCartHistoryList.length;j++){
                                                if(getCartHistoryList[j].time == orderTime[i]) {
                                                  // print("My order time is " + orderTime[i]);
                                                  // print("The cart or product id is " + getCartHistoryList[j].id.toString());// The cart or product is 8
                                                  // print("The cart or product id is " + getCartHistoryList[j].toString());// The cart or product id is Instance of 'CartModel'
                                                  // print("The cart or product id is " + getCartHistoryList[j].product!.id.toString());// The cart or product 2,3 4
                                                  // print("Product info is "+ jsonEncode(getCartHistoryList[j]));
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child:Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                  border: Border.all(width: 1,color: AppColors.mainColor)
                                              ),
                                              child: SmallText(text: "one more",color: AppColors.mainColor,),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),)
              )):
              SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                  child: NoDataPage(
                    text: "You have not bought anything so far",
                    imgPath: "assets/image/empty_box.png",),
                ),
              );
            })
        ],
      ),
    );
  }
  /*
  Practised on dartpad.dev/?
  */
/*  void main(){
  List<Map<String,dynamic>> getCartHistoryList = [
    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-05 02:35:08.797515"},
    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-05 02:35:08.797515"},
    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-05 02:35:08.797515"},

    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-06 02:35:08.797515"},

    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-07 02:35:08.797515"},
    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-07 02:35:08.797515"},
    {"id":1,"name":"Creole Rice SideDish Recipe","time":"2023-02-07 02:35:08.797515"}
  ];

     *//*  for(int i=0;i<getCartHistoryList.length;i++){
          print(getCartHistoryList[i]["time"]);
        }*//*
    Map<String,int> cartItemsPerOrder= Map();
    for(int i=0; i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i]["time"])){
        cartItemsPerOrder.update(getCartHistoryList[i]["time"], (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i]["time"],()=>1);
      }
    }

    List<int> cartOrderTimeToList(){
     // shorthand return cartItemsPerOrder.entries.map((e) => e.value).toList();
      return cartItemsPerOrder.entries.map((e){
        return e.value;
      }).toList();
    }

    List<int> orderTimes = cartOrderTimeToList();
    //print(orderTimes);
    var saveCounter=0;
    for(int x=0;x<cartItemsPerOrder.length;x++){
      for(int y=0;y<orderTimes[x];y++){
         print("My order is "+getCartHistoryList[saveCounter++].toString());
      }
    }
  }*/
}
