// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import '../../../utils/local_storage.dart';
import 'package:pawlly/utils/library.dart';

class SignInController extends GetxController {
  RxBool isNavigateToDashboard = false.obs;

  RxBool isRememberMe = true.obs;
  RxBool isLoading = false.obs;
  RxString userName = "".obs;

  TextEditingController emailCont =
      TextEditingController(text: Constants.DEFAULT_EMAIL);
  TextEditingController passwordCont =
      TextEditingController(text: Constants.DEFAULT_PASS);

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  RxBool hasEmailFocus = false.obs;
  RxBool hasPasswordFocus = false.obs;

  void toggleSwitch() {
    isRememberMe.value = !isRememberMe.value;
  }

  @override
  void onInit() {
    if (Get.arguments is bool) {
      isNavigateToDashboard(Get.arguments == true);
    }
    final userIsRemeberMe =
        getValueFromLocal(SharedPreferenceConst.IS_REMEMBER_ME);
    final userNameFromLocal =
        getValueFromLocal(SharedPreferenceConst.USER_NAME);
    if (userNameFromLocal is String) {
      userName(userNameFromLocal);
    }
    if (userIsRemeberMe == true) {
      final userEmail = getValueFromLocal(SharedPreferenceConst.USER_EMAIL);
      if (userEmail is String) {
        emailCont.text = userEmail;
      }
      final userPASSWORD =
          getValueFromLocal(SharedPreferenceConst.USER_PASSWORD);
      if (userPASSWORD is String) {
        passwordCont.text = userPASSWORD;
      }
    }
    super.onInit();
  }

  Future<void> saveForm() async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      'email': emailCont.text.trim(),
      'password': passwordCont.text.trim(),
      UserKeys.userType: LoginTypeConst.LOGIN_TYPE_USER,
    };

    await AuthServiceApis.loginUser(request: req).then((value) async {
      handleLoginResponse(loginResponse: value);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  googleSignIn() async {
    isLoading(true);
    await GoogleSignInAuthService.signInWithGoogle().then((value) async {
      Map request = {
        UserKeys.contactNumber: value.mobile,
        UserKeys.email: value.email,
        UserKeys.firstName: value.firstName,
        UserKeys.lastName: value.lastName,
        UserKeys.userType: LoginTypeConst.LOGIN_TYPE_USER,
        UserKeys.username: value.userName,
        UserKeys.profileImage: value.profileImage,
        UserKeys.loginType: LoginTypeConst.LOGIN_TYPE_GOOGLE,
      };
      log('signInWithGoogle REQUEST: $request');

      /// Social Login Api
      await AuthServiceApis.loginUser(request: request, isSocialLogin: true)
          .then((value) async {
        handleLoginResponse(loginResponse: value, isSocialLogin: true);
      }).catchError((e) {
        isLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  appleSignIn() async {
    isLoading(true);
    await GoogleSignInAuthService.signInWithApple().then((value) async {
      Map request = {
        UserKeys.contactNumber: value.mobile,
        UserKeys.email: value.email,
        UserKeys.firstName: value.firstName,
        UserKeys.lastName: value.lastName,
        UserKeys.userType: LoginTypeConst.LOGIN_TYPE_USER,
        UserKeys.username: value.userName,
        UserKeys.profileImage: value.profileImage,
        UserKeys.loginType: LoginTypeConst.LOGIN_TYPE_APPLE,
      };
      log('signInWithGoogle REQUEST: $request');

      /// Social Login Api
      await AuthServiceApis.loginUser(request: request, isSocialLogin: true)
          .then((value) async {
        handleLoginResponse(loginResponse: value, isSocialLogin: true);
      }).catchError((e) {
        isLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  void handleLoginResponse(
      {required LoginResponse loginResponse, bool isSocialLogin = false}) {
    if (loginResponse.userData.userRole
        .contains(LoginTypeConst.LOGIN_TYPE_USER)) {
      loginUserData(loginResponse.userData);
      loginUserData.value.isSocialLogin = isSocialLogin;
      setValueToLocal(SharedPreferenceConst.USER_DATA, loginUserData.toJson());
      setValueToLocal(SharedPreferenceConst.USER_PASSWORD,
          isSocialLogin ? "" : passwordCont.text.trim());
      isLoggedIn(true);
      setValueToLocal(SharedPreferenceConst.IS_LOGGED_IN, true);
      setValueToLocal(SharedPreferenceConst.IS_REMEMBER_ME, isRememberMe.value);

      isLoading(false);

      PushNotificationService().registerFCMAndTopics();
      AuthServiceApis.getAppConfigurations(forceConfigSync: true);

      if (isNavigateToDashboard.value) {
        Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
          Get.put(HomeScreenController());
        }));
      } else {
        try {
          DashboardController dashboardController = Get.find();
          dashboardController.reloadBottomTabs();
        } catch (e) {
          log('dashboardController Get.find E: $e');
        }
        try {
          HomeScreenController homeScreenController = Get.find();
          homeScreenController.init();
        } catch (e) {
          log('homeScreenController Get.find E: $e');
        }
        try {
          BookingsController bookingsController = Get.find();
          bookingsController.getBookingList();
        } catch (e) {
          log('appointmentsController Get.find E: $e');
        }
        try {
          myPetsScreenController.init();
        } catch (e) {
          log('myPetsScreenController.init E: $e');
        }
        Get.back(result: true);
      }
    } else {
      isLoading(false);
      toast(locale.value.sorryUserCannotSignin);
    }
  }
}
