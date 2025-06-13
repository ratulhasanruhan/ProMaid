import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawlly/screens/booking_module/veterinery/veterinery_service_controller.dart';
import '../../home/home_controller.dart';

class VeternaryBooking extends StatelessWidget {
  VeternaryBooking({super.key});

  final VeterineryController veterineryController = Get.find<VeterineryController>();
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
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.75,
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
              return SingleChildScrollView();
            }),
          )
        ],
      ),
    );
  }
}
