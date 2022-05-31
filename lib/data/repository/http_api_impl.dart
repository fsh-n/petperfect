import 'dart:convert';

import 'package:petperfect/data/model/DummyDataModel.dart';
import 'package:petperfect/data/repository/abstract/api.dart';
import 'package:http/http.dart' as http;

class HttpApiImpl extends Api {
  @override
  Future<List<DummyDataModel>> fetchDummyData() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      var dummyList = <DummyDataModel>[];
      if (data != null) {
        data.forEach((v) {
          dummyList.add(DummyDataModel.fromJson(v));
        });
      }
      return dummyList;
    }

    return <DummyDataModel>[];
  }

  @override
  Future<String> fetchImageUrl() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      String url = data['url'];
      if (url.endsWith('.jpg') || url.endsWith('.jpeg')) {
        return url;
      }
      // If it is not an image return hard code image
      return 'https://random.dog/a338fdf7-70aa-4a26-a2c2-357cdede7991.jpg';
    }

    throw Exception();
  }
}
