import 'package:pink_ad/utilities/functions/show_custom_dialog.dart';

Future<bool?> showImageDialog() {
  return showCustomDialog(
    title: 'Dialog Title',
    message: "PinkAd doesn't allow sellers to post any kind of female pictures, adult content, sexual content and any prohibited products",
    confirmText: 'Pick Image',
  );
}
