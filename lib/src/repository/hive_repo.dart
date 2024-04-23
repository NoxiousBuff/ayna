import 'package:ayna/src/models/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRepo {
  HiveRepo();

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    await Hive.openBox<Message>('messages');
    await Hive.openBox("data");
  }

  void saveAndReplace(dynamic key, dynamic value) async {
    await Hive.box('data').clear();
    Hive.box('data').put(key, value);
    print("Created user in hive : $value");
  }

  dynamic getUserData({String? key, dynamic defaultValue}) {
    return Hive.box('data').get(key, defaultValue: defaultValue);
  }

  void deleteUser(dynamic key) {
    Hive.box('data').delete(key);
    print('deted user with $key');
  }

  Future<void> deleteData() async {
    await Hive.box('data').clear();
  }
}
