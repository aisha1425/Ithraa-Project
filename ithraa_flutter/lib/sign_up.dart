import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ithraa/models/user.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/bottomBarNav.dart';
import 'package:ithraa/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _selectedUserType = 'Student';

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController commerceController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String? filePath;
  String error = '';
  String selectedUniversityLocation = 'العقيق';
  String selectedBusinessType = 'Accomindation Agent';

  List<String> universityLocations = ['العقيق', 'بهر', 'شهبه'];
  List<String> businessType = [
    'Accomindation Agent',
    'Transport Agent',
    'Offers Provider'
  ];

  File? commerceFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        commerceFile = File(filePath!);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void signup(BuildContext context) async {
    User user = User(
        email: emailController.text,
        password: passwordController.text,
        username: fullNameController.text,
        contact: contactController.text,
        date: dateController.text,
        location: locationController.text,
        major: majorController.text,
        universityLocation: selectedUniversityLocation,
        phone: phoneController.text,
        businessType: selectedBusinessType,
        regNumber: commerceController.text,
        website: websiteController.text,
        type: _selectedUserType,
        regFile: filePath);

    Map res = await apiSignUp(user, commerceFile, context);

    if (res.containsKey("error")) {
      setState(() {
        error = res['error'];
      });
    } else {
      User loggedUser = User.fromJson(res);

      if (loggedUser.type == "Local Business") {
        if (loggedUser.status == 1) {
          storeUserName(loggedUser);
        } else if (loggedUser.status == 0) {
          setState(() {
            error =
                "Please wait until admin handle your data , Try again later";
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
          "Sign Up",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffF5F5F5),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              SizedBox(
                height: 10,
              ),
              // Text("select account type : "),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Radio<String>(
                          value: 'Student',
                          groupValue: _selectedUserType,
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value!;
                            });
                          }),
                      horizontalTitleGap: 0,
                      title: Text('Student'),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Radio<String>(
                          value: 'Local Business',
                          groupValue: _selectedUserType,
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value!;
                            });
                          }),
                      horizontalTitleGap: 0,
                      title: Text('Local Business'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: (_selectedUserType == "Student")
                        ? "Full Name"
                        : "Business Name",
                    suffixIcon: Icon(Icons.edit),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1)),
                  ),
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
                      return 'Invalid Phone';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1)),
                  ),
                ),
              ),
              if (_selectedUserType != "Student")
                SizedBox(
                  child: DropdownButtonFormField(
                      value: selectedBusinessType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1)),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: businessType.map((String item) {
                        return DropdownMenuItem(child: Text(item), value: item);
                      }).toList(),
                      onChanged: (String? value) {
                        selectedBusinessType = value!;
                      }),
                ),
              if (_selectedUserType == "Student")
                SizedBox(
                  child: TextFormField(
                    controller: majorController,
                    decoration: InputDecoration(
                      hintText: "Major",
                      suffixIcon: Icon(Icons.work),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              if (_selectedUserType == "Student")
                SizedBox(
                  child: DropdownButtonFormField(
                      value: selectedUniversityLocation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1)),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: universityLocations.map((String item) {
                        return DropdownMenuItem(child: Text(item), value: item);
                      }).toList(),
                      onChanged: (String? value) {
                        selectedUniversityLocation = value!;
                      }),
                ),
              if (_selectedUserType == "Student")
                SizedBox(
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Date of birth",
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),

              if (_selectedUserType != "Student")
                SizedBox(
                  child: TextFormField(
                    controller: commerceController,
                    decoration: InputDecoration(
                      hintText: "Commercial Registration Number",
                      suffixIcon: Icon(Icons.woo_commerce),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              if (_selectedUserType != "Student")
                SizedBox(
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Location",
                      suffixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),

              if (_selectedUserType != "Student")
                SizedBox(
                  child: TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Contact Number",
                      suffixIcon: Icon(Icons.contact_emergency),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              if (_selectedUserType != "Student")
                SizedBox(
                  child: TextFormField(
                    controller: websiteController,
                    decoration: InputDecoration(
                      hintText: "Website (optional)",
                      suffixIcon: Icon(Icons.link),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              if (_selectedUserType != "Student")
                ElevatedButton(
                  onPressed: pickFile,
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.upload),
                      Text("Upload Commercial Registration"),
                    ],
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
              SizedBox(
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
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
                          signup(context);
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white),
                        )))
              ]),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()));
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
