import 'package:get/get.dart';
import 'package:pawlly/utils/library.dart';

class AddPetStep2Screen extends StatelessWidget {
  AddPetStep2Screen({super.key});

  final AddPetInfoController addPetInfoController = Get.find();
  final GlobalKey<FormState> _step2formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
        key: _step2formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.height,
            Obx(() => ProfilePicWidget(
                  heroTag: "",
                  profileImage: addPetInfoController
                          .imageFile.value.path.isNotEmpty
                      ? addPetInfoController.imageFile.value.path
                      : addPetInfoController.isUpdateProfile.value
                          ? addPetInfoController.petProfileData.value.petImage
                          : Assets.iconsIcNoPhoto,
                  firstName: addPetInfoController.nameCont.text,
                  userName: "",
                  showBgCurves: false,
                  showOnlyPhoto: true,
                  showCameraIconOnCornar: false,
                  onCameraTap: () {
                    addPetInfoController.showBottomSheet(context);
                  },
                  onPicTap: () {
                    addPetInfoController.showBottomSheet(context);
                  },
                )),
            16.height,
            Obx(() => Text(locale.value.uploadPetProfilePhoto,
                    style: secondaryTextStyle())
                .visible(addPetInfoController.imageFile.value.path.isEmpty &&
                    addPetInfoController
                        .petProfileData.value.petImage.isEmpty)),
            32.height,
            AppTextField(
              title: locale.value.petName,
              textStyle: primaryTextStyle(size: 12),
              controller: addPetInfoController.nameCont,
              textFieldType: TextFieldType.NAME,
              textInputAction: TextInputAction.next,
              decoration: inputDecoration(context,
                  hintText: "${locale.value.eG}  ${locale.value.merry}",
                  filled: true,
                  fillColor: context.cardColor),
            ),
            32.height,
            AppTextField(
              title: locale.value.petBreed,
              textStyle: primaryTextStyle(size: 12),
              controller: addPetInfoController.breedCont,
              textFieldType: TextFieldType.OTHER,
              readOnly: true,
              decoration: inputDecoration(
                context,
                hintText: "${locale.value.eG}  ${locale.value.bulldog}",
                fillColor: context.cardColor,
                filled: true,
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                    size: 24, color: darkGray.withOpacity(0.5)),
              ),
              onTap: () async {
                addPetInfoController.getBreed();
                serviceCommonBottomSheet(
                  context,
                  child: Obx(
                    () => BottomSelectionSheet(
                      title: locale.value.chooseBreed,
                      hintText: locale.value.searchForBreed,
                      hasError:
                          addPetInfoController.hasErrorFetchingBreed.value,
                      isEmpty: addPetInfoController.breedList.isEmpty,
                      errorText: addPetInfoController.errorMessageBreed.value,
                      isLoading: addPetInfoController.isLoading,
                      noDataTitle: locale.value.breedListIsEmpty,
                      noDataSubTitle: locale.value.thereAreNoBreeds,
                      searchApiCall: (p0) {
                        addPetInfoController.getBreed(searchtext: p0);
                      },
                      onRetry: () {
                        addPetInfoController.getBreed();
                      },
                      listWidget: Obx(
                        () => breedListWid(
                          addPetInfoController.breedList,
                        ).expand(),
                      ),
                    ),
                  ),
                );
              },
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
                  Obx(
                    () => AppButton(
                      textStyle: appButtonPrimaryColorText,
                      color: primaryColor.withOpacity(0.2),
                      child: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: primaryColor, size: 20),
                      onTap: () {
                        addPetInfoController.handlePrevious();
                      },
                    ).visible(!addPetInfoController.isUpdateProfile.value),
                  ),
                  Obx(
                    () => 32
                        .width
                        .visible(!addPetInfoController.isUpdateProfile.value),
                  ),
                  AppButton(
                    text: locale.value.next,
                    textStyle: appButtonTextStyleWhite,
                    onTap: () {
                      if (addPetInfoController.imageFile.value.path.isEmpty &&
                          addPetInfoController
                              .petProfileData.value.petImage.isEmpty) {
                        toast(locale.value.oopsYouHavenTUploaded);
                      } else if (addPetInfoController.breedCont.text.isEmpty) {
                        toast(locale.value.oopsYouHaventSelectPetBreed);
                      } else {
                        if (_step2formKey.currentState!.validate()) {
                          _step2formKey.currentState!.save();
                          addPetInfoController.addPetReq.name =
                              addPetInfoController.nameCont.text.trim();
                          addPetInfoController.handleNext();
                        }
                      }
                    },
                  ).expand(),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget breedListWid(List<BreedModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            addPetInfoController.selectedBreed(list[index]);
            if (addPetInfoController.isUpdateProfile.value) {
              addPetInfoController.isBreedUpdate(true);
            }
            addPetInfoController.breedCont.text =
                addPetInfoController.selectedBreed.value.name;
            addPetInfoController.addPetReq.breedId =
                addPetInfoController.selectedBreed.value.id;
            Get.back();
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text(
                list[index].name,
                style: primaryTextStyle(color: secondaryTextColor),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => bottomSheetDivider,
    );
  }
}
