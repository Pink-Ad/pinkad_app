import 'package:pink_ad/utilities/functions/show_custom_dialog.dart';

Future<bool?> showImageDialog() {
  return showCustomDialog(
    title: "Dialog Title",
    message: "Dialog Content",
    confirmText: "Pick Image",
  );
}
