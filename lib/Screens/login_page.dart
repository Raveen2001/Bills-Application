import 'dart:math';

import 'package:anbu_stores_bills/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode emailFocus = FocusNode(), passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool showError = false, isLoggingIn = false;
  String email, password;
  final key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    // isLoggingIn = false;
    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
              width: Utils.size.width,
              height: Utils.size.height,
            ),
            Positioned(
              top: Utils.size.height * 0.25,
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: "RussoOne",
                    // backgroundColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).backgroundColor),
              ),
            ),
            Positioned(
                width: Utils.size.width * 0.9,
                height: Utils.size.height * 0.5,
                bottom: Utils.size.height * 0.15,
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 15, right: 15, bottom: 20),
                    child: Form(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: emailFocus,
                            onSaved: (value) {
                              email = value;
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                              Focus.of(context).requestFocus(passwordFocus);
                            },
                            validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "This field is required"),
                                EmailValidator(
                                    errorText: "Enter a valid Email"),
                              ]
                            ),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Theme.of(context).primaryColor,
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            focusNode: passwordFocus,
                            onSaved: (value) {
                              password = value;
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => login(),
                            validator: MinLengthValidator(5,
                                errorText: "Enter a valid Password"),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            cursorColor: Theme.of(context).primaryColor,
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder()),
                          ),
                          Spacer(),
                          if(showError)
                          Text("Incorrect Username or Password !", style: TextStyle(
                            color: Colors.red
                          ),),
                          Spacer(),
                          Container(
                            width: 200,
                            height: 50,
                            child: FlatButton(
                              onPressed: isLoggingIn ? null : login,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              child: isLoggingIn? Container( width: 30, height: 30,child: CircularProgressIndicator()) :Text("Login", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                              ),),
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void login() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      setState(() {
        isLoggingIn = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          setState(() {
            showError = true;
          });
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoggingIn = false;
      });
    }
  }
}
