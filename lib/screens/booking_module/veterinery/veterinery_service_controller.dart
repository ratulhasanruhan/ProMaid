import 'package:get/get.dart';

import '../../dashboard/dashboard_res_model.dart';
import '../../shop/model/category_model.dart';
import 'package:pawlly/utils/library.dart';

class VeterineryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showBookBtn = false.obs;
  RxBool refreshWidget = false.obs;
  RxList<PlatformFile> medicalReportfiles = RxList();
  BookVeterinaryReq bookVeterinaryReq = BookVeterinaryReq();

  RxInt page = 1.obs;
  RxBool isLastPage = false.obs;

  //Category
  Rx<ShopCategoryModel> selectedVeterinaryType = ShopCategoryModel().obs;
  RxList<ShopCategoryModel> categoryList = RxList();

  //Error Category
  RxBool hasErrorFetchingVeterinaryType = false.obs;
  RxString errorMessageVeterinaryType = "".obs;

  //Service
  Rx<ServiceModel> selectedService = ServiceModel().obs;
  RxList<ServiceModel> serviceList = RxList();

  //Error Service
  RxBool hasErrorFetchingService = false.obs;
  RxString errorMessageService = "".obs;

  //Vet
  Rx<EmployeeModel> selectedVet = EmployeeModel(profileImage: "".obs).obs;
  RxList<EmployeeModel> vetList = RxList();

  //Error Vet
  RxBool hasErrorFetchingVet = false.obs;
  RxString errorMessageVet = "".obs;
  RxBool isUpdateForm = false.obs;

  // List<int> additionalFacility = [];
  TextEditingController dateCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();
  TextEditingController veterinaryTypeCont = TextEditingController();
  TextEditingController serviceCont = TextEditingController();
  TextEditingController vetCont = TextEditingController();
  TextEditingController reasonCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  Rx<BookingDataModel> bookingFormData = BookingDataModel(
          service: SystemService(),
          payment: PaymentDetails(),
          training: Training())
      .obs;

  //Date and Time
  RxString bookingDate = "--:--".obs;
  RxString bookingTime = "--:--".obs;


  //HOme Options (New)
  var homeSelected = 'Small House'.obs;

  final List<String> homeOptions = [
    "Pro Villa Duplex House",
    "Small House",
    "Medium House",
    "Large House",
  ];


  @override
  void onInit() {
    bookVeterinaryReq.systemServiceId = currentSelectedService.value.id;
    if (myPetsScreenController.myPets.length == 1) {
      /// Pet Selection When there is only single pet
      bookVeterinaryReq.petId = myPetsScreenController.myPets.first.id;
    }
    if (Get.arguments is BookingDataModel) {
      try {
        isUpdateForm(true);
        log('bookingFormData.value.veterinaryReason ==> ${bookingFormData.value.veterinaryReason.toString()}');
        bookingFormData(Get.arguments as BookingDataModel);
        reasonCont.text = bookingFormData.value.veterinaryReason.toString();
        getCategory();
        selectedPet(myPetsScreenController.myPets.firstWhere(
            (element) =>
                element.name.toLowerCase() ==
                bookingFormData.value.petName.toLowerCase(),
            orElse: () => PetData()));
        bookVeterinaryReq.petId = selectedPet.value.id;
      } catch (e) {
        log('veterinery book again E: $e');
      }
    } else {
      getCategory();
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
      bookVeterinaryReq.date = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddFormat
          .formatDateYYYYmmdd();
      bookVeterinaryReq.time = bDetailCont
          .bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat
          .formatTimeHHmm24hour()
          .toString();
      bookingDate.value = bookVeterinaryReq.date;
      bookingTime.value = bookVeterinaryReq.time;
    } catch (e) {
      log('veterinery Reschedule init E: $e');
    }

    super.onInit();
  }

  void reloadWidget() {
    refreshWidget(true);
    refreshWidget(false);
  }

  //
  Future<void> handleFilesPickerClick() async {
    final pickedFiles = await pickFiles();
    Set<String> filePathsSet = medicalReportfiles
        .map((file) => file.name.trim().toLowerCase())
        .toSet();
    for (var i = 0; i < pickedFiles.length; i++) {
      if (!filePathsSet.contains(pickedFiles[i].name.trim().toLowerCase())) {
        medicalReportfiles.add(pickedFiles[i]);
        // todo : add languages
        toast("Image added successfully");
      }
    }
  }

  //Get Category List
  getCategory({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getCategory(
      categoryType: ServicesKeyConst.veterinary,
      search: searchtext,
      page: page.value,
      categoryList: categoryList,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).then((value) {
      isLoading(false);
      categoryList(value);
      hasErrorFetchingVeterinaryType(false);
      if (isUpdateForm.value) {
        selectedVeterinaryType(categoryList.firstWhere(
            (p0) => p0.id == bookingFormData.value.categoryID,
            orElse: () => ShopCategoryModel()));
        veterinaryTypeCont.text = selectedVeterinaryType.value.name;
        getService();
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingVeterinaryType(true);
      errorMessageVeterinaryType(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  ///Get Service List
  getService({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getService(
      type: ServicesKeyConst.veterinary,
      categoryId: selectedVeterinaryType.value.id.toString(),
      search: searchtext,
      page: page.value,
      serviceList: serviceList,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).then((value) {
      isLoading(false);
      serviceList(value);
      hasErrorFetchingService(false);
      if (isUpdateForm.value) {
        selectedService(serviceList.firstWhere(
            (p0) => p0.id == bookingFormData.value.veterinaryServiceId,
            orElse: () => ServiceModel()));
        serviceCont.text = selectedService.value.name;
        getVet();
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingService(true);
      errorMessageService(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  void clearVetSelection() {
    vetCont.clear();
    selectedVet(EmployeeModel(profileImage: "".obs));
  }

  //Get Vet List
  getVet({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getEmployee(
      role: EmployeeKeyConst.veterinary,
      serviceId: selectedService.value.id.toString(),
      search: searchtext,
    ).then((value) {
      isLoading(false);
      vetList(value.data);
      hasErrorFetchingVet(false);

      /// If selected service is specified employee only
      if (vetList.length == 1 &&
          selectedService.value.createdBy == vetList.first.id) {
        selectedVet(vetList.first);
        vetCont.text = selectedVet.value.fullName;
      }

      if (isUpdateForm.value) {
        selectedVet(vetList.firstWhere(
            (p0) => p0.id == bookingFormData.value.employeeId,
            orElse: () => EmployeeModel(profileImage: "".obs)));
        vetCont.text = selectedVet.value.fullName;
        isUpdateForm(false);
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingVet(true);
      errorMessageVet(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  handleBookNowClick({bool isFromReschedule = false}) {
    bookVeterinaryReq.reason = reasonCont.text.trim();
    bookVeterinaryReq.totalAmount = totalAmount;
    bookVeterinaryReq.employeeId = selectedVet.value.id;
    bookVeterinaryReq.serviceId = selectedService.value.id;
    bookVeterinaryReq.serviceName = selectedService.value.name;
    bookVeterinaryReq.duration = selectedService.value.durationMin.toString();
    bookingSuccessDate(
        "${bookVeterinaryReq.date} ${bookVeterinaryReq.time}".trim());
    log('BOOKBOARDINGREQ.TOJSON(): ${bookVeterinaryReq.toJson()}');
    if (selectedVeterinaryType.value.name
            .toLowerCase()
            .contains(ServicesKeyConst.videoConsultancyName.toLowerCase()) ||
        selectedService.value.name
            .toLowerCase()
            .contains(ServicesKeyConst.videoConsultancyName.toLowerCase())) {
      ZoomServices.generateZoomMeetingLink(
              topic: selectedService.value.name,
              startTime: bookVeterinaryReq
                  .toJson()["date_time"]
                  .toString()
                  .dateInyyyyMMddHHmmFormat,
              durationInMinuts: selectedService.value.durationMin)
          .then((value) {
        bookVeterinaryReq.startVideoLink = value.startUrl;
        bookVeterinaryReq.joinVideoLink = value.joinUrl;
      });
    }

    if (isFromReschedule) {
      try {
        BookingDetailsController bDetailCont = Get.find();
        Map<String, dynamic> req = {
          'id': bDetailCont.bookingDetail.value.id,
          'date_time':
              "${bookVeterinaryReq.date.trim()} ${bookVeterinaryReq.time.trim()}",
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
}
