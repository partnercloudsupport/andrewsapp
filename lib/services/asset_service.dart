import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/asset.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';

final DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
final Dio dio = new Dio();
// final BaseOptions options = new BaseOptions(
//     baseUrl: "http://47.219.174.153:8085/api/v1",
//     connectTimeout: 5000,
//     receiveTimeout: 3000,
//     headers: {
//       'Authorization':
//           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3ZTRkYjEzMjU4NzUzM2QxYjZjYjA3Y2U5OGJmNzZjMjhhMzM2Yjk0YzBmMzg0MzRiMTUxOTJlMDA2MDBjNDQ5MjQ3YzU0MjRmMmNmZmM0In0.eyJhdWQiOiIzIiwianRpIjoiNjdlNGRiMTMyNTg3NTMzZDFiNmNiMDdjZTk4YmY3NmMyOGEzMzZiOTRjMGYzODQzNGIxNTE5MmUwMDYwMGM0NDkyNDdjNTQyNGYyY2ZmYzQiLCJpYXQiOjE1NDk4NTM5MDgsIm5iZiI6MTU0OTg1MzkwOCwiZXhwIjoxNTgxMzg5OTA4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.dml5K0kWint7BMjwlFXUEuL0bnGMFUuBGty06kHUgA_Wvq7P9yaITJuFcgSxsDDkg7c9npXUcTMiQBMObPHCPB9EOZD39jsOgCbGoKeZuH5VqbEGK8xP2fcpY4lDyozr3ldTsgctRNrjIlRLP9Y-fqN5jDez_wptymWoYVfNmuR_YV1tiOlTFYj2qbc7UEcbJj7VzPxSJGGFESGuOdXyhONTcR91lw08Judw9cMSkvHAmWueFoCFjM3lM95b07ojlkyVeVRzDbDkag-VPAYd6sIelpOcJamn84wk98id0x2ht422yTPPrCSa6Fpxu132gWONqg-JaazQWfVFr5_ClFftQnR6rXrJS60WSyGzX8_cvpPnX5Bru4vgLa0SD7e7k_azYP3dEjmZF2dkOt7ayyF4iRsq7jlfspczkkrD4y1pfGxKXfpeS2KKwqz74QUKRK98jXClHPCSGeBtxuKemxtUWilW9nt405fyZMFAUHANGTFg86XdIXm_ydpLDpjtp4x-hwBUJwUYJctHObjpd4r1tmyFALTWD47Y5DAz353VH-N3fmixU1wMCHOAR26EHftLTmSFL6hlGBQuORVpP_vmNvEXGJ5Toyrvtf3P4tsrRhN5AVrGc7o7Ea6IfhNvwvZHa7C3Pdw2fqdX5SrHVQWq0ei8LW3tR0A2BUqcCIk',
//     });

Asset parseAsset(String responseBody) {
  // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  // Map resopnse = new Map<String, dynamic>();

  // return parsed.map<Asset>((json) => fromMap(json)).toList();
}

class AssetService {
  // Dio snipeIt = new Dio(options);

  // AssetService({
  //   // @required this.snipeIt,
  // });

  Future<Asset> getAssetBySerial(serialNumber) async {
    var resp = await dio.get('/hardware/byserial/' + serialNumber);
    Map data = resp.data['rows'][0];
    Asset _asset = AssetSerializer().fromMap(data);
    return _asset;
  }

  // Future<Device> getAssets() async {
  //   // final response = await http.get(
  //   //   'https://jsonplaceholder.typicode.com/posts/1',
  //   //   headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  //   // );
  //   // final responseJson = json.decode(response.body);
  //   // return compute(parseDevice, response.body);
  // }

  Future<Asset> getAssetById(assetId) async {
    var resp = await dio.get('/hardware/' + assetId);
    Map data = resp.data['rows'][0];
    Asset _asset = AssetSerializer().fromMap(data);
    return _asset;
  }

  Future<Asset> addMaintenanceLog(assetId, notes) async {
    var resp = await dio.get('/hardware/' + assetId);
    Map data = resp.data['rows'][0];
    Asset _asset = AssetSerializer().fromMap(data);
    return _asset;
  }
}
