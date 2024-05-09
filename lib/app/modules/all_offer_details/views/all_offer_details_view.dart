import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offer_details/controllers/all_offer_details_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_button.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class AllOfferDetailsView extends GetView {
  final allOfferDetailsController = Get.put(AllOfferDetailsController());
  final arguments = Get.arguments as Map<String, dynamic>;
  AllOfferDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userType = box.read('user_type');
    final data = arguments['data'] ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              userType == 'guest'
                  ? MyAppBar(
                      backButton: true,
                      title: 'PinkAd',
                      onMenuTap: () {
                        print('object');
                      },
                      onProfileTap: () {
                        print('object');
                        Get.to(ProfileView());
                      },
                    )
                  : UserAppBar(
                      showBanner: true,
                      backButton: true,
                      title: 'All Shops',
                      onMenuTap: () {
                        print('object');
                      },
                      onProfileTap: () {
                        print('object');
                        Get.to(ProfileView());
                      },
                      profileIconVisibility: true,
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      data['title'],
                      style: CustomTextView.getStyle(
                        context,
                        fontSize: 20.sp,
                        colorLight: Colors.black,
                        fontFamily: Utils.poppinsBold,
                      ),
                      cursorColor: Colors.blue, // Customize cursor color if needed
                      toolbarOptions: ToolbarOptions(
                        // Customize toolbar options
                        copy: true,
                        selectAll: true,
                        cut: false,
                        paste: false,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SelectableText(
                      data['shop']['name'] ?? '',
                      style: CustomTextView.getStyle(
                        context,
                        fontSize: 15.sp,
                        colorLight: textColor,
                      ),
                      cursorColor: Colors.blue,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        selectAll: true,
                        cut: false,
                        paste: false,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Seller\'s contacts',
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: Utils.poppinsSemiBold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              String? facebookUrl = data['shop']?['seller']?['faecbook_page'];
                              if (facebookUrl == null) return;
                              try {
                                final String nativeUrl;
                                if (facebookUrl.toLowerCase().contains('facebook.com')) {
                                  if (!facebookUrl.startsWith('http')) {
                                    facebookUrl = 'https://' + facebookUrl;
                                  }
                                  nativeUrl = 'fb://facewebmodal/f?href=$facebookUrl';
                                } else {
                                  nativeUrl = 'fb://$facebookUrl';
                                }
                                await launchUrl(Uri.parse(nativeUrl));
                              } catch (e) {
                                // If the Facebook app is not installed, open the Facebook website
                                if (facebookUrl!.startsWith('http')) {
                                  await launchUrl(Uri.parse(facebookUrl));
                                }
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 30.h,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final imageUrl = ApiService.imageBaseUrl + data['banner'];
                              final text = "${data['title']} by ${data['shop']['name']} - ${data['description']}";

                              // Assuming the phone number is stored in data['shop']['seller']['whatsapp']
                              final phone = data['shop']?['seller']?['whatsapp'];

                              // Construct the message
                              final message = Uri.encodeFull('$text\nSee image here: $imageUrl');

                              // Construct the WhatsApp URL
                              if (phone != null) {
                                await launchUrl(
                                  Uri.parse('whatsapp://send?phone=$phone&text=$message'),
                                );
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 30.h,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              String? instaUrl = data['shop']?['seller']?['insta_page'];
                              print(instaUrl);
                              if (instaUrl == null) return;
                              try {
                                final String nativeUrl;
                                if (instaUrl.toLowerCase().contains('instagram.com')) {
                                  if (!instaUrl.startsWith('http')) {
                                    instaUrl = 'https://' + instaUrl;
                                  }
                                  final uri = Uri.parse(instaUrl);
                                  // Invalid URL
                                  if (uri.pathSegments.isEmpty) return;
                                  print(uri.pathSegments);
                                  nativeUrl = 'instagram://user?username=${uri.pathSegments.first}';
                                } else {
                                  nativeUrl = 'instagram://$instaUrl';
                                }
                                await launchUrl(Uri.parse(nativeUrl));
                              } catch (e) {
                                if (instaUrl!.startsWith('http')) {
                                  await launchUrl(Uri.parse(instaUrl));
                                }
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                size: 30.h,
                                color: Color(0xFFE4405D),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              try {
                                final imageUrl = ApiService.imageBaseUrl + data['banner'];
                                final text = "${data['title']} by ${data['shop']['name']} - ${data['description']}";
                                final whatsappNumber = data['shop']?['seller']?['whatsapp'];
                                await shareImageAndText(imageUrl, text, whatsappNumber);
                              } catch (e) {
                                print('Failed to share due to: $e');
                              }
                            },

                            icon: Center(
                              child: Icon(
                                Icons.share,
                                size: 25.h,
                              ),
                            ),
                            // FaIcon(
                            //   FontAwesomeIcons.shareFromSquare,
                            //   size: 30.h,
                            //   // color: Color(0xFFE4405D),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: containerGray,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Save Image',
                                    style: CustomTextView.getStyle(
                                      Get.context!,
                                      colorLight: secondary,
                                      fontSize: 18.sp,
                                      fontFamily: Utils.poppinsSemiBold,
                                    ),
                                  ),
                                  content: Text(
                                    'Do you want to save this image to your gallery?',
                                    style: CustomTextView.getStyle(
                                      Get.context!,
                                      colorLight: secondary,
                                      fontSize: 15.sp,
                                      fontFamily: Utils.poppinsLight,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Container(
                                      height: 0.05.sh,
                                      width: 0.3.sw,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: CustomTextView.getStyle(
                                              Get.context!,
                                              colorLight: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: Utils.poppinsSemiBold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 0.05.sh,
                                      width: 0.3.sw,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          child: Text(
                                            'Save',
                                            style: CustomTextView.getStyle(
                                              Get.context!,
                                              colorLight: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: Utils.poppinsSemiBold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog first
                                            _saveImage(ApiService.imageBaseUrl + data['banner'], context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.network(
                              ApiService.imageBaseUrl + data['banner'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Description\n', // Adding a newline character for separation
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 16.sp,
                                    fontFamily: Utils.poppinsSemiBold,
                                  ),
                                ),
                                TextSpan(
                                  text: data['description'] ?? '',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GlobalButton(
                title: 'Go To Seller Profile',
                onPressed: () {
                  var sellerId = data['shop']['seller']['id'];
                  Get.toNamed(
                    Routes.SPECIFIC_SELLER,
                    arguments: {
                      'seller_id': sellerId,
                      'shopName': data['shop']['name'],
                      'description': data['description'] ?? '',
                      'title': data['title'] ?? '',
                      'facebookUrl': data['shop']['seller']['facebook_page'],
                      'whatsappNumber': data['shop']['seller']['whatsapp'],
                      'instaUrl': data['shop']['seller']['insta_page'],
                      'sellerUrl': data['shop']['seller']['seller_link'],
                    },
                  );
                },
                textColor: Colors.white,
                buttonColor: secondary,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage(String imageUrl, BuildContext context) async {
    bool hasPermission = await _requestPermission(Permission.storage);
    if (!hasPermission) {
      showSnackBarError('Permission denied', 'Unable to save image.');
      return;
    }

    // Run GallerySaver and await its completion before showing the Snackbar
    bool? success = await GallerySaver.saveImage(imageUrl, albumName: 'Downloaded Images');
    if (success == true) {
      showSnackBarSuccess('Great', 'Image Downloaded Successfully!');
    } else {
      showSnackBarError('Error', 'Failed to Download Image');
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> shareImageAndText(String imageUrl, String text, String? whatsappNumber) async {
    final uri = Uri.parse(imageUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/flutter_temp_image.jpg');
      file.writeAsBytesSync(response.bodyBytes);

      String additionalInfo = '';
      if (whatsappNumber != null && whatsappNumber.isNotEmpty) {
        additionalInfo = '\n\nContact seller\'s whatsApp: $whatsappNumber';
      }

      final message = '$text$additionalInfo'; // Customize your message here
      Share.shareFiles([file.path], text: message);
    } else {
      throw Exception('Failed to download image');
    }
  }
}
