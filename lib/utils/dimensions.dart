import 'package:get/get.dart';
class Dimensions{

  static double screenheight = Get.context!.height;
  static double screenwidth = Get.context!.width;

  static double pageView = screenheight/2.64;
  static double pageViewContainer = screenheight/3.84;
  static double pageViewTextContainer = screenheight/7.03;

  // dyanamic height padding and margin
  static double height10 = screenheight/84.4;
  static double height15 = screenheight/56.27;
  static double height20 = screenheight/42.2;
  static double height30 = screenheight/28.13;
  static double height45 = screenheight/18.76;

  // dyanamic width padding and margin
  static double width10 = screenheight/84.4;
  static double width15 = screenheight/56.27;
  static double width20 = screenheight/42.2;
  static double width30 = screenheight/28.13;
  static double width45 = screenheight/18.76;

  //font size
  static double font16 = screenheight/52.75;
  static double font20 = screenheight/42.2;
  static double font26 = screenheight/32.46;

  static double radius20 = screenheight/42.2;
  static double radius15 = screenheight/56.27;
  static double radius30 = screenheight/28.13;

  //icon size
  static double iconSize24 = screenheight/35.17 ;
  static double iconSize16 = screenheight/52.75 ;

  //listview size
  static double listViewImgSize = screenwidth/3.25;
  static double listViewTextSize = screenwidth/3.9;

  //popular food
  static double popularFoodImgSize = screenheight/2.41;

  //splashscreen
  static double splashImg = screenheight/3.375;

  //bottom height
  static double bottomHeightBar = screenheight/7.03;

}