import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/library.dart';

class VeterinerySvType extends StatelessWidget {
  VeterinerySvType({super.key});


  final VeterineryController veterineryController = Get.put(
      VeterineryController());
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
        title: Text(
          veterineryController.veterinaryTypeCont.text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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
              if(veterineryController.serviceList.isNotEmpty){
                final services = veterineryController.serviceList;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // First row with 2 big items
                      Row(
                        children: [
                          Expanded(child: _buildBigCard(services[0])),
                          SizedBox(width: 16),
                          Expanded(child: _buildBigCard(services[1])),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Remaining items in 3-column grid
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: services.sublist(2).map((item) {
                          return SizedBox(
                            width: (MediaQuery.of(context).size.width - 16 * 2 - 12 * 2) / 3,
                            child: _buildSmallCard(item),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }
              else if (veterineryController.hasErrorFetchingService.value) {
                return Center(
                  child: Text(
                    veterineryController.errorMessageService.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              else if (veterineryController.isLoading.value) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              else {
                return Center(
                  child: Text(
                    "No services available",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
  Widget _buildBigCard(ServiceModel item) {
    return Container(
      height: 140,
      padding: EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CachedImageWidget(url: item.serviceImage, width: 80),
          ),
          Text(
            item.name,
            maxLines: 2,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(ServiceModel item) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: _cardDecoration(),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CachedImageWidget(url: item.serviceImage, width: 50),
          ),
          Text(
            item.name,
            maxLines: 1,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: RadialGradient(
        center: Alignment(1, 1),
        radius: 1.2,
        colors: [
          Colors.white,
          Color(0xFFD4E0EB)
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

}
