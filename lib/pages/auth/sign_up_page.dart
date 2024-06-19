import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: Dimensions.screenheight*0.05,),
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
          Container(
            margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1, 10),
                  color: Colors.grey.withOpacity(0.2)
                )
              ]
            ),
            child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  //hinttext,//prefixx icon,//focusedborder//enabledBorder//border
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email, color: AppColors.yellowColor,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.white,
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                  )
                ),
            ),
          )
        ],
      ),
    );
  }
}
