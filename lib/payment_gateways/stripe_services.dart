// ignore_for_file: constant_identifier_names

import 'package:flutter_stripe/flutter_stripe.dart';
import '../../configs.dart';
import 'package:http/http.dart' as http;
import 'package:pawlly/utils/library.dart';

class StripeServices {
  static Future<void> stripePaymentMethod(
      {required num amount,
      required Function(bool) loderOnOFF,
      required Function(Map<String, dynamic>) onComplete}) async {
    loderOnOFF(true);
    try {
      Stripe.publishableKey = appConfigs.value.stripePay.stripePublickey;
      Stripe.merchantIdentifier = STRIPE_merchantIdentifier;

      await Stripe.instance.applySettings().catchError((e) {
        toast(e.toString(), print: true);
        throw e.toString();
      });
      final paysheetData =
          await getStripePaymentIntents(amount: amount, loderOnOFF: loderOnOFF);
      String? clientSecret =
          paysheetData == null ? null : paysheetData["client_secret"];
      String? tnxId =
          paysheetData == null ? null : paysheetData["transaction_id"];
      SetupPaymentSheetParameters setupPaymentSheetParameters =
          SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        style: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: primaryColor)),
        merchantDisplayName: APP_NAME,
        customerId: loginUserData.value.email,
        //customerEphemeralKeySecret: isAndroid ? clientSecret : null,
        setupIntentClientSecret: clientSecret,
        billingDetails: BillingDetails(
          name: loginUserData.value.userName,
          email: loginUserData.value.email,
          address: Address(
            city: "",
            country: defaultCountry.countryCode,
            line1: "",
            line2: "",
            postalCode: "",
            state: "",
          ),
        ),
      );

      await Stripe.instance
          .initPaymentSheet(paymentSheetParameters: setupPaymentSheetParameters)
          .then((value) async {
        await Stripe.instance.presentPaymentSheet().then((val) async {
          onComplete.call({
            'transaction_id': tnxId,
          });
        }).catchError((e) {
          log('Stripe present sheet method: $e');
        });
      }).catchError((e) {
        log('Stripe init sheet method: $e');
      });
    } catch (e) {
      log('stripePaymentMethod catch: $e');
    }
  }

  static Future<Map<String, dynamic>?> getStripePaymentIntents(
      {required num amount, required Function(bool) loderOnOFF}) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${appConfigs.value.stripePay.stripeSecretkey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var request = http.Request('POST', Uri.parse(STRIPE_URL));

      request.bodyFields = {
        'amount': (amount * 100).toInt().toString(),
        'currency': isIqonicProduct
            ? STRIPE_CURRENCY_CODE
            : appCurrency.value.currencyCode,
        'description':
            'Name: ${loginUserData.value.userName} - Email: ${loginUserData.value.email}',
      };

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var res = jsonDecode(await response.stream.bytesToString());

      log('RESPONSE: ${response.reasonPhrase}');

      apiPrint(
        url: STRIPE_URL,
        request: jsonEncode(request.bodyFields),
        responseBody: jsonEncode(res),
        statusCode: response.statusCode,
      );
      if (response.statusCode == 200) {
        log("Response: $res");
        loderOnOFF.call(false);
        var paymentDetail = {
          "transaction_id": res["id"],
          "client_secret": res["client_secret"]
        };
        return paymentDetail;
      } else {
        loderOnOFF.call(false);
      }
    } catch (e) {
      toast(e.toString(), print: true);
    }
    return null;
  }
}
