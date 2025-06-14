import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class Body extends StatelessWidget {
  final Widget child;
  final RxBool isLoading;

  const Body({Key? key, required this.isLoading, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Obx(() => const LoaderWidget().center().visible(isLoading.value)),
        ],
      ),
    );
  }
}
