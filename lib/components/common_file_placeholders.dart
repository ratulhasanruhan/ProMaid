import 'package:pawlly/utils/library.dart';

class CommonPdfPlaceHolder extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const CommonPdfPlaceHolder(
      {super.key, this.height = 90, this.width = 80, this.text = "file"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.file_copy_rounded,
            color: primaryColor,
            size: 32,
          ),
          15.height,
          Marquee(
              child: Text(text == locale.value.file ? locale.value.file : text,
                  style: primaryTextStyle(),
                  maxLines: 1,
                  textAlign: TextAlign.center)),
        ],
      ).center(),
    );
  }
}
