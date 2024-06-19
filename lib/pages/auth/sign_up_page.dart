import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/%20app_textfield.dart';

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
          AppTextField(textController: emailController,
              hintText: "Email",
              icon: Icons.email)

        ],
      ),
    );
  }
}
