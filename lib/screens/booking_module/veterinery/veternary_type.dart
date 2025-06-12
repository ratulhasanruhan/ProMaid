import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawlly/screens/booking_module/veterinery/veterinery_sv_type.dart';
import '../../../utils/library.dart';

class VeternaryType extends StatelessWidget {
  VeternaryType({super.key});

  final VeterineryController veterineryController = Get.put(
      VeterineryController());
  final HomeScreenController homeScreenController = Get.find();

  final List<Color> cardColor = [
    Color(0xFF46CF08),
    Color(0xFF888888),
    Color(0xFF0F165C).withValues(alpha: 0.03),
    Color(0xFFFFBC34),
    Color(0xFFD9D9D9),
  ];

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
                .height * 0.7,
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
              if(veterineryController.categoryList.isNotEmpty){
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  shrinkWrap: true,
                  itemCount: veterineryController.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = veterineryController.categoryList[index];
                    print(category.name);
                    return InkWell(
                      onTap: () {
                        veterineryController.selectedVeterinaryType.value = category;
                        veterineryController.veterinaryTypeCont.text = category.name;
                        veterineryController.getService();
                        homeScreenController.goTo(VeterinerySvType());
                      },
                      borderRadius: radius(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: boxDecorationDefault(
                            color: cardColor[Random().nextInt(cardColor.length)],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecorationDefault(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: CachedImageWidget(
                                  url: category.categoryImage,
                                  height: 45,
                                  width: 45,
                                  usePlaceholderIfUrlEmpty: false,
                                ),
                              ),
                            ),
                            12.height,
                            Text(
                                category.name,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: primaryTextStyle(
                                    decoration: TextDecoration.none))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }),
          )
        ],
      ),
    );
  }
}
