import 'package:get/get.dart';
import 'model/category_model.dart';
import 'package:pawlly/utils/library.dart';

class ShopDashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isRefresh = false.obs;

  Rx<Future<DashboardShopRes>> getDashboardDetail =
      Future(() => DashboardShopRes(shopDashData: DashboardShopModel())).obs;
  Rx<DashboardShopRes> shopdashboardData =
      DashboardShopRes(shopDashData: DashboardShopModel()).obs;

  final ProductListController pCont = ProductListController();

  @override
  void onInit() {
    ///Search
    pCont.initializeSearchStream();

    /// To Set Cart Count to [cartCount] global variable
    if (isLoggedIn.value) {
      CartController cartController = CartController();
      cartController.init();
    }
    super.onInit();
  }

  @override
  void onReady() {
    getShopDashboardDetail(isFromSwipRefresh: true);
    super.onReady();
  }

  getShopDashboardDetail({bool isFromSwipRefresh = false}) {
    if (!isFromSwipRefresh) {
      isLoading(true);
    }
    getDashboardDetail(DashboardShopApi.getShopDashboard()).then((value) {
      shopdashboardData(value);
    }).whenComplete(() => isLoading(false));
  }

  @override
  void onClose() {
    ///Search
    pCont.disposeSearchStream();
    super.onClose();
  }
}
