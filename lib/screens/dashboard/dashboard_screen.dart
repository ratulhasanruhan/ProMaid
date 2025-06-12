import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:pawlly/utils/library.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final List<String> tabNames = [
    'Home',
    'Bookings',
    'Shop',
    'Profile',
  ];

  final List<IconData> tabIcons = [
    LucideIcons.house,
    LucideIcons.book,
    LucideIcons.ticket,
    LucideIcons.user,
  ];

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: locale.value.pressBackAgainToExitApp,
      child: AppScaffold(
        hideAppBar: true,
        body: Obx(() => IndexedStack(
              index: dashboardController.currentIndex.value,
              children: dashboardController.screen,
            )),
        bottomNavBar: Obx(
          () => MotionTabBar(
            initialSelectedTab: 'Home',
            tabBarColor: Color(0xFF0B0F59),
            tabIconColor: Colors.white,
            tabSelectedColor: Colors.white,
            tabIconSelectedColor: Color(0xFFFD6B22),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            onTabItemSelected: (v) {
              if (!isLoggedIn.value && v == 1) {
                doIfLoggedIn(context, () {
                  dashboardController.currentIndex(v);
                });
              } else {
                dashboardController.currentIndex(v);
              }
              try {
                if (v == 0) {
                  HomeScreenController hCont = Get.find();
                  hCont.getDashboardDetail(isFromSwipRefresh: true);
                } else if (isLoggedIn.value && v == 1) {
                  BookingsController bCont = Get.find();
                  bCont.getBookingList(showloader: false);
                } else if (v == 2) {
                  ShopDashboardController sCont = Get.find();
                  sCont.pCont.searchCont.clear();
                  sCont.pCont.isSearchText(
                      sCont.pCont.searchCont.text.trim().isNotEmpty);
                  sCont.getShopDashboardDetail(isFromSwipRefresh: true);
                }
              } catch (e) {
                log('onItemSelected Err: $e');
              }
            },
            labels: tabNames,
            icons: tabIcons,
          ).visible(!updateUi.value),
        ),
      ),
    );
  }
}
