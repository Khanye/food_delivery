import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel ;
  UserModel? get userModel =>_userModel;


  bool get isLoading =>_isLoading;
  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading=true;
      print("got userinfo okay");
      responseModel = ResponseModel(true, "successful");
      print("getuserinfo not successful");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}