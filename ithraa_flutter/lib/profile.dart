import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/homeLocale.dart';
import 'package:ithraa/components/bottomBarNav.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/home.dart';
import 'package:ithraa/login.dart';
import 'package:ithraa/models/user.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
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

  File? imageFile;
  String? filePath;

  File? userImageFile;
  String? userFilePath;

  String error = '';
  String selectedUniversityLocation = 'العقيق';
  String selectedBusinessType = 'Accomindation Agent';

  List<String> universityLocations = ['العقيق', 'بهر', 'شهبه'];
  List<String> businessType = [
    'Accomindation Agent',
    'Transport Agent',
    'Offers Provider'
  ];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        imageFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> userPickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        userFilePath = result.files.single.path;
        userImageFile = File(result.files.single.path!);
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

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: Login(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void update(BuildContext context) async {
    User userUpdate = User(
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
        image: (userFilePath != null) ? userFilePath : user!.image,
        regFile: (filePath != null) ? filePath : user!.regFile);

    Map res = await apiUpdate(userUpdate, imageFile, userImageFile, context);

    if (res.containsKey("error")) {
      setState(() {
        error = res['error'];
      });
    } else {
      print(res);
      User loggedUser = User.fromJson(res);
      storeUserName(loggedUser);
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

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: BottomBarNav(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString("email");

    Map userMap = await loadUserApi(email!);
    try {
      user = User.fromJson(userMap);
      setState(() {
        fullNameController.text = user!.username;
        emailController.text = user!.email;
        phoneController.text = user!.phone ?? '';
        majorController.text = user!.major ?? '';
        selectedUniversityLocation = user!.universityLocation ?? '';
        selectedBusinessType = user!.businessType ?? '';
        dateController.text = user!.date ?? '';

        commerceController.text = user!.regNumber ?? '';
        contactController.text = user!.contact ?? '';
        websiteController.text = user!.website ?? '';
        locationController.text = user!.location ?? '';
        _selectedUserType = user!.type ?? 'Student';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Profile"),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (user != null)
                (user!.image! != '')
                    ? InkWell(
                        onTap: () {
                          userPickFile();
                        },
                        child: Image.network(
                          imageUrl + user!.image!,
                          width: 100,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          userPickFile();
                        },
                        child: Image.asset(
                          'assets/profileIcon.png',
                          width: 100,
                        ),
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
                  enabled: false,
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
              Row(spacing: 10, children: [
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
                          update(context);
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ))),
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade700),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          logout(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        )))
              ]),
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
