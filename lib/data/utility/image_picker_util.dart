import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static Future<XFile?> selectImage() async {
    ImagePicker imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }
}
