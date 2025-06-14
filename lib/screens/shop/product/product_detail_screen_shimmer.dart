import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class ProductDetailScreenShimmer extends StatelessWidget {
  const ProductDetailScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.center,
      children: [
        Stack(
          children: [
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                height: 330,
                padding: const EdgeInsets.symmetric(vertical: 170),
                decoration:
                    boxDecorationDefault(borderRadius: BorderRadius.zero),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              left: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleWidget(
                    circleColor: shimmerLightBaseColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ShimmerWidget(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: shimmerPrimaryBaseColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  CircleWidget(
                    circleColor: shimmerLightBaseColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ShimmerWidget(
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: shimmerPrimaryBaseColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ).paddingTop(24),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => ShimmerWidget(
              backgroundColor: isDarkMode.value
                  ? shimmerDarkBaseColor
                  : shimmerLightBaseColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ).paddingSymmetric(horizontal: 16, vertical: 4),
          ),
        ).paddingSymmetric(vertical: 8),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: context.cardColor, borderRadius: radius(8)),
          ),
        ).paddingRight(200).paddingLeft(16),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: context.cardColor, borderRadius: radius(8)),
          ),
        ).paddingRight(200).paddingLeft(16),
        Row(
          children: List.generate(
            5,
            (index) => ShimmerWidget(
              child: Icon(
                Icons.star_border,
                color: shimmerPrimaryBaseColor.withOpacity(0.4),
              ),
            ),
          ),
        ).paddingSymmetric(vertical: 8, horizontal: 16),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        Row(
          children: List.generate(
            3,
            (index) => ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                decoration: BoxDecoration(
                    color: context.cardColor, borderRadius: radius(8)),
              ),
            ).paddingSymmetric(vertical: 8).paddingRight(12),
          ),
        ).paddingSymmetric(horizontal: 16),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140).paddingTop(16),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: EdgeInsets.only(right: Get.width * 0.7, left: 16),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            decoration: boxDecorationDefault(),
          ),
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140).paddingTop(24),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => const ShimmerWidget(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ).paddingSymmetric(horizontal: 16, vertical: 4),
          ),
        ),
      ],
    );
  }
}
