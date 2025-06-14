import 'package:get/get.dart';
import '../../dashboard/dashboard_res_model.dart';
import 'package:pawlly/utils/library.dart';

class WalkingServiceController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showBookBtn = false.obs;

  RxBool hasErrorFetchingWalker = false.obs;
  RxString errorMessageWalker = "".obs;
  BookWalkingReq bookWalkingReq = BookWalkingReq();
  Rx<DurationData> selectedDuration = DurationData().obs;

  Rx<EmployeeModel> selectedWalker = EmployeeModel(profileImage: "".obs).obs;
  RxList<EmployeeModel> walkerList = RxList();
  Rx<Future<List<DurationData>>> duration = Future(() => <DurationData>[]).obs;
  TextEditingController dateCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();
  TextEditingController additionalInfoCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController walkerCont = TextEditingController();
  Rx<BookingDataModel> bookingFormData = BookingDataModel(
          service: SystemService(),
          payment: PaymentDetails(),
          training: Training())
      .obs;
  RxBool isUpdateForm = false.obs;
  RxBool isShowNearBy = false.obs;
  RxList<DurationData> durationList = RxList();

  String userlatitude = "";
  String userlongitude = "";

  void toggleSwitch() {
    isShowNearBy.value = !isShowNearBy.value;
    handleCurrentLocationClick();
    getWalker();
  }

  @override
  void onInit() {
    bookWalkingReq.systemServiceId = currentSelectedService.value.id;
    if (myPetsScreenController.myPets.length == 1) {
      /// Pet Selection When there is only single pet
      bookWalkingReq.petId = myPetsScreenController.myPets.first.id;
    }
    if (Get.arguments is BookingDataModel) {
      try {
        isUpdateForm(true);
        bookingFormData(Get.arguments as BookingDataModel);
        additionalInfoCont.text = bookingFormData.value.note;
        addressCont.text = bookingFormData.value.address;
        log('BOOKINGFORMDATA.VALUE.DURATION: ${bookingFormData.value.duration}');
        duration(PetServiceFormApis.getDuration(
          serviceType: ServicesKeyConst.walking,
          employeeId: bookingFormData.value.employeeId,
          isBooking: 1,
        )).then((value) {
          selectedDuration(value.firstWhere(
              (p0) => p0.duration == bookingFormData.value.duration,
              orElse: () => DurationData()));
          if (selectedDuration.value.id > 0 &&
              selectedDuration.value.price > 0) {
            currentSelectedService.value.serviceAmount =
                selectedDuration.value.price.toDouble();
            bookWalkingReq.price = selectedDuration.value.price.toDouble();
            showBookBtn(true);
          }
        });
        getWalker();
        selectedPet(myPetsScreenController.myPets.firstWhere(
            (element) =>
                element.name.toLowerCase() ==
                bookingFormData.value.petName.toLowerCase(),
            orElse: () => PetData()));
        bookWalkingReq.petId = selectedPet.value.id;
      } catch (e) {
        log('walking book again E: $e');
      }
    } else {
      getDurationList(isBooking: 1);
      getWalker();
      addressCont.text = loginUserData.value.address;
    }

    try {
      log('BookingDetailsController called init');
      BookingDetailsController bDetailCont = Get.find();
      currentSelectedService(bDetailCont.bookingDetail.value.service);
      dateCont.text = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat
          .formatDateDDMMYY();
      timeCont.text = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat
          .formatTimeHHmmAMPM();
      bookWalkingReq.date = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddFormat
          .formatDateYYYYmmdd();
      bookWalkingReq.time = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat
          .formatTimeHHmm24hour()
          .toString();
    } catch (e) {
      log('walking Reschedule init E: $e');
    }

    super.onInit();
  }

  void clearWalkerSelection() {
    walkerCont.clear();
    selectedWalker(EmployeeModel(profileImage: "".obs));
    getDurationList(isBooking: 1);
    showBookBtn(false);
  }

  ///Get Duration List
  void getDurationList({int? employeeId, int? isBooking}) {
    isLoading(true);

    duration(PetServiceFormApis.getDuration(
      serviceType: ServicesKeyConst.walking,
      employeeId: employeeId,
      isBooking: isBooking,
    )).then((value) {
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      log('walkingDurationListController Error: $e');
    }).whenComplete(() => isLoading(false));
  }

  //Get Walker List
  getWalker({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getEmployee(
      role: EmployeeKeyConst.walking,
      latitude: userlatitude,
      longitude: userlongitude,
      showNearby: isShowNearBy.value,
      search: searchtext,
    ).then((value) {
      isLoading(false);
      walkerList(value.data);
      hasErrorFetchingWalker(false);
      if (isUpdateForm.value) {
        selectedWalker(walkerList.firstWhere(
            (p0) => p0.id == bookingFormData.value.employeeId,
            orElse: () => EmployeeModel(profileImage: "".obs)));
        walkerCont.text = selectedWalker.value.fullName;
        bookWalkingReq.employeeId = selectedWalker.value.id;
        isUpdateForm(false);
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingWalker(true);
      errorMessageWalker(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  handleBookNowClick({bool isFromReschedule = false}) async {
    if (selectedWalker.value.id.isNegative) {
      await showConfirmDialogCustom(
        getContext,
        primaryColor: primaryColor,
        negativeText: locale.value.no,
        positiveText: locale.value.yes,
        onAccept: (_) {
          handleCurrentLocationClick(isFromBookNowClick: true);
        },
        dialogType: DialogType.ACCEPT,
        title: locale.value.doYouWantTo,
      );
    }
    bookWalkingReq.address = addressCont.text.trim();
    bookWalkingReq.additionalInfo = additionalInfoCont.text.trim();
    bookWalkingReq.totalAmount = totalAmount;
    bookingSuccessDate("${bookWalkingReq.date} ${bookWalkingReq.time}".trim());
    log('BOOKBOARDINGREQ.TOJSON(): ${bookWalkingReq.toJson()}');

    if (isFromReschedule) {
      try {
        BookingDetailsController bDetailCont = Get.find();
        Map<String, dynamic> req = {
          'id': bDetailCont.bookingDetail.value.id,
          'date_time':
              "${bookWalkingReq.date.trim()} ${bookWalkingReq.time.trim()}",
        };
        isLoading(true);
        BookingServiceApis.updateBooking(request: req).then((value) {
          bDetailCont.init(showLoader: false);
          Get.back();
        }).catchError((e) {
          toast(e.toString(), print: true);
        }).whenComplete(() => isLoading(false));
      } catch (e) {
        log('Training Reschedule booking save E: $e');
      }
    } else {
      paymentController =
          PaymentController(bookingService: currentSelectedService.value);
      Get.to(() => const PaymentScreen(), binding: BindingsBuilder(() {
        getAppConfigurations();
      }));
    }
  }

  void handleCurrentLocationClick({bool isFromBookNowClick = false}) async {
    isLoading(true);
    await getUserLocation().then((value) {
      userlatitude = getDoubleAsync(LATITUDE).toString();
      userlongitude = getDoubleAsync(LONGITUDE).toString();
      if (isFromBookNowClick) {
        bookWalkingReq.latitude = userlatitude;
        bookWalkingReq.longitude = userlongitude;
      } else {
        getWalker();
      }
    }).catchError((e) {
      log(e);
      toast(e.toString());
    });

    isLoading(false);
  }
}
