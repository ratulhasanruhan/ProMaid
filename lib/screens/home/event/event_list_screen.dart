import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class EventListScreen extends StatelessWidget {
  EventListScreen({super.key});

  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.upcomingEvents,
      actions: [
        Obx(
          () => IconButton(
            icon: Assets.iconsIcMyAddress.iconImage(
                size: 26,
                color: eventController.isShowNearByEvents.value
                    ? secondaryColor
                    : darkGray),
            onPressed: () {
              showConfirmDialogCustom(
                getContext,
                primaryColor: primaryColor,
                negativeText: locale.value.cancel,
                positiveText: locale.value.yes,
                onAccept: (_) {
                  eventController.isShowNearByEvents.value =
                      !eventController.isShowNearByEvents.value;

                  if (eventController.isShowNearByEvents.value) {
                    eventController.handleCurrentLocationClick();
                  } else {
                    /// Call event-list api
                    eventController.init();
                  }
                },
                dialogType: DialogType.ACCEPT,
                title: eventController.isShowNearByEvents.value
                    ? locale.value.doYouWantTurnOffNearByEvents
                    : locale.value.doYouWantSeeYourNearByEvents,
              );
            },
          ).paddingOnly(right: 8),
        ),
      ],
      isLoading: eventController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
          future: eventController.getEvents.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                eventController.page(1);
                eventController.init();
              },
            ).paddingSymmetric(horizontal: 16);
          },
          loadingWidget: const EventListScreenShimmer(),
          onSuccess: (events) {
            return Column(
              children: [
                AnimatedListView(
                  shrinkWrap: true,
                  itemCount: events.length,
                  listAnimationType: ListAnimationType.FadeIn,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  emptyWidget: NoDataWidget(
                    title: locale.value.noEventsFound,
                    imageWidget: const EmptyStateWidget(),
                    subTitle: locale.value.thereAreNoEvents,
                    retryText: locale.value.reload,
                    onRetry: () {
                      eventController.page(1);
                      eventController.init();
                    },
                  ).paddingSymmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return EventItemComponent(
                      event: events[index],
                      youMayAlsoLikeEvent: events,
                    ).paddingOnly(top: 8, bottom: 16);
                  },
                  onNextPage: () async {
                    if (!eventController.isLastPage.value) {
                      eventController.page(eventController.page.value + 1);
                      eventController.init();
                    }
                  },
                  onSwipeRefresh: () async {
                    eventController.page(1);
                    return await eventController.init(showloader: false);
                  },
                ).expand(),
              ],
            );
          },
        ),
      ),
    );
  }
}
