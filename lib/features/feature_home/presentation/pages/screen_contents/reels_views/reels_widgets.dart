import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/widgets/mytext.dart';
import '../../../../data/model/home_reels_model.dart';
import '../../../controller/home_page_controller.dart';
import '../../../widgets/reels_comment_bottom_sheet.dart';

class ReelsControllerWidgets extends StatelessWidget {
  ReelsControllerWidgets({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  final controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final ReelsModel reelsModel = controller.reelsData[index];
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(999),
              //     color: Colors.white.withAlpha(80),
              //   ),
              //   height: 40,
              //   width: 40,
              //   child: Center(
              //     child: LikeButton(
              //       size: 20,
              //       isLiked: controller.reelsData[index].userLiked == "1"
              //           ? true
              //           : false,
              //       circleColor: CircleColor(
              //         start: Theme.of(context)
              //             .colorScheme
              //             .secondary
              //             .withAlpha(100),
              //         end: Theme.of(context)
              //             .colorScheme
              //             .secondary
              //             .withAlpha(100),
              //       ),
              //       bubblesColor: BubblesColor(
              //         dotPrimaryColor: Theme.of(context)
              //             .colorScheme
              //             .secondary
              //             .withAlpha(100),
              //         dotSecondaryColor: Theme.of(context)
              //             .colorScheme
              //             .secondary
              //             .withAlpha(100),
              //       ),
              //       circleSize: 80,
              //       bubblesSize: 150,
              //       onTap: (bool isLiked) async {
              //         controller.likeVideo(controller.reelsData, index);
              //         return !isLiked;
              //       },
              //       likeBuilder: (bool isLiked) {
              //         return Icon(
              //           controller.reelsData[index].userLiked == "1"
              //               ? Iconsax.heart5
              //               : Iconsax.heart4,
              //           color: controller.reelsData[index].userLiked == '1'
              //               ? Colors.red
              //               : Colors.white,
              //           size: 20,
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.005),
              // if (controller.isPlaying)
              //   MyText(
              //     txt: reelsModel.reelsLike.toString(),
              //   ),
              SizedBox(height: size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white.withAlpha(80),
                ),
                height: 40,
                width: 40,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Iconsax.messages_24, size: 16),
                    onPressed: () {
                      controller.loadReelsComment(reelsModel);
                      CommentBottomSheet(size, context, reelsModel);
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white.withAlpha(80),
                ),
                height: 40,
                width: 40,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Iconsax.video_play4, size: 16),
                    onPressed: () {
                      Constants.openVideoDetail(
                          vidTag:
                              controller.reelsData[index].videoTags.toString(),
                          picture: "");
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MyText(
              txt: controller.reelsData[index].caption!,
              color: Colors.white,
              size: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right,
              maxLine: 5,
            ),
          ),
        ],
      ),
    );
  }
}
