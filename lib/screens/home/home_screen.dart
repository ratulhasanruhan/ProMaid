import 'package:get/get.dart';
import 'package:pawlly/screens/dashboard/dashboard_res_model.dart';
import 'package:pawlly/utils/library.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canPop =
            homeScreenController.navKey.currentState?.canPop() ?? false;

        if (canPop) {
          homeScreenController.navKey.currentState?.pop();
          return false; // prevent system back
        }

        return true; // allow system back (e.g., exit app or go to previous main page)
      },
      child: Navigator(
        key: homeScreenController.navKey,
        onGenerateInitialRoutes: (_, c) => [
          MaterialPageRoute(
              builder: (_) => AppScaffold(
                    hideAppBar: true,
                    body: RefreshIndicator(
                      onRefresh: () async {
                        return await homeScreenController.getDashboardDetail(
                            isFromSwipRefresh: true);
                      },
                      child: Obx(
                        () => SnapHelperWidget(
                          future: homeScreenController
                              .getDashboardDetailFuture.value,
                          initialData: homeScreenController
                                  .dashboardData.value.systemService.isEmpty
                              ? null
                              : DashboardRes(
                                  data:
                                      homeScreenController.dashboardData.value),
                          errorBuilder: (error) {
                            return NoDataWidget(
                              title: error,
                              retryText: locale.value.reload,
                              imageWidget: const ErrorStateWidget(),
                              onRetry: () {
                                homeScreenController.init();
                              },
                            ).paddingSymmetric(horizontal: 16);
                          },
                          loadingWidget:
                              const HomeScreenShimmer(showGreeting: true),
                          onSuccess: (dashboardData) {
                            return SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 16),
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Obx(
                                    () => homeScreenController.isLoading.value
                                        ? const HomeScreenShimmer()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.032,
                                                    ),
                                                    child:
                                                        const SlidersComponent(),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8
                                                    ),
                                                    child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors.grey.shade200,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                          vertical: 4,
                                                        ),
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'Search for ProMaid Cleaning Services',
                                                            prefixIcon:
                                                            const Icon(
                                                              Icons.search,
                                                              color: Color(0xFF0F165C),
                                                              size: 28,
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(18),
                                                              borderSide: BorderSide.none,
                                                            ),
                                                            contentPadding: const EdgeInsets.symmetric(
                                                              horizontal: 16,),
                                                            isDense: true,
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ).paddingSymmetric(
                                                            horizontal: 16, vertical: 8
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ChooseServiceComponents(),
                                              UpcomingAppointmentComponents(),
                                              ChoosePetSitterComponents(),
                                              YourEventsComponents(
                                                  events: homeScreenController
                                                      .dashboardData
                                                      .value
                                                      .event),
                                              BlogHomeComponent(),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
