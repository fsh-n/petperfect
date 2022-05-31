import 'package:petperfect/domain/entity/dummy_data.dart';

class DummyDataModel extends DummyData {
  DummyDataModel({required String title, required String body})
      : super(title, body);

  // From Json
  factory DummyDataModel.fromJson(Map<String, dynamic> map) {
    return DummyDataModel(
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}
