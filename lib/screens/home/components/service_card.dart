import '../../dashboard/dashboard_res_model.dart';
import 'package:pawlly/utils/library.dart';

class ServiceCard extends StatelessWidget {
  final SystemService service;
  final double width;
  final double height;
  final Widget? child;
  final bool showSubTexts;
  final Color? color;

  const ServiceCard({
    super.key,
    required this.service,
    this.width = 130,
    this.height = 130,
    this.showSubTexts = false,
    this.child,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: boxDecorationDefault(
          color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showSubTexts) 12.height,
          Hero(
              tag: service.serviceImage + service.id.toString(),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationDefault(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: CachedImageWidget(
                    url: service.serviceImage,
                    height: 45,
                    width: 45,
                    usePlaceholderIfUrlEmpty: false,
                  ),
                ),
              )),
          12.height,
          Hero(
              tag: service.name + service.id.toString(),
              child: Text(
                  getServiceNameByServiceElement(serviceSlug: service.slug),
                  style: primaryTextStyle(decoration: TextDecoration.none))),
          if (showSubTexts) 12.height,
          if (showSubTexts)
            Text(service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle())
                .paddingSymmetric(horizontal: 14),
          if (showSubTexts) 12.height,
        ],
      ),
    );
  }
}
