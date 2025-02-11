import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_chi/core/utils/get_storage_data.dart';

import 'package:movie_chi/core/utils/page_status.dart';
import 'package:movie_chi/core/widgets/mytext.dart';

import 'package:movie_chi/features/feature_detail_page/presentation/controllers/detail_page_controller.dart';

import '../widgets/detail_page_content.dart';
import '../widgets/detail_page_loading_view.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.vidTag,
      this.deepLinking = false,
      this.heroTag,
      required this.pic})
      : super(key: key);

  final String vidTag;
  final bool deepLinking;
  final String pic;
  final String? heroTag;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List secdata = [];

  final pageController = Get.find<DetailPageController>();

  @override
  void initState() {
    super.initState();
    // pageController.placeholder = widget.pic;
    pageController.setVideoTag(widget.vidTag);

    pageController.checkUSers();

    // remove deeplinked saved to opened
    removeDeepLinkSaved();
  }

  removeDeepLinkSaved() async {
    Map notifData =
        await GetStorageData.readDataWithAwaiting("notif_data") ?? {};

    if (notifData['tag'] == widget.vidTag) {
      GetStorageData.writeData("has_notif", false);
      GetStorageData.writeData("notif_data", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Icon(Iconsax.arrow_right_14,
                color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<DetailPageController>(builder: (controller) {
                if (controller.detailPageStatus == PageStatus.loading) {
                  return DetailPageLoadingView(
                    hieght: hieght,
                    width: width,
                    img: widget.pic,
                    heroTag: widget.heroTag,
                  );
                }
                if (controller.detailPageStatus == PageStatus.error) {
                  return Center(
                      child: Column(
                    children: [
                      LottieBuilder.asset("assets/lotties/empty.json"),
                      MyText(
                        txt: "خطا ",
                        size: 24,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      MyText(
                        txt: "مشکلی در ارتباط با سرور پیش آمده است",
                        size: 16,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ],
                  ));
                }
                // return Container();

                return DetailPageContent(
                  deepLinking: widget.deepLinking,
                  heroTag: widget.heroTag,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
