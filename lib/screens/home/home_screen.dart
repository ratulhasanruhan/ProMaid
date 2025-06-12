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
                                  32.height,
                                  GreetingsComponent(),
                                  16.height,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // TextField with icon and placeholder
                                                        Flexible(
                                                          flex: 9,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: TextField(
                                                              //controller: shopController.pCont.searchCont,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            14),
                                                                prefixIcon:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              12,
                                                                          right:
                                                                              8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  width: 28,
                                                                  height: 28,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .grey, // Replace with your icon color
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            8,
                                                                        height:
                                                                            8,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                hintText:
                                                                    "ProMaid Cleaning",
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 2,
                                                          child: InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              height: 48,
                                                              width: 48,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16)),
                                                              child: const Icon(
                                                                  Icons.search,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
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
