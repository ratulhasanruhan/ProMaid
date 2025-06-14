import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class AddPetStep3Screen extends StatelessWidget {
  AddPetStep3Screen({super.key});

  final AddPetInfoController addPetInfoController = Get.find();
  final GlobalKey<FormState> _step3formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    log('HEIGHTUNITS: ${heightUnits.length}');
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor:
          WidgetStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(WidgetState.focused)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return Colors.transparent;
        }
        return Colors.transparent;
      }),
      onTap: () => hideKeyboard(context),
      child: Form(
        key: _step3formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            genderWidget(context),
            birthdateWidget(context),
            32.height,
            Text('${locale.value.weight} ${locale.value.In} ${addPetInfoController.selectedWeightUnit.value.value})',
                    style: primaryTextStyle())
                .paddingSymmetric(horizontal: 16),
            8.height,
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    /*title: '${locale.value.weight} ${locale.value.In} ${addPetInfoController.selectedWeightUnit.value.value})',
                   */
                    textStyle: primaryTextStyle(size: 12),
                    controller: addPetInfoController.weightCont,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      DecimalTextInputFormatter(decimalRange: 2),
                    ],
                    decoration: inputDecoration(context,
                        hintText:
                            "${locale.value.eG} 3 ${addPetInfoController.selectedWeightUnit.value.value}",
                        filled: true,
                        fillColor: context.cardColor),
                    suffix: Assets.iconsIcWeight
                        .iconImage(fit: BoxFit.contain)
                        .paddingAll(14),
                  ).expand(flex: 5),
                  16.width,
                  Container(
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        dropdownColor: context.cardColor,
                        borderRadius: BorderRadius.circular(defaultRadius),
                        items: weightUnits.map((wUnit) {
                          return DropdownMenuItem(
                            value: wUnit,
                            child: Text(wUnit.value,
                                style: primaryTextStyle(size: 13)),
                          );
                        }).toList(),
                        onChanged: (type) {
                          if (type != null) {
                            addPetInfoController.selectedWeightUnit(type);
                          }
                        },
                        value:
                            addPetInfoController.selectedWeightUnit.value.id > 0
                                ? addPetInfoController.selectedWeightUnit.value
                                : weightUnits.first,
                      ),
                    ),
                  ).expand(flex: 2),
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
            32.height,
            Text('${locale.value.height} ${locale.value.In} ${addPetInfoController.selectedHeightUnit.value.value})',
                    style: primaryTextStyle())
                .paddingSymmetric(horizontal: 16),
            8.height,
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    /* title: '${locale.value.height} ${locale.value.In} ${addPetInfoController.selectedHeightUnit.value.value})',
                  */
                    textStyle: primaryTextStyle(size: 12),
                    controller: addPetInfoController.heightCont,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      DecimalTextInputFormatter(decimalRange: 2),
                    ],
                    decoration: inputDecoration(context,
                        hintText:
                            "${locale.value.eG} 3.5 ${addPetInfoController.selectedHeightUnit.value.value}",
                        filled: true,
                        fillColor: context.cardColor),
                    suffix: Assets.iconsIcHeight
                        .iconImage(fit: BoxFit.contain)
                        .paddingAll(14),
                  ).expand(flex: 5),
                  16.width,
                  Container(
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        dropdownColor: context.cardColor,
                        borderRadius: BorderRadius.circular(defaultRadius),
                        items: heightUnits.map((hUnit) {
                          return DropdownMenuItem(
                            value: hUnit,
                            child: Text(hUnit.value,
                                style: primaryTextStyle(size: 13)),
                          );
                        }).toList(),
                        onChanged: (type) {
                          if (type != null) {
                            addPetInfoController.selectedHeightUnit(type);
                          }
                        },
                        value:
                            addPetInfoController.selectedHeightUnit.value.id > 0
                                ? addPetInfoController.selectedHeightUnit.value
                                : heightUnits.first,
                      ),
                    ),
                  ).expand(flex: 2),
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
            SizedBox(
              height: Get.height * 0.12,
            ),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppButton(
                    textStyle: appButtonPrimaryColorText,
                    color: primaryColor.withOpacity(0.2),
                    child: const Icon(Icons.arrow_back_ios_new_outlined,
                        color: primaryColor, size: 20),
                    onTap: () {
                      addPetInfoController.handlePrevious();
                    },
                  ),
                  32.width,
                  AppButton(
                    text: addPetInfoController.isUpdateProfile.isTrue
                        ? (locale.value.update)
                        : locale.value.done,
                    textStyle: appButtonTextStyleWhite,
                    onTap: () async {
                      if (!await isNetworkAvailable()) {
                        toast(errorInternetNotAvailable);
                      } else {
                        if (addPetInfoController.imageFile.value.path.isEmpty &&
                            addPetInfoController
                                .petProfileData.value.petImage.isEmpty) {
                          toast(locale.value.oopsYouHavenTUploaded);
                        } else {
                          if (_step3formKey.currentState!.validate()) {
                            _step3formKey.currentState!.save();
                            addPetInfoController.addPetApi();
                          }
                        }
                      }
                    },
                  ).expand(),
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget genderWidget(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.value.gender, style: primaryTextStyle())
              .paddingSymmetric(horizontal: 16),
          8.height,
          Row(
            children: [
              SizedBox(
                width: Get.width,
                child: RadioListTile(
                  tileColor: context.cardColor,
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  fillColor: WidgetStateProperty.all(primaryColor),
                  title: Text(locale.value.female.capitalizeFirstLetter(),
                      style: secondaryTextStyle()),
                  value: GenderTypeConst.FEMALE,
                  groupValue: addPetInfoController.genderOption.value,
                  onChanged: (value) {
                    addPetInfoController.genderOption(value.toString());
                  },
                ),
              ).expand(),
              16.width,
              SizedBox(
                width: Get.width,
                child: RadioListTile(
                  value: GenderTypeConst.MALE,
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  tileColor: context.cardColor,
                  fillColor: WidgetStateProperty.all(primaryColor),
                  title: Text(locale.value.male.capitalizeFirstLetter(),
                      style: secondaryTextStyle()),
                  groupValue: addPetInfoController.genderOption.value,
                  onChanged: (value) {
                    addPetInfoController.genderOption(value.toString());
                  },
                ),
              ).expand(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget birthdateWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        AppTextField(
          title: locale.value.birthday,
          textStyle: primaryTextStyle(size: 12),
          controller: addPetInfoController.birthdayCont,
          textFieldType: TextFieldType.NAME,
          readOnly: true,
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now());

            if (selectedDate != null) {
              addPetInfoController.birthdayCont.text =
                  selectedDate.formatDateYYYYmmdd();
            } else {
              log("Birthday is not selected");
            }
          },
          decoration: inputDecoration(
            context,
            hintText: locale.value.selectBirthday,
            fillColor: context.cardColor,
            filled: true,
            suffixIcon: Assets.navigationIcCalendarOutlined
                .iconImage(color: secondaryTextColor, fit: BoxFit.contain)
                .paddingAll(14),
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
