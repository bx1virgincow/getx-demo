import 'package:demo/core/constants/text_constants.dart';
import 'package:hive/hive.dart';

class HiveLocalDatabase {
  //box for storing data
  static final hiveBox = Hive.box(TextConstants.demoHiveBox);

  //create or add items
  static createNote(Map data) {
    hiveBox.add(data);
  }

  //get items
  static List getItems() {
    final data = hiveBox.keys.map((key) {
      final value = hiveBox.get(key);
      return {
        'key': key,
        'userId': value['userId'],
        'id': value['id'],
        'email': value['email'],
        'body': value['body'],
      };
    }).toList();

    return data.reversed.toList();
  }

  //get data for a particular item
  static Map getItem(int key) {
    return hiveBox.get(key);
  }

  //update item for a particular user or item
  static updateItem(int key, Map data) {
    return hiveBox.put(key, data);
  }

  //delete an item
  static deleteItem(int key) {
    return hiveBox.delete(key);
  }

  //delete all data or item
  static deleteAllItems(int key) {
    return hiveBox.deleteAll(hiveBox.keys);
  }
}
