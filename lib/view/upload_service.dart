import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadService {

  // 🔥 Convert JSON
  static List<Map<String, dynamic>> convertData(Map jsonData) {
    List fields = jsonData['fields'];
    List data = jsonData['data'];

    List<Map<String, dynamic>> result = [];

    for (var row in data) {
      Map<String, dynamic> obj = {};

      for (int i = 0; i < fields.length; i++) {
        obj[fields[i]['label']] = row[i];
      }

      result.add(obj);
    }

    return result;
  }

  // 🔥 Upload to Firebase
  // static Future<void> uploadJsonToFirebase() async {
  //   try {
  //     // Load JSON
  //     String jsonString = await rootBundle.loadString('assets/data.json');
  //     Map<String, dynamic> jsonData = json.decode(jsonString);

  //     // Convert
  //     List<Map<String, dynamic>> converted = convertData(jsonData);

  //     var db = FirebaseFirestore.instance;

  //     WriteBatch batch = db.batch();

  //     for (var item in converted) {
  //       var docRef = db.collection("gva_data").doc();

  //       batch.set(docRef, {
  //         "industry": item['industry'],
  //         "current_price": item['current_price'],
  //       });
  //     }

  //     await batch.commit();

  //     print("✅ DATA UPLOADED SUCCESSFULLY");
  //   } catch (e) {
  //     print("❌ ERROR: $e");
  //   }
  // }

  static Future<void> uploadJsonToFirebase() async {
  try {
    print("🔥 Upload started");

    String jsonString = await rootBundle.loadString('assets/data.json');
    print("✅ JSON Loaded");

    Map<String, dynamic> jsonData = json.decode(jsonString);

    List<Map<String, dynamic>> converted = convertData(jsonData);
    print("✅ Converted Length: ${converted.length}");

    var db = FirebaseFirestore.instance;

    for (var item in converted.take(5)) {  // 🔥 only 5 for testing
      await db.collection("gva_data").add({
        "industry": item['industry'],
        "current_price": item['current_price'],
      });
    }

    print("✅ Upload SUCCESS");

  } catch (e) {
    print("❌ ERROR: $e");
  }
}
}