import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../features/feature_detail_page/data/model/video_model.dart';
import '../../features/feature_detail_page/presentation/pages/detail_page.dart';
import '../../features/feature_home/data/model/cinimo_config_model.dart';
import '../../features/feature_home/data/model/home_catagory_model.dart';
import '../../features/feature_home/presentation/widgets/home_drawer.dart';
import '../../features/feature_play_list/presentation/pages/feature_play_list.dart';
import '../../features/feature_video_player/presentation/pages/feature_video_player.dart';
import '../widgets/mytext.dart';

String bbaseUrl = "https://api.cinimo.ir";
String bfileBaseUrl = "https://files.cinimo.ir";
String pageUrl = "/v5/cinimo/";

String packageName = "com.arianadeveloper.movie.chi";

class Constants {
  static String formatTime(int seconds) {
    int hours = (seconds / 3600).truncate();
    int minutes = ((seconds - (hours * 3600)) / 60).truncate();
    int remainingSeconds = seconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    if (hours > 0) {
      String formattedHours = hours.toString().padLeft(2, '0');
      return "$formattedHours:$formattedMinutes:$formattedSeconds";
    } else {
      return "$formattedMinutes:$formattedSeconds";
    }
  }

  static const String telegramUrl = "https://t.me/cinimo_offcial";
  static const String instagramUrl = "https://instagram.com/moviechi.reels";

  static bool allowToShowAd() {
    if (kIsWeb) {
      return false;
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        return true;
      } else {
        return false;
      }
    }
  }

  static String baseUrl() {
    CinimoConfig config = configDataGetter();

    if (config.config?.baseUrl != null) {
      return config.config!.baseUrl!;
    } else {
      return bbaseUrl;
    }
  }

  static String fileBaseUrl() {
    CinimoConfig config = configDataGetter();
    if (config.config?.baseUrl != null) {
      return config.config!.fileUrl!;
    } else {
      return bfileBaseUrl;
    }
  }

  static String videoUrl = "${fileBaseUrl()}/cinimo/videos/";
  static String imageUrl = "${fileBaseUrl()}/cinimo/images/";

  static String imageFiller(String img) {
    if (isLink(img)) {
      return img;
    } else {
      return imageUrl + img;
    }
  }

  static String videoFiller(String videoLink) {
    if (isLink(videoLink)) {
      return videoLink;
    } else {
      return imageUrl + videoLink;
    }
  }

//unoffcial, offcial =

  static Future<String> versionApplication() async {
    // if (GetStorageData.getData("version") != null) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
    // GetStorageData.writeData("version", packageInfo.buildNumber);
    // }
    // return GetStorageData.getData("version");

    // return "35";
  }

  // static String versionApplication = "36";
// bazaar | google | myket
  static String market_name = "google";

  static String iconSrc = "assets/images/icon.png";
  static Future<dynamic> showGeneralProgressBar({bool backDismissable = true}) {
    return Get.dialog(
        WillPopScope(
          onWillPop: () async {
            return backDismissable;
          },
          child: SizedBox(
              height: 60,
              width: 60,
              child: Center(
                  child: LoadingAnimationWidget.flickr(
                size: 50,
                leftDotColor: Get.theme.colorScheme.secondary,
                rightDotColor:
                    Get.theme.colorScheme.background.withOpacity(0.5),
              ))),
        ),
        barrierDismissible: false);
  }

  static showGeneralSnackBar(String titl, String txt) {
    Get.snackbar(
      titl,
      txt,
      titleText: MyText(
        txt: titl,
        color: Colors.black,
        textAlign: TextAlign.center,
        size: 15.h,
      ),
      messageText: MyText(
        txt: txt,
        color: Colors.black,
        textAlign: TextAlign.center,
        size: 12.h,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
      colorText: Colors.black,
      margin: const EdgeInsets.all(15.0),
      borderRadius: 10.0,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static openVideoPlayer(Video video,
      {bool? isLocal, String? path, String? customLink}) {
    Get.to(() => VideoPlayerScreen(isLocaled: isLocal ?? false), arguments: {
      "data": video,
      "isLocal": isLocal ?? false,
      "path": path ?? "",
      "custom_link": customLink
    });
    // show dialog to choose player
    // Get.dialog(
    //   AlertDialog(
    //     title: const MyText(
    //       txt: "انتخاب پلیر",
    //       textAlign: TextAlign.center,
    //     ),
    //     content: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ListTile(
    //           onTap: () async {
    //             try {
    //               AppInfo appInfo2 = await AppCheck.checkAvailability(
    //                       "com.mxtech.videoplayer.pro") ??
    //                   AppInfo(packageName: "");

    //               if (appInfo2.packageName.isNotEmpty) {
    //                 Get.close(0);
    //                 await ExternalVideoPlayerLauncher.launchMxPlayer(
    //                     customLink != null
    //                         ? Constants.videoFiller(customLink)
    //                         : getVideoUrl(video),
    //                     MIME.applicationMp4,
    //                     {
    //                       "title": video.title ?? '',
    //                     });
    //               }
    //             } catch (ee) {
    //               try {
    //                 AppInfo appInfo = await AppCheck.checkAvailability(
    //                         "com.mxtech.videoplayer.ad") ??
    //                     AppInfo(packageName: "");
    //                 if (appInfo.packageName.isNotEmpty) {
    //                   Get.close(0);
    //                   await ExternalVideoPlayerLauncher.launchMxPlayer(
    //                       customLink != null
    //                           ? Constants.videoFiller(customLink)
    //                           : getVideoUrl(video),
    //                       MIME.applicationMp4,
    //                       {
    //                         "title": video.title ?? '',
    //                       });
    //                 }
    //               } catch (eee) {
    //                 // show dialog guaid  to install mx
    //                 // title : خطا در بازگرذن برنامه MxPlayer
    //                 // desc : دوست برای بازکردن با MxPlayer باید ابتدا آن را نصب کنی زیر شما این برنامه را نصب ندارید
    //                 // button : نصب برنامه
    //                 Get.dialog(
    //                   Directionality(
    //                     textDirection: TextDirection.rtl,
    //                     child: AlertDialog(
    //                       title: const MyText(
    //                         txt: "خطا در بازگردن برنامه MxPlayer",
    //                         textAlign: TextAlign.center,
    //                       ),
    //                       content: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           const MyText(
    //                             txt:
    //                                 "دوست عزیز برای بازکردن با MxPlayer باید ابتدا آن را نصب کنی زیر شما این برنامه را نصب ندارید",
    //                             textAlign: TextAlign.center,
    //                           ),
    //                           const SizedBox(
    //                             height: 10,
    //                           ),
    //                           ElevatedButton(
    //                             onPressed: () async {
    //                               // open url : https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad
    //                               openUrl(
    //                                   "https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad");
    //                             },
    //                             child: const MyText(
    //                               txt: "نصب برنامه",
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }
    //             }
    //             // TODO
    //           },
    //           title: const MyText(
    //             txt: "MX Player",
    //             textAlign: TextAlign.center,
    //           ),
    //           leading: const Icon(
    //             Iconsax.play_circle5,
    //             color: Colors.green,
    //           ),
    //         ),
    //         ListTile(
    //           onTap: () async {

    //           },
    //           title: const MyText(
    //             txt: "پلیر داخلی برنامه",
    //             textAlign: TextAlign.center,
    //           ),
    //           leading: const Icon(
    //             Iconsax.play_circle5,
    //             color: Colors.green,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  static openHomeItem(
      HomeCatagoryItemModel homeCatagoryItem, int index, String pic,
      {String type = "custom"}) {
    switch (homeCatagoryItem.valueType) {
      case "video":
        // Get.to(() => DetailPage(vid_tag: homeCatagoryItem.data![index].tag!));
        openVideoDetail(
            picture: pic,
            vidTag: homeCatagoryItem.data![index].tag!,
            type: homeCatagoryItem.data?[index].type,
            commonTag: homeCatagoryItem.data?[index].commonTag);
        break;

      case "data":
        String val = (homeCatagoryItem.data![index].tags!);

        if (val.startsWith("https://")) {
          openUrl(val);
        } else {
          Get.to(() => PlayListScreen(
                homeCatagoryItemID: homeCatagoryItem.data![index].id.toString(),
                type: type,
                backGroundImage:
                    homeCatagoryItem.data![index].thumbnail1x ?? '',
                title: homeCatagoryItem.data![index].title ?? '',
              ));
        }

        break;
      default:
        break;
    }
  }

  static openVideoDetail({
    required String vidTag,
    String? commonTag,
    String? type,
    bool deepLink = false,
    required String picture,
  }) async {
    await Get.to(() => DetailPage(
          vid_tag: vidTag,
          pic: picture,
        ));
  }

  static Color hexToColor(String hexString) {
    String opacity = "0.8";
    if (hexString.contains("+")) {
      opacity = hexString.split("+")[1];
    }

    // remove +0.2
    hexString = hexString.split("+")[0];

    final buffer = StringBuffer();
    if (hexString.length == 6) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));

    final int color = int.parse(buffer.toString(), radix: 16);

    return Color.fromRGBO(
        ((color & 0xFF0000) >> 16), // red
        ((color & 0xFF00) >> 8), // green
        ((color & 0xFF) >> 0), // blue
        double.parse(opacity));
  }
}

bool isLink(String text) {
  RegExp regExp = RegExp(
      r"^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$");
  return regExp.hasMatch(text);
}

void LogPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object.toString().length <= defaultPrintLength) {
    debugPrint(object.toString());
  } else {
    String log = object.toString();
    int start = 0;
    int endIndex = defaultPrintLength;
    int logLength = log.length;
    int tmpLogLength = log.length;
    while (endIndex < logLength) {
      debugPrint(log.substring(start, endIndex));
      endIndex += defaultPrintLength;
      start += defaultPrintLength;
      tmpLogLength -= defaultPrintLength;
    }
    if (tmpLogLength > 0) {
      debugPrint(log.substring(start, logLength));
    }
  }
}
