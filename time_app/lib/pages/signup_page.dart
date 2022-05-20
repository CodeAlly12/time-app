
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:time_app/config.dart';
import 'package:time_app/models/register_request.dart';
import 'package:time_app/services/api_service.dart';



class Signup_page extends StatefulWidget {
  const Signup_page({Key? key}) : super(key: key);

  @override
  _Signup_pageState createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;
   

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child:_signupUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 3,
            key: UniqueKey()),
      ),
    );
  }

  Widget _signupUI(BuildContext context) {
   
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                     Color.fromARGB(255, 212, 211, 211),
                      Color.fromARGB(255, 212, 211, 211)
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
              )),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/time.webp",
                  width: 350, fit: BoxFit.contain),
            )
          ]),
        ),
      
        Padding(
          padding: const EdgeInsets.only(bottom: 5,top:10),
          child: FormHelper.inputFieldWidget(context, "username", "Username",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Username can't be empty";
            }
            return null;
          }, (onSavedVal) {
            username = onSavedVal;
          },
              borderFocusColor: Colors.brown,
              prefixIconColor: Colors.brown,
              borderColor: Colors.brown,
              textColor: Colors.brown,
              hintColor: Colors.brown.withOpacity(0.7),
              borderRadius: 10),
        ),
        
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "password can't be empty";
                }
                return null;
              },
              (onSavedVal) {
                username = onSavedVal;
              },
              borderFocusColor: Colors.brown,
              prefixIconColor: Colors.brown,
              borderColor: Colors.brown,
              textColor: Colors.brown,
              hintColor: Colors.brown.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(onPressed:() 
              {setState(() {
                hidePassword =!hidePassword;
              });},
              color: Colors.brown.withOpacity(0.7) ,
               icon: Icon(hidePassword ? Icons.visibility_off:Icons.visibility) )
            )),
            Padding(
          padding:  const EdgeInsets.only(bottom: 5,top:10),
          child: FormHelper.inputFieldWidget(context, "Email", "Email",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Email can't be empty";
            }
            return null;
          }, (onSavedVal) {
            email = onSavedVal;
          },
              borderFocusColor: Colors.brown,
              prefixIconColor: Colors.brown,
              borderColor: Colors.brown,
              textColor: Colors.brown,
              hintColor: Colors.brown.withOpacity(0.7),
              borderRadius: 10),),
        
             const SizedBox(
              height: 20),
              Center(
              child: FormHelper.submitButton("SIGNUP", () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  RegisterRequestModel model= RegisterRequestModel(
                  username: username,
                  password:  password,
                  email: email);


                  APIService.Register(model).then(
                    (response) {
                      setState(() {
                        isAPIcallProcess= false;
                      });

                      if (response.data != null) { 
                        FormHelper.showSimpleAlertDialog(
                          context,
                          config.appName,
                          "Signup Successful. Please login to the account",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,'/',
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(context, config.appName,response.message,"OK ", (){
                          Navigator.of(context).pop();
                        },);
                      }
                    },
                  );
                }
                  
                
                },
                btnColor:Colors.white,
                borderColor:Colors.brown,
                txtColor:Colors.brown,
                borderRadius: 10
                 ),
              ),
      ],
    ));
  }

  bool validateAndSave (){
    final form  = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    
    }
    else {
      return false;
    }
  }
}
