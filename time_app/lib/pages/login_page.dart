import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:time_app/config.dart';
import 'package:time_app/models/login_request_model.dart';
import 'package:time_app/services/api_service.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child: _FormUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 3,
            key: UniqueKey()),
      ),
    );
  }

  Widget _FormUI(BuildContext context) {
   
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
                    Color.fromARGB(255, 212, 211, 211),
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              )),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/time.jpg",
                  width: 350, fit: BoxFit.contain),
            )
          ]),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
          child: Text(
            "LOGIN",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.brown),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
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
            const SizedBox(
              height: 20),
              Center(
                child: FormHelper.submitButton("Login", () {
                  if(validateAndSave()){
                    setState(() {
                      isAPIcallProcess =true;
                    });
                    LoginRequestModel model = LoginRequestModel(
                    username: username,
                    password: password,
                  );
                   
                  APIService.login(model).then(
                    (response) {
                      setState(() {
                       isAPIcallProcess = false;
                      });
                     if (response){

                    Navigator.pushNamedAndRemoveUntil(
                        context,'/home', 
                        (route) => false);
                    }
                    else {
                      FormHelper.showSimpleAlertDialog(context, config.appName,"invalid Username/Password!","OK", (){
                        Navigator.pop(context);
                      });
                    };

                  });
                  }
                },
                btnColor:Colors.white,
                borderColor:Colors.brown,
                txtColor:Colors.brown,
                borderRadius: 10
                 ),
              ),
            
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right:25,top: 10),
                child: RichText(
                  text:  TextSpan(style: const TextStyle(
                    color: Colors.brown,fontSize: 14.0
                  ),
                  children:<TextSpan>[
                    TextSpan(
                      text: ' Forgot Password ?',style: const TextStyle(
                        color: Colors.brown,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        print("FORGET PASSWORD");
                      },
                    ),
                  ]),),
              ),

            ),
            const SizedBox(
              height: 18,
            ),
            const Center(
              child: Text("OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.brown,
              ),),
            ),
              const SizedBox(
              height: 18,
            ),
             Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right:25,top: 10),
                child: RichText(
                  text:  TextSpan(style: const TextStyle(
                    color: Colors.brown,fontSize: 14.0
                  ),
                  children:<TextSpan>[
                    const TextSpan( text:"Dont have a account yet",style: TextStyle(
                      color: Colors.brown,
                      
                    )),

                    TextSpan(
                      text: ' SIGN UP',style: const TextStyle(
                        color: Colors.brown,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                     Navigator.pushNamed(context,'/Signup');
                      },
                    ),
                  ]),),
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
