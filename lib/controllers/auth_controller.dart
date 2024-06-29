
import 'package:food_delivery/data/repository/auth_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:get/get.dart';

import '../models/signup_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
 });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registrationController(SignUpModel signUpModel) async {
     _isLoading = true;
     update();
     Response response = await authRepo.registrationRepo(signUpModel);
     late ResponseModel responseModel;
     if(response.statusCode == 200){
         authRepo.saveUserToken(response.body["token"]);
         responseModel = ResponseModel(true, response.body["token"]);
     }else{
       responseModel = ResponseModel(true, response.statusText!);
     }
     _isLoading = false;
     update();
     return responseModel;
  }

  Future<ResponseModel> login(String email,String password) async {
    print("Getting token");
    print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Backend Token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      //print("Login not successful");
      //print(response.body["token"]);
      responseModel = ResponseModel(true, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number,String password){
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn () {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}