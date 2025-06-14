import 'package:get/get.dart';
import '../../dashboard/dashboard_res_model.dart';
import 'package:pawlly/utils/library.dart';

class EventController extends GetxController {
  Rx<Future<List<PetEvent>>> getEvents = Future(() => <PetEvent>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxBool isShowNearByEvents = false.obs;
  RxList<PetEvent> eventList = RxList();
  RxInt page = 1.obs;
  TextEditingController latitudeCont = TextEditingController();
  TextEditingController longitudeCont = TextEditingController();

  @override
  void onInit() {
    init(showloader: false);
    super.onInit();
  }

  Future<void> init({bool showloader = true}) async {
    if (showloader) isLoading(true);
    await getEvents(
      HomeServiceApis.getEvent(
        page: page.value,
        events: eventList,
        latitude: latitudeCont.text,
        longitude: longitudeCont.text,
        showNearby: isShowNearByEvents.value,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ).whenComplete(
        () => isLoading(false),
      ),
    );
  }

  void handleCurrentLocationClick() async {
    isLoading(true);
    await getUserLocation().then((value) {
      latitudeCont.text = getDoubleAsync(LATITUDE).toString();
      longitudeCont.text = getDoubleAsync(LONGITUDE).toString();
      init();
    }).catchError((e) {
      log(e);
      toast(e.toString());
    });

    isLoading(false);
  }
}
