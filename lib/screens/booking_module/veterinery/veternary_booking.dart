import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawlly/screens/booking_module/veterinery/veterinery_sel_maid.dart';
import '../../../utils/library.dart';

class VeternaryBooking extends StatelessWidget {
  VeternaryBooking({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();


  final VeterineryController veterineryController = Get.find<
      VeterineryController>();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0F59),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0F59),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            homeScreenController.goBack();
          },
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(
            homeScreenController.dashboardData.value
                .systemService[homeScreenController.selectedServiceIndex.value]
                .name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0F165C),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Obx(() {
                                      return Text(
                                        veterineryController.homeSelected.value,
                                        style: GoogleFonts.dmSans(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '2 - 3 Rooms',
                                    style: GoogleFonts.dmSans(
                                      color: Color(0xFF0F165C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10,),
                              Center(
                                child: Image.asset(
                                  'assets/images/booking_home.png',
                                  height: 150,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: veterineryController.homeOptions.map((item) {
                            final isSelected = veterineryController.homeSelected
                                .value == item;
                            return InkWell(
                              onTap: () =>
                              veterineryController.homeSelected.value = item,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFF0A0E57) : Colors
                                      .white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isSelected)
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Icon(Icons.check, size: 14,
                                            color: Color(0xFF0A0E57)),
                                      ),
                                    Text(
                                      item,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Color(
                                            0xFF0A0E57),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Your Address",
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E3F),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextField(
                                  controller: veterineryController.addressCont,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your address',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: SvgPicture.asset(
                                  'assets/images/health_loc.svg',
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Date & Time",
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E3F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Date Picker
                              GestureDetector(
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  );

                                  if (selectedDate != null) {
                                    veterineryController.bookVeterinaryReq.date =
                                        selectedDate.formatDateYYYYmmdd();
                                    veterineryController.dateCont.text =
                                        selectedDate.formatDateDDMMYY();
                                    veterineryController.bookingDate.value =
                                        selectedDate.formatDateDDMMYY();
                                    log('REQ: ${veterineryController
                                        .bookVeterinaryReq.toJson()}');
                                  } else {
                                    log("Date is not selected");
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined,
                                        color: Colors.blue),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Obx(() {
                                        return Text(
                                            veterineryController.bookingDate.value,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                            ));
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              // Time Picker
                              GestureDetector(
                                onTap: () async {
                                  if (veterineryController.dateCont.text
                                      .trim()
                                      .isEmpty) {
                                    toast(locale.value.pleaseSelectDateFirst);
                                  } else {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                        veterineryController.bookVeterinaryReq.time
                                            .dateInHHmm24HourFormat,
                                      ),
                                    );

                                    if (pickedTime != null) {
                                      final combinedDateTime = "${veterineryController
                                          .bookVeterinaryReq.date} ${pickedTime
                                          .formatTimeHHmm24Hour()}";
                                      if (combinedDateTime.isAfterCurrentDateTime) {
                                        veterineryController.bookVeterinaryReq
                                            .time =
                                            pickedTime.formatTimeHHmm24Hour();
                                        veterineryController.timeCont.text =
                                            pickedTime.formatTimeHHmmAMPM();
                                        veterineryController.bookingTime.value =
                                            pickedTime.formatTimeHHmmAMPM();
                                      } else {
                                        toast(locale.value.oopsItSeemsYouVe);
                                      }
                                    } else {
                                      log("Time is not selected");
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Text("⏰", style: TextStyle(fontSize: 24)),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Obx(() {
                                        return Text(
                                            veterineryController.bookingTime.value,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                            ));
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Add-Ons",
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E3F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedImageWidget(
                                  url: 'https://t4.ftcdn.net/jpg/03/54/89/53/360_F_354895343_JbjmKh8E2lhmfWI68oqqWxBQaeeMPpMY.jpg',
                                  height: 65,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pet Grooming",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E3F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "\$500",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: Color(0xFF1E1E3F),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0A0E57),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Add",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: Color(0xFF1E1E3F),
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Additional Comments",
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E3F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: veterineryController.reasonCont,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Text goes here for\nreference',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF1F3F9), // Light gray background
                            contentPadding: const EdgeInsets.symmetric(vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Add Image",
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E3F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        AddFilesWidget(
                          fileList: veterineryController.medicalReportfiles,
                          onFilePick: veterineryController.handleFilesPickerClick,
                          onFilePathRemove: (index) {
                            veterineryController.medicalReportfiles.remove(
                                veterineryController.medicalReportfiles[index]);
                            // todo : add languages
                            toast("Image removed successfully");
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        FilledButton(
                            onPressed: (){
                              if (veterineryController.dateCont.text.isNotEmpty &&
                                  veterineryController.timeCont.text.isNotEmpty ) {
                                veterineryController.getVet();
                                homeScreenController.goTo(VeterinerySelMaid());
                              } else {
                                toast("Please fill all the required fields");
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFF0A0E57),
                              minimumSize: Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Select Maid",
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
