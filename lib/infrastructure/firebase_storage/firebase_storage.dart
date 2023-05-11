import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageUrl(String path) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(path);
  String url = await ref.getDownloadURL();
  return url;
}
