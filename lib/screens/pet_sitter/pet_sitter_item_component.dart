import 'package:get/get.dart';
import 'pet_sitter_model.dart';
import 'package:pawlly/utils/library.dart';

class PetSitterItemComponent extends StatelessWidget {
  final PetSitterItem petSitter;

  const PetSitterItemComponent({super.key, required this.petSitter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: petSitter.id > 0
          ? () {
              Get.to(() => EmployeeDetailScreen(), arguments: petSitter.id);
            }
          : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: Get.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedImageWidget(
              url: petSitter.profileImage,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              circle: true,
            ),
            16.height,
            Text(petSitter.fullName,
                textAlign: TextAlign.center, style: boldTextStyle(size: 12)),
            16.height,
            FilledButton(
                onPressed: (){
                  Get.to(() => EmployeeDetailScreen(), arguments: petSitter.id);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFF0F165C),
                ),
                child: Text(
                  'Book Now',
                  style: primaryTextStyle(color: Colors.white, size: 12),
                )
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
