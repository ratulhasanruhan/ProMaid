import 'package:get/get.dart';
import '../dashboard/dashboard_res_model.dart';
import 'package:pawlly/utils/library.dart';

class ChooseService extends StatelessWidget {
  ChooseService({Key? key}) : super(key: key);
  final HomeScreenController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Hero(
        tag: "choose_service",
        child: Text(
          locale.value.chooseService,
          style: primaryTextStyle(size: 18, decoration: TextDecoration.none),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                dashboardController.dashboardData.value.systemService.length,
                (index) {
                  SystemService service = dashboardController
                      .dashboardData.value.systemService[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToService(dashboardController
                          .dashboardData.value.systemService[index]);
                    },
                    child: ServiceCard(
                      service: service,
                      width: Get.width / 2 - 24,
                      height: Get.width / 2 - 16,
                      showSubTexts: true,
                    ),
                  );
                },
              ),
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }
}
