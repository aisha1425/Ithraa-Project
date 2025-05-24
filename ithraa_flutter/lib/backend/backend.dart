import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ithraa/models/job.dart';
import 'package:ithraa/models/offer.dart';
import 'package:ithraa/models/user.dart';

import 'package:ithraa/models/Policy.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/models/contact.dart';
import 'package:ithraa/models/transport.dart';
import 'package:ithraa/utils/urls.dart';

Future<Map> apiLogin(
    String email, String password, BuildContext context) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}login"), body: {
    "email": email,
    "password": password,
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return json.decode(response.body);
  }
}

Future<Map> apiSignUp(
    User user, File? commerceFile, BuildContext context) async {
  Uri url = Uri.parse("${desktopUrl}signup");

  var request = http.MultipartRequest("POST", url);

  request.fields['username'] = user.username;
  request.fields['type'] = user.type ?? '';
  request.fields['email'] = user.email;
  request.fields['phone'] = user.phone ?? '';
  request.fields['businessType'] = user.businessType ?? '';
  request.fields['date'] = user.date ?? '';
  request.fields['major'] = user.major ?? '';
  request.fields['universityLocation'] = user.universityLocation ?? '';
  request.fields['regNumber'] = user.regNumber ?? '';
  request.fields['regFile'] = user.regFile ?? '';
  request.fields['contact'] = user.contact ?? '';
  request.fields['website'] = user.website ?? '';
  request.fields['location'] = user.location ?? '';
  request.fields['password'] = user.password!;

  if (commerceFile != null) {
    request.files.add(
        await http.MultipartFile.fromPath('commerceFile', commerceFile.path));
  }

  request.headers.addAll({
    "Accept": "application/json",
  });

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  return json.decode(response.body);
}

Future<Map> apiUpdate(User user, File? commerceFile, File? userImageFile,
    BuildContext context) async {
  Uri url = Uri.parse("${desktopUrl}updateProfile");

  var request = http.MultipartRequest("POST", url);

  request.fields['username'] = user.username;
  request.fields['type'] = user.type ?? '';
  request.fields['email'] = user.email;
  request.fields['phone'] = user.phone ?? '';
  request.fields['businessType'] = user.businessType ?? '';
  request.fields['date'] = user.date ?? '';
  request.fields['major'] = user.major ?? '';
  request.fields['universityLocation'] = user.universityLocation ?? '';
  request.fields['regNumber'] = user.regNumber ?? '';
  request.fields['regFile'] = user.regFile ?? '';
  request.fields['contact'] = user.contact ?? '';
  request.fields['website'] = user.website ?? '';
  request.fields['location'] = user.location ?? '';
  request.fields['password'] = user.password!;

  if (kDebugMode) {
    print(user.businessType! + " updated");
  }

  if (commerceFile != null) {
    request.files.add(
        await http.MultipartFile.fromPath('commerceFile', commerceFile.path));
  }
  if (userImageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', userImageFile.path));
  }

  request.headers.addAll({
    "Accept": "application/json",
  });

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  return json.decode(response.body);
}

Future<List<Accomindation>?> loadAllAccomindation(String email) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}getAllAccomindation"), body: {
    "userEmail": email
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    print(response.body);
    List body = jsonDecode(response.body);
    try {
      List<Accomindation> accomindations = body
          .map(
            (dynamic item) => Accomindation.fromJson(item),
          )
          .toList();
      return accomindations;
    } catch (error) {
      print(error);

      return null;
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<List<Policy>> loadAllPolicies() async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}policies"), headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    List body = jsonDecode(response.body);
    try {
      List<Policy> policies = body
          .map<Policy>(
            (dynamic item) => Policy.fromJson(item),
          )
          .toList();
      print(policies);
      return policies;
    } catch (error) {
      print(error);

      return [];
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<List<Transport>> loadAllTransports(String email) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}transport"), body: {
    "userEmail": email
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    List body = jsonDecode(response.body);
    try {
      List<Transport> transports = body
          .map<Transport>(
            (dynamic item) => Transport.fromJson(item),
          )
          .toList();
      print(transports);
      return transports;
    } catch (error) {
      print(error);

      return [];
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<List<Contact>> loadAllContacts() async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}contacts"), headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    List body = jsonDecode(response.body);
    try {
      List<Contact> contacts = body
          .map<Contact>(
            (dynamic item) => Contact.fromJson(item),
          )
          .toList();
      print(contacts);
      return contacts;
    } catch (error) {
      print(error);

      return [];
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<Map> loadUserApi(String email) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}profile"), body: {
    "email": email,
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    Map body = jsonDecode(response.body);
    return body;
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<List<Job>> loadAllJobs(String email) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}jobs"), body: {
    "userEmail": email
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    List body = jsonDecode(response.body);
    print(body);
    try {
      List<Job> jobs = body
          .map<Job>(
            (dynamic item) => Job.fromJson(item),
          )
          .toList();
      print(jobs);
      return jobs;
    } catch (error) {
      print(error);

      return [];
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<Map> addJobApi(Job job, bool? isUpdate, BuildContext context) async {
  String uri = desktopUrl;
  if (isUpdate != null && isUpdate == true) {
    uri += "editJob";
  } else {
    uri += "addJob";
  }
  http.Response response = await http.post(Uri.parse(uri), body: {
    "id": job.id.toString(),
    "title": job.title,
    "type": job.type,
    "description": job.description,
    "location": job.location,
    "salary": job.salary,
    "deadline": job.deadline,
    'userEmail': job.userEmail
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });

  return json.decode(response.body);
}

Future<List<Offer>> loadAllOffers(String email) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}offers"), body: {
    "userEmail": email
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  });
  if (response.statusCode == 200) {
    List body = jsonDecode(response.body);
    print(body);
    try {
      List<Offer> offers = body
          .map<Offer>(
            (dynamic item) => Offer.fromJson(item),
          )
          .toList();
      print(offers);
      return offers;
    } catch (error) {
      print(error);

      return [];
    }
  } else {
    print(response.body);
    return json.decode(response.body);
  }
}

Future<Map> addOfferApi(
    Offer offer, File? imageFile, bool isUpdate, BuildContext context) async {
  String routeUri = (isUpdate) ? "editOffer" : "addOffer";

  Uri url = Uri.parse(desktopUrl + routeUri);

  var request = http.MultipartRequest("POST", url);

  request.fields['id'] = offer.id.toString();
  request.fields['title'] = offer.title;
  request.fields['description'] = offer.description;
  request.fields['discount'] = offer.discount;
  request.fields['link'] = offer.link;
  request.fields['date'] = offer.date;
  request.fields['image'] = offer.image ?? '';
  request.fields['userEmail'] = offer.userEmail;

  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('imageFile', imageFile.path));
  }

  request.headers.addAll({
    "Accept": "application/json",
  });

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200 || response.statusCode == 422) {
    return json.decode(response.body);
  } else {
    return {
      'error': true,
      'status': response.statusCode,
      'message': response.body
    };
  }
}

Future<Map> addAccomindationApi(Accomindation item, File? imageFile,
    bool isUpdate, BuildContext context) async {
  String routeUri = (isUpdate) ? "editAccomindation" : "addAccomindation";
  Uri url = Uri.parse(desktopUrl + routeUri);

  var request = http.MultipartRequest("POST", url);
  request.fields['id'] = item.id.toString();
  request.fields['name'] = item.name;
  request.fields['type'] = "";
  request.fields['description'] = item.description ?? '';
  request.fields['call'] = item.call ?? '';
  request.fields['price'] = item.price ?? '';
  request.fields['distance'] = item.distance ?? '';
  request.fields['kitchen'] = item.kitchen ?? '';
  request.fields['laundary'] = item.laundary ?? '';
  request.fields['parking'] = item.parking ?? '';
  request.fields['bedrooms'] = item.bedrooms ?? '';
  request.fields['bathrooms'] = item.bathrooms ?? '';
  request.fields['internet'] = item.internet ?? '';

  request.fields['image'] = item.image ?? '';
  request.fields['userEmail'] = item.userEmail;

  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('imageFile', imageFile.path));
  }

  request.headers.addAll({
    "Accept": "application/json",
  });

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200 || response.statusCode == 422) {
    return json.decode(response.body);
  } else {
    return {
      'error': true,
      'status': response.statusCode,
      'message': response.body
    };
  }
}

Future<Map> deleteOfferApi(int id) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}deleteOffer"), body: {
    "id": id.toString(),
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });
  return json.decode(response.body);
}

Future<Map> deleteJobApi(int id) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}deleteJob"), body: {
    "id": id.toString(),
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });
  return json.decode(response.body);
}

Future<Map> deleteAccomindationApi(int id) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}deleteAccomindation"), body: {
    "id": id.toString(),
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });
  return json.decode(response.body);
}

Future<Map> deleteTransportApi(int id) async {
  http.Response response =
      await http.post(Uri.parse("${desktopUrl}deleteTransport"), body: {
    "id": id.toString(),
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });
  return json.decode(response.body);
}

Future<Map> addTransportApi(
    Transport item, bool isUpdate, BuildContext context) async {
  String routeUri = (isUpdate) ? "editTransport" : "addTransport";
  Uri url = Uri.parse(desktopUrl + routeUri);

  http.Response response = await http.post(url, body: {
    "id": item.id.toString(),
    "name": item.name,
    "type": item.type,
    "description": item.description,
    "cost": item.cost,
    "distance": item.distance,
    "availability": item.availability,
    'userEmail': item.userEmail
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });

  return json.decode(response.body);
}

Future<List> loadCountsApi(String email) async {
  Uri url = Uri.parse("${desktopUrl}loadCounts");

  http.Response response = await http.post(url, body: {
    "email": email,
  }, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
  });

  return json.decode(response.body);
}
