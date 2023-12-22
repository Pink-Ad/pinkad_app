import 'package:get/get.dart';

import '../modules/OTP/bindings/otp_binding.dart';
import '../modules/OTP/views/otp_view.dart';
import '../modules/active_package_details/bindings/active_package_details_binding.dart';
import '../modules/active_package_details/views/active_package_details_view.dart';
import '../modules/active_packages/bindings/active_packages_binding.dart';
import '../modules/active_packages/views/active_packages_view.dart';
import '../modules/add_shop/bindings/add_shop_binding.dart';
import '../modules/add_shop/views/add_shop_view.dart';
import '../modules/all_offer_details/bindings/all_offer_details_binding.dart';
import '../modules/all_offer_details/views/all_offer_details_view.dart';
import '../modules/all_offers/bindings/all_offers_binding.dart';
import '../modules/all_offers/views/all_offers_view.dart';
import '../modules/all_shops/bindings/all_shops_binding.dart';
import '../modules/all_shops/views/all_shops_view.dart';
import '../modules/chat_inbox/bindings/chat_inbox_binding.dart';
import '../modules/chat_inbox/views/chat_inbox_view.dart';
import '../modules/featured_offer/bindings/featured_offer_binding.dart';
import '../modules/featured_offer/views/featured_offer_view.dart';
import '../modules/featured_seller/bindings/featured_seller_binding.dart';
import '../modules/featured_seller/views/featured_seller_view.dart';
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/bottom_nav_bar.dart';
import '../modules/home/views/home_view.dart';
import '../modules/package_details/bindings/package_details_binding.dart';
import '../modules/package_details/views/package_details_view.dart';
import '../modules/premier_features/bindings/premier_features_binding.dart';
import '../modules/premier_features/views/premier_features_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/seller_login/bindings/login_binding.dart';
import '../modules/seller_login/views/login_view.dart';
import '../modules/shop_details/bindings/shop_details_binding.dart';
import '../modules/shop_details/views/shop_details_view.dart';
import '../modules/shops_insight/bindings/shops_insight_binding.dart';
import '../modules/shops_insight/views/shops_insight_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms/bindings/terms_binding.dart';
import '../modules/terms/views/terms_view.dart';
import '../modules/tutorial/bindings/tutorial_binding.dart';
import '../modules/tutorial/views/tutorial_view.dart';
import '../modules/upload_offer/bindings/upload_offer_binding.dart';
import '../modules/upload_offer/views/upload_offer_view.dart';
import '../modules/user_dashboard/bindings/user_dashboard_binding.dart';
import '../modules/user_dashboard/views/user_bottom_nav_bar.dart';
import '../modules/user_dashboard/views/user_dashboard_view.dart';
import '../modules/user_login/bindings/user_login_binding.dart';
import '../modules/user_login/views/user_login_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),

    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.USER_LOGIN,
      page: () => UserLoginView(),
      binding: UserLoginBinding(),
    ),
    GetPage(
      name: _Paths.BottomNavBar,
      page: () => BottomNavBar(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ALL_OFFERS,
      page: () => const AllOffersView(),
      binding: AllOffersBinding(),
    ),
    GetPage(
      name: _Paths.ALL_SHOPS,
      page: () => const AllShopsView(),
      binding: AllShopsBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_DETAILS,
      page: () => ShopDetailsView(),
      binding: ShopDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ALL_OFFER_DETAILS,
      page: () => AllOfferDetailsView(),
      binding: AllOfferDetailsBinding(),
    ),
    GetPage(
      name: _Paths.USER_DASHBOARD,
      page: () => UserDashboardView(),
      binding: UserDashboardBinding(),
    ),

    // user pages
    GetPage(
      name: _Paths.UserBottomNavBar,
      page: () => const UserBottomNavBar(),
      binding: UserDashboardBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SHOP,
      page: () => const AddShopView(),
      binding: AddShopBinding(),
    ),
    GetPage(
      name: _Paths.SHOPS_INSIGHT,
      page: () => ShopsInsightView(),
      binding: ShopsInsightBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_OFFER,
      page: () => UploadOfferView(),
      binding: UploadOfferBinding(),
    ),
    GetPage(
      name: _Paths.PREMIER_FEATURES,
      page: () => PremierFeaturesView(),
      binding: PremierFeaturesBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_PACKAGES,
      page: () => ActivePackagesView(),
      binding: ActivePackagesBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_PACKAGE_DETAILS,
      page: () => ActivePackageDetailsView(),
      binding: ActivePackageDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_DETAILS,
      page: () => PackageDetailsView(),
      binding: PackageDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_INBOX,
      page: () => ChatInboxView(),
      binding: ChatInboxBinding(),
    ),
    GetPage(
      name: _Paths.TERMS,
      page: () => const TermsView(),
      binding: TermsBinding(),
    ),
    GetPage(
      name: _Paths.TUTORIAL,
      page: () => TutorialView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.FEATURED_SELLER,
      page: () => FeaturedSellerView(),
      binding: FeaturedSellerBinding(),
    ),
    GetPage(
      name: _Paths.FEATURED_OFFER,
      page: () => FeaturedOfferView(),
      binding: FeaturedOfferBinding(),
    ),
  ];
}
