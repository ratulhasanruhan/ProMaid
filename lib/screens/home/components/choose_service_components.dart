import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class ChooseServiceComponents extends StatelessWidget {
  ChooseServiceComponents({super.key});

  final HomeScreenController homeScreenController = Get.find();

  final List<Color> cardColor = [
    Color(0xFF46CF08).withValues(alpha: 0.03),
    Color(0xFF888888),
    Color(0xFF0F165C).withValues(alpha: 0.03),
    Color(0xFFFFBC34),
    Color(0xFFD9D9D9),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          16.height,
          ViewAllLabel(
            label: locale.value.chooseService,
            onTap: () {
              Get.to(() => ChooseService(),
                  duration: const Duration(milliseconds: 800));
            },
            trailingText: locale.value.explore,
          ).paddingOnly(left: 16, right: 8),
          6.height,
          Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount:
                  homeScreenController.dashboardData.value.systemService.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    hideKeyboard(context);
                    navigateToService(homeScreenController
                        .dashboardData.value.systemService[index]);
                  },
                  borderRadius: radius(),
                  child: ServiceCard(
                    service: homeScreenController
                        .dashboardData.value.systemService[index],
                    color: cardColor[index % cardColor.length],
                  ),
                );
              },
            ),
          ),
        ],
      ).visible(
          homeScreenController.dashboardData.value.systemService.isNotEmpty),
    );
  }
}
