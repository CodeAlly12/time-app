import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

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
    var person;
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
                color: Colors.indigo),
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
              borderFocusColor: Colors.indigo.shade200,
              prefixIconColor: Colors.indigo.shade200,
              borderColor: Colors.indigo.shade200,
              textColor: Colors.indigo,
              hintColor: Colors.indigo.withOpacity(0.7),
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
              borderFocusColor: Colors.indigo.shade200,
              prefixIconColor: Colors.indigo.shade200,
              borderColor: Colors.indigo.shade200,
              textColor: Colors.indigo,
              hintColor: Colors.indigo.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
            ))
      ],
    ));
  }
}
