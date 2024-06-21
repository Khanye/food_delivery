import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_snackbar.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/widgets/%20app_textfield.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
        "t.png",
        "f.png",
         "g.png"
    ];

    void _registration(){
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
         showSnackBar("Type your user name",title: "Name");
      }else if(phone.isEmpty){
        showSnackBar("Type your phone number",title: "Phone Number");
      }else if(email.isEmpty){
        showSnackBar("Type your email address",title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showSnackBar("Type in a valid email address",title: "Email Address");
      }else if(password.isEmpty){
        showSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showSnackBar("Your password is too short",title: "Password");
      }else{
        showSnackBar("All went weell",title: "PERFECT");
        SignUpModel model = SignUpModel(
            name: name,
            phone: phone,
            email: email,
            password: password);
        
        authController.registrationController(model).then((status){
          if(status.isSuccess){
            print("Registration Successful");
          }else{
            showSnackBar(status.message);
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            //your email
            AppTextField(textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20,),
            //your password
            AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp),
            SizedBox(height: Dimensions.height20,),
            //your name
            AppTextField(textController: nameController,
                hintText: "Name",
                icon: Icons.person),
            SizedBox(height: Dimensions.height20,),
            //your phone number
            AppTextField(textController: phoneController,
                hintText: "Phone",
                icon: Icons.phone),
            SizedBox(height: Dimensions.height20+Dimensions.height20,),

            //Sign Up Button
            GestureDetector(
              onTap: (){
                   _registration();
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
                      text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2 ,
                      color: Colors.white,),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            //Tag Line
            RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20
                  )
                )),
            SizedBox(height: Dimensions.screenheight*0.05,),
            RichText(
                text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16
                    )
                )),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                   radius: Dimensions.radius30,
                   backgroundImage: AssetImage(
                     "assets/image/"+signUpImages[index]
                   ),
                ),
              )),
            )

          ],
        ),
      ),
    );
  }
}
