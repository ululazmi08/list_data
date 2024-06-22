import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_viapulsa/services/end_point.dart';

class HomeServices {
  static Future dataList() async {
    print('dataList Service');
    var response = await http.get(Uri.parse('$baseUrl/api/items'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Data List RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future addList(String title, String description) async {
    print('addList Service');
    var response = await http.post(Uri.parse('$baseUrl/api/items'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'title': title,
          'description': description,
        },
      ),
    );

    debugPrint("Add List RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future editList(String title, String description, String id) async {
    print('editList Services');
    var response = await http.post(Uri.parse('$baseUrl/api/items/update/$id'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'title': title,
          'description': description,
        },
      ),
    );

    debugPrint("Edit List RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future deleteList(String id) async {
    print('deleteList Service');
    var response =
        await http.post(Uri.parse('$baseUrl/api/items/delete/$id'), headers: {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    });

    debugPrint("Delete List RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }
}
