import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:injectable/injectable.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/services/directus/directus_service.dart';

final directus = getIt<DirectusService>();

@Singleton(as: DirectusService)
class DirectusServiceImpl implements DirectusService {
  late DirectusCore sdk;
  final String baseUrl = 'https://plankton-app-ezq2w.ondigitalocean.app/';
  final String accessToken = '-jn0hcaJs8BOjyN4upwvePq8nnzl6Lna';
  DirectusCore get dir => sdk;

  // password: kusvur-Pofriv-toxco4
  //access token: VDVipCkLFR5hxkJczUB495CZmeNa-RbS

  // final String placesCollection = DirectusCollections.places;
  // final String boardsCollection = DirectusCollections.boards;
  // final String placesFilesCollection = DirectusCollections.placesFiles;
  // final String callSignsCollection = DirectusCollections.callSigns;

  @override
  Future<void> initDirectus() async {
    try {
      sdk = await Directus(
        baseUrl,
        // client: Dio(
        //   BaseOptions(
        //     baseUrl: baseUrl,
        //   ),
        // )
        // ..interceptors.add(LogInterceptor(
        //     logPrint: (object) {
        //       log('logger: $object\n');
        //     },
        //   )),
      ).init();
      await sdk.auth.login(
        email: 'tgFreelanceUser@mvpLab.org',
        password: 'kusvur-Pofriv-toxco4',
      );
      log('is logged? ${sdk.auth.isLoggedIn}');
    } on DirectusError catch (e) {
      log('${e.message}, ${e.additionalInfo}', name: 'Directus login');
    }
  }

  @override
  Future<void> createMany(
      {required String collection,
      required List<Map<String, dynamic>> data}) async {
    try {
      await sdk.items(collection).createMany(data);
    } on DirectusError catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> createOne(
      {required String collection, required Map<String, dynamic> data}) async {
    try {
      final res = await sdk.items(collection).createOne(data);
      return res.data;
    } on DirectusError catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteOne(
      {required String collection, required String id}) async {
    await sdk.items(collection).deleteOne(id);
  }

  @override
  Future<List<Map<String, dynamic>>> readMany(
      {required String collection, Filters? filters}) async {
    try {
      final res = await sdk.items(collection).readMany(filters: filters);
      return res.data;
    } on DirectusError catch (e) {
      log(e.message.toString());
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> readOne(
      {required String collection, required String id}) async {
    final res = await sdk.items(collection).readOne(id);

    return res.data;
  }

  @override
  Future<Map<String, dynamic>> updateOne(
      {required String collection,
      required String itemId,
      required Map<String, dynamic> updateData}) async {
    try {
      final res =
          await sdk.items(collection).updateOne(data: updateData, id: itemId);
      return res.data;
    } on DirectusError catch (e) {
      log(e.message.toString());
      return {};
    }
  }
}
