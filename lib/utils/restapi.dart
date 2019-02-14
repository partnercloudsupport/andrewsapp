import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class RestApi {
  Future postData(cwid) async {
    Dio dio = new Dio();

    var url =
        "https://script.google.com/macros/s/AKfycbw-4L-nTw6md5YDo02_SkBEw1BsfzB4c-Fs6MzzAZNNPMiKPAC9/exec";
    var client = new http.Client();

    var request = new http.Request('POST', Uri.parse(url));

    FormData formData = new FormData.from(
        {'timestamp': 'this is a test', 'cwid': cwid.toString()});
    Response response1 = await dio.post(
        "https://script.google.com/macros/s/AKfycbw-4L-nTw6md5YDo02_SkBEw1BsfzB4c-Fs6MzzAZNNPMiKPAC9/exec",
        data: formData);
    print(response1);
    request.headers[HttpHeaders.AUTHORIZATION] =
        'Basic 021215421fbe4b0d27f:e74b71bbce';
    request.followRedirects = true;
  }
}