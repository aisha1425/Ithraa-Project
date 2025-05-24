import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/bottomBarNav.dart';
import 'package:ithraa/models/user.dart';
import 'package:ithraa/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String error = '';

  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("email")) {
      String type = sharedPreferences.getString("type")!;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => BottomBarNav()));
    }
  }

  void login(BuildContext context) async {
    Map res =
        await apiLogin(emailController.text, passwordController.text, context);

    if (res.containsKey("error")) {
      setState(() {
        error = res['error'];
      });
    } else {
      print(res);
      User loggedUser = User.fromJson(res);
      if (loggedUser.type == "Local Business") {
        if (loggedUser.status == 1) {
          storeUserName(loggedUser);
        } else if (loggedUser.status == 0) {
          setState(() {
            error =
                "Please wait until admin handle your data , Try again later";
          });
        } else if (loggedUser.status == 2) {
          setState(() {
            error =
                "Admin rejeted your documents , please contact admin at admin@admin.com";
            print(error);
          });
        }
      } else {
        storeUserName(loggedUser);
      }
    }
  }

  void storeUserName(User loggedUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("email", loggedUser.email);
    sharedPreferences.setString("image", loggedUser.image!);
    sharedPreferences.setString("username", loggedUser.username);
    sharedPreferences.setString("type", loggedUser.type!);

    if (loggedUser.type! != "Student") {
      sharedPreferences.setString("businessType", loggedUser.businessType!);
    }

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => BottomBarNav()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "Login",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xffF5F5F5),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/ithraa.png',
                  height: 150,
                ),
              ),
              SizedBox(
                child: Text(
                  "Wellcome Back",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                child: Text(
                  "Please Login to your account to continue",
                ),
              ),
              SizedBox(
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1)),
                  ),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1)),
                  ),
                ),
              ),
              if (error.length > 1)
                SizedBox(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade400),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          login(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )))
              ]),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignUp()));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
