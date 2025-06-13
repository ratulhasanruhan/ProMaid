import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/library.dart';


class VeterinerySelMaid extends StatelessWidget {
  VeterinerySelMaid({super.key});

  final VeterineryController veterineryController = Get.find<
      VeterineryController>();
  final HomeScreenController homeScreenController = Get.find();

  ScrollController scrollController = ScrollController();

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
              if (veterineryController.vetList.isEmpty) {
                return Center(
                  child: Text(
                    'No Maid Available',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                );
              }
              else {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          itemCount: veterineryController.vetList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.67,
                          ),
                          itemBuilder: (context, index) {
                            final vet = veterineryController.vetList[index];

                            return InkWell(
                              onTap: () {
                                veterineryController.selectedVet(vet);
                                veterineryController.vetCont.text =
                                    veterineryController.selectedVet.value.fullName;

                                veterineryController.showBookBtn(true);

                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minHeight: 90,
                                            maxHeight: 110,
                                          ),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: CachedImageWidget(
                                                  url: vet.profileImage
                                                      .value),
                                            ), // OR Image.network
                                          ),
                                        ),
                                        Obx(() {
                                          if (veterineryController.selectedVet.value.id == vet.id) {
                                            return Positioned(
                                              top: 8,
                                              right: 8,
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.white,
                                                child: Icon(Icons.check_circle_outline,
                                                    color: Color(0xFF0054A5), size: 20),
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      vet.fullName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      vet.expert ?? 'Not specified',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.star, color: Color(0xFF0054A5),
                                                size: 18),
                                            Text(
                                              vet.ratingStar.toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF0054A5),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF0054A5),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Book',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                            () => AppButtonWithPricing(
                          price: totalAmount.toStringAsFixed(2).toDouble(),
                          tax: totalTax.toStringAsFixed(2).toDouble(),
                          items: getServiceNameByServiceElement(
                              serviceSlug: currentSelectedService.value.slug),
                          serviceImg: currentSelectedService.value.serviceImage,
                          onTap: () {
                            hideKeyboard(context);
                            veterineryController.handleBookNowClick();
                          },
                        )
                            .visible(veterineryController.showBookBtn.value),
                      ),
                    ],
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
