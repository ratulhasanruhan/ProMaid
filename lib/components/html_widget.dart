import 'package:flutter_html/flutter_html.dart';

import 'package:pawlly/utils/library.dart';

class HtmlWidget extends StatelessWidget {
  final String? content;
  final Color? color;
  final Color? textcolor;

  const HtmlWidget({super.key, this.content, this.color, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        'embed': Style(
            color: color ?? transparentColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: FontSize(16)),
        'strong': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'a': Style(
            color: color ?? Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: FontSize(16)),
        'div': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'figure': Style(
            color: color ?? textPrimaryColorGlobal,
            fontSize: FontSize(16),
            margin: Margins(left: Margin.zero())),
        'h1': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h2': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h3': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h4': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h5': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h6': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'ol': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'ul': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'strike': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'u': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'b': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'i': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'hr': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'header': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'code': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'data': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'body': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(14)),
        'big': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'blockquote': Style(
            color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'img': Style(
            width: Width(context.width() - 48),
            height: Height(200),
            fontSize: FontSize(16),
            alignment: Alignment.center),
      },
    );
  }
}
