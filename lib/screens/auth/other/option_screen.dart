import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class OptionScreen extends StatelessWidget {
  OptionScreen({Key? key}) : super(key: key);
  final OptionScreenController optionScreenController =
      Get.put(OptionScreenController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      isLoading: optionScreenController.isLoading,
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: context.primaryColor,
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Positioned(
                //   bottom: optionScreenController.bottomWidgetHeight - 4,
                //   child: Container(
                //     color: context.primaryColor,
                //     child: Image.asset(
                //       Assets.imagesOptionImage,
                //       width: Get.width,
                //       fit: BoxFit.fitWidth,
                //     ),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: optionScreenController.bottomWidgetHeight,
                  decoration: boxDecorationDefault(
                    color: context.cardColor,
                    borderRadius: BorderRadius.only(
                        topRight: radiusCircular(30),
                        topLeft: const Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        locale.value.pawlcomeToYourPetSHaven,
                        style: primaryTextStyle(size: 20),
                      ),
                      8.height,
                      Text(
                        locale.value.unlockAWorldOf,
                        style: secondaryTextStyle(size: 14),
                        textAlign: TextAlign.center,
                      ),
                      64.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppButton(
                            text: locale.value.signIn,
                            textStyle: appButtonTextStyleGray,
                            color: lightSecondaryColor,
                            onTap: () {
                              Get.to(
                                () => SignInScreen(),
                                arguments: true,
                                binding: BindingsBuilder(() {
                                  isDarkMode.value
                                      ? setStatusBarColor(scaffoldDarkColor,
                                          statusBarIconBrightness:
                                              Brightness.light,
                                          statusBarBrightness: Brightness.light)
                                      : setStatusBarColor(
                                          context.scaffoldBackgroundColor,
                                          statusBarIconBrightness:
                                              Brightness.dark,
                                          statusBarBrightness:
                                              Brightness.light);
                                }),
                              );
                            },
                          ).expand(),
                          32.width,
                          AppButton(
                            text: locale.value.explore,
                            textStyle: appButtonTextStyleWhite,
                            onTap: () {
                              optionScreenController.isLoading(true);
                              Get.offAll(
                                () => DashboardScreen(),
                                binding: BindingsBuilder(() {
                                  Get.put(HomeScreenController());
                                  isDarkMode.value
                                      ? setStatusBarColor(scaffoldDarkColor,
                                          statusBarIconBrightness:
                                              Brightness.light,
                                          statusBarBrightness: Brightness.light)
                                      : setStatusBarColor(
                                          context.scaffoldBackgroundColor,
                                          statusBarIconBrightness:
                                              Brightness.dark,
                                          statusBarBrightness:
                                              Brightness.light);
                                }),
                              );
                            },
                          ).expand(),
                        ],
                      ).paddingSymmetric(horizontal: 32),
                    ],
                  ),
                ),
                Positioned(
                  bottom: optionScreenController.bottomWidgetHeight - 80,
                  child: Image.asset(
                    Assets.imagesOptionImage,
                    width: Get.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
