import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:time_app/config.dart';
import 'package:time_app/models/login_request_model.dart';
import 'package:time_app/models/login_response_model.dart';
import 'package:time_app/models/register_request.dart';
import 'package:time_app/services/shared_service.dart';

class APIService {
  static var client = http.Client();

 static Future<bool> login (LoginRequestModel model ) async {
  Map <String,String> requestHeaders = {'Content-Type': 'application/json',

  };

  var url = Uri.http(config.apiURL, config.loginAPI);

  var response = await  client.post ( 
  url, 
  headers: requestHeaders,
  body: jsonEncode(model.toJson ())
  );
  
  if (response.statusCode == 200){
    // SHARED
    await SharedService.setLoginDetails(loginResponseJson(response.body));
    return true;
  }
    else {
    return false;
    
  }
   }
  
 static Future< RegisterRequestModel>  Register ( RegisterRequestModel model, ) async {
  Map <String,String> requestHeaders = {'Content-Type': 'application/json',

  };

  var url = Uri.http(config.apiURL, config.SignupAPI);

  var response = await  client.post ( 
  url, 
  headers: requestHeaders,
  body: jsonEncode(model.toJson ()),
  );

  return  RegisterRequestModel(response.body);
  }
}
 
  

