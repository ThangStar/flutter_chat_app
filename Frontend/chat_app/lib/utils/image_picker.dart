import 'package:image_picker/image_picker.dart';

Future<XFile?> pickerImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<List<XFile>?> pickerMultiImage() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = await picker.pickMultiImage();
  return images;
}

class MyCameraDelegate {}
