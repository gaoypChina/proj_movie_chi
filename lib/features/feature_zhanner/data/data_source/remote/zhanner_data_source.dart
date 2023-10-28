import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_chi/core/utils/constants.dart';
import 'package:movie_chi/features/feature_home/data/model/home_catagory_model.dart';

class ZhannerDataSource {
  Dio dio = Dio();

  Future<Response> getZhannerList() async {
    var res = await dio
        .post("${Constants.baseUrl()}${pageUrl}tags.php", queryParameters: {
      "version": await Constants.versionApplication(),
    });
    return res;
  }

  List convertModelToListIds(List<HomeItemData> homeCatagoryItem) {
    List videoIDS = [];
    for (var element in homeCatagoryItem) {
      videoIDS.add(element.id);
    }
    return videoIDS;
  }

  Future<Response> getZhannerData(
      List<HomeItemData> list, String title, int amount) async {
    List videoIds = convertModelToListIds(list);

    var res = await dio.post("${Constants.baseUrl()}${pageUrl}play_list.php",
        queryParameters: {
          "version": await Constants.versionApplication(),
          "video_ids": json.encode(videoIds.toString()),
          "keyWord": title,
          "playlist_id": title,
          "playlist_type": "more_autogenerated",
          "amount": amount,
        });
    return res;
  }
}
