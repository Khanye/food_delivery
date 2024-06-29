import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/%20app_textfield.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showSnackBar("Type your email address",title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showSnackBar("Type in a valid email address",title: "Email Address");
      }else if(password.isEmpty){
        showSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showSnackBar("Your password is too short",title: "Password");
      }
      else{

        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showSnackBar(status.message);
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:(authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenheight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenheight*0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part 1.png"
                    ),
                  ),
                ),
              ),

              //Welcome Text - Hello Sign in to your account
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //your email
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //your password
              AppTextField(textController: passwordController,
                  hintText: "Password",
                  isObscure: true,
                  icon: Icons.password_sharp),


              SizedBox(height: Dimensions.height20,),
              //Tag Line
              Row(
                children:[
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),
                  SizedBox(width: Dimensions.width30,)
                ],
              ),
              SizedBox(height: Dimensions.screenheight*0.05,),
              //Sign Up Button
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenwidth/2,
                  height: Dimensions.screenheight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2 ,
                      color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenheight*0.05,),
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=> const SignUpPage(),transition: Transition.fadeIn),
                            text: " Create",
                            style: TextStyle(
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.bold
                            ))
                      ]
                  )),

            ],
          ),
        ): const CircularProgressIndicator();
      },)
    );
  }
}
