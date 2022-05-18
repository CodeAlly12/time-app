// class SignupRequestModel {
//   SignupRequestModel(String body, 
//       {this.username,
//        this.password, 
//       //  this.confirmPassword, 
//        this.email,  });

//  late final  String? username;
//   late final String? password;
//   // late final String? confirmPassword;
//   late final String? email;

  

//   SignupRequestModel.fromJson(Map<String, dynamic> json) {
//     username = json['username'];
//     password = json['password'];
//     // confirmPassword = json['confirm password'];
//     email = json['email'];
//   }



//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['username'] = username;
//     data['password'] = password;
//     // data['confirm password'] = confirmPassword;
//     data['email'] = email;
//     return data;
//   }
// }
class RegisterRequestModel {
  RegisterRequestModel(String body,  {
    this.username,
    this.password,
    this.email,
  });
  late final String? username;
  late final String? password;
  late final String? email;

   RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    return _data;
  }
}