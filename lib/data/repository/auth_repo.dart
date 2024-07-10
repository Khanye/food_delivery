import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });


  Future<Response> registrationRepo(SignUpModel model) async {

    //body variable ie the model parameter is an object not a json and the server
    //accepts only a json so we have to convert the object to a json which we will
    //do in the model ie create the method in the signup_model.dart file
    return await apiClient.postData(AppConstants.REGISTRATION_URI, model.toJson());
  }

  Future<Response> login(String email,String password) async {

    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email,"password":password,"phone":sharedPreferences.getString(AppConstants.PHONE)});
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLoggedIn () {
    return sharedPreferences.containsKey(AppConstants.TOKEN) ;
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.upDateHeaders(token);
    return  await sharedPreferences.setString(AppConstants.TOKEN , token);
  }

  Future<void>saveUserNumberAndPassword(String number,String password)async {
     try{
        await sharedPreferences.setString(AppConstants.PHONE , number);
        await sharedPreferences.setString(AppConstants.PASSWORD , password);

     }catch(e){
           throw e;
     }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token ='';
    apiClient.upDateHeaders('');
    return true;
  }

}