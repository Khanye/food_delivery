import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText(text: "Profile",size: 24, color: Colors.white,)),
      ),
      body: GetBuilder<UserController>(builder: (userController){
       return _userLoggedIn?
       (userController.isLoading?Container(
         width: double.maxFinite,
         margin: EdgeInsets.only(top: Dimensions.height20),
         child: Column(
           children: [
             //profile icon
             AppIcon(icon: Icons.person,
               backgroundColor: AppColors.mainColor,
               iconColor: Colors.white,
               iconSize: Dimensions.height30+ Dimensions.height45,
               size: Dimensions.height15*10,),
             SizedBox(height: Dimensions.height30,),
             Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     //name
                     AccountWidget(
                         appIcon: AppIcon(icon: Icons.person,
                           backgroundColor: AppColors.mainColor,
                           iconColor: Colors.white,
                           iconSize: Dimensions.height10*5/2,
                           size: Dimensions.height10*5,),

                         bigText: BigText(text: userController.userModel.name,)
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //phone
                     AccountWidget(
                         appIcon: AppIcon(icon: Icons.phone,
                           backgroundColor: AppColors.yellowColor,
                           iconColor: Colors.white,
                           iconSize: Dimensions.height10*5/2,
                           size: Dimensions.height10*5,),

                         bigText: BigText(text: userController.userModel.phone,)
                     ),
                     SizedBox(height: Dimensions.height20,),
                     // email
                     AccountWidget(
                         appIcon: AppIcon(icon: Icons.email,
                           backgroundColor: AppColors.yellowColor,
                           iconColor: Colors.white,
                           iconSize: Dimensions.height10*5/2,
                           size: Dimensions.height10*5,),

                         bigText: BigText(text: userController.userModel.email,)
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //address
                     AccountWidget(
                         appIcon: AppIcon(icon: Icons.location_on,
                           backgroundColor: AppColors.yellowColor,
                           iconColor: Colors.white,
                           iconSize: Dimensions.height10*5/2,
                           size: Dimensions.height10*5,),

                         bigText: BigText(text: "16 Park Mansions,Germiston",)
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //messages
                     AccountWidget(
                         appIcon: AppIcon(icon: Icons.message_outlined,
                           backgroundColor: Colors.redAccent,
                           iconColor: Colors.white,
                           iconSize: Dimensions.height10*5/2,
                           size: Dimensions.height10*5,),

                         bigText: BigText(text: "Messages",)
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //messages
                     GestureDetector(
                       onTap: (){
                         if(Get.find<AuthController>().userLoggedIn()){
                           Get.find<AuthController>().clearSharedData();
                           Get.find<CartController>().clear();
                           Get.find<CartController>().clearCartHistory();
                           Get.offNamed(RouteHelper.getSigninPage());
                         }else{
                           print("You Logged Out");
                         }
                       },
                       child: AccountWidget(
                           appIcon: AppIcon(icon: Icons.logout_rounded,
                             backgroundColor: Colors.redAccent,
                             iconColor: Colors.white,
                             iconSize: Dimensions.height10*5/2,
                             size: Dimensions.height10*5,),

                           bigText: BigText(text: "Log Out",)
                       ),
                     ),
                     SizedBox(height: Dimensions.height20,),
                   ],
                 ),
               ),
             )
           ],
         ),
       ):
       CircularProgressIndicator()):
       Container(child: Center(child: Text("You must login")));
      }),
    );
  }
}
