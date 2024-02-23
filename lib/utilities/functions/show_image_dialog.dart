import 'package:image_picker/image_picker.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/functions/show_custom_dialog.dart';

Future<XFile?> showImageDialog() async {
  return showCustomDialog(
    message: "PinkAd doesn't allow sellers to post any kind of female pictures, adult content, sexual content and any prohibited products",
    confirmText: 'Select Image',
    confirmCallback: () => loadingWrapper<XFile?>(() async {
      // final permissionStatus = await Permission.photos.request();
      // if (!permissionStatus.isGranted) {
      //   print('Permission denied');
      //   return null;
      // }
      return ImagePicker().pickImage(source: ImageSource.gallery);
    }),
  );
}
