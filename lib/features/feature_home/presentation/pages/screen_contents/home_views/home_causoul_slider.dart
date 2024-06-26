import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:movie_chi/core/utils/constants.dart';
import 'package:movie_chi/core/widgets/my_button.dart';
import 'package:movie_chi/features/feature_home/presentation/controller/galler_controller.dart';

import '../../../../data/model/home_catagory_model.dart';
import '../../../controller/home_page_controller.dart';

// ignore: must_be_immutable
class HomeGalleryVideos extends StatelessWidget {
  HomeGalleryVideos({
    super.key,
    required this.itemGalleryData,
  });

  final HomeCatagoryItemModel itemGalleryData;
  // final homePageController = Get.find<HomePageController>();

  int currentGalleryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.hexToColor(itemGalleryData.viewColor!)
          .withAlpha(int.parse(itemGalleryData.colorAlpha ?? "255")),
      child: GetBuilder<GalleryController>(
          init: GalleryController(),
          builder: (galleryController) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: Get.size.height * 0.50,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: galleryController.pageController,
                      onPageChanged: (index) {
                        galleryController.onPageChanged(index);
                      },
                      itemCount: itemGalleryData.data!.length > 6
                          ? 6
                          : itemGalleryData.data!.length,
                      itemBuilder: (context, index) {
                        final i = itemGalleryData.data![index];
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(width * 0.9 / 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      // await Get.to(() => DetailPage(
                                      //       vid_tag: i.tag!,
                                      //     ));
                                      await Constants.openVideoDetail(
                                          vidTag: i.tag!,
                                          type: i.type,
                                          commonTag: i.commonTag,
                                          picture: i.thumbnail1x!);
                                      final homePageController =
                                          Get.find<HomePageController>();
                                      homePageController.returnScreen();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: Constants.imageFiller(
                                            i.thumbnail1x!),
                                        color: Colors.black26,
                                        colorBlendMode: BlendMode.darken,
                                        fit: BoxFit.cover,
                                        httpHeaders: const {
                                          'Referer': 'https://www.cinimo.ir/'
                                        },
                                        // handle error
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                    ),

                    // add play button
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        // padding: const EdgeInsets.symmetric(
                        //     vertical: 50),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black26,
                              Theme.of(context).colorScheme.surface
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            const Gap(20),
                            Row(
                              children: [
                                MyButton(
                                  onPressed: () {
                                    Constants.openVideoDetail(
                                        vidTag: itemGalleryData
                                            .data![
                                                galleryController.galleryIndex]
                                            .tag!,
                                        type: itemGalleryData
                                            .data![
                                                galleryController.galleryIndex]
                                            .type,
                                        commonTag: itemGalleryData
                                            .data![
                                                galleryController.galleryIndex]
                                            .commonTag,
                                        picture: itemGalleryData
                                            .data![
                                                galleryController.galleryIndex]
                                            .thumbnail1x!);
                                    final homePageController =
                                        Get.find<HomePageController>();
                                    homePageController.returnScreen();
                                  },
                                  text: 'تماشا',
                                  color: Colors.red,
                                  icon: Icons.play_arrow,
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: itemGalleryData.data!
                                  .getRange(0, 6)
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (galleryController.galleryIndex ==
                                            index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                    ),

                    // add indicator
                  ],
                ),
              ),
            );
          }),
    );
  }
}
