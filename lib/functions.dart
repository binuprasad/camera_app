

import 'package:camera_app2/model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<ImageModel>> imagenotifier = ValueNotifier([]);
addimage(ImageModel value) async {
  final imageDb = await Hive.openBox<ImageModel>('_imagedb');
  await imageDb.add(value);

  imagenotifier.value.add(value);
  imagenotifier.notifyListeners();
}
getAllimages()async{
   final imageDb = await Hive.openBox<ImageModel>('_imagedb');
   imagenotifier.value.clear();
   imagenotifier.value.addAll(imageDb.values);
   
  
   imagenotifier.notifyListeners();
}