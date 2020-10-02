import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/app/model/character.dart';

import 'api.dart';
import 'package:crypto/crypto.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class APIService {
  APIService(
      {@required this.api,
      @required this.publicKey,
      @required this.privateKey}) {
    hash = generateMd5('$ts$privateKey$publicKey');
    debugPrint('hash = $hash');
  }
  final API api;
  String ts = '1'; // we could use a timestamp instead
  final String publicKey; // = FlutterConfig.get('PUBLIC_KEY');
  final String privateKey; // = FlutterConfig.get('PRIVATE_KEY');
  String hash;
  int offset = 0; // starting point for retrieving data (reset to 0 if reset is set to true in getCharacters)

  Future<List<Character>> getCharacters(
      {int limit = 50, bool reset = false}) async {
    if (reset) offset = 0;
    Uri uri = api.endpointUri(Endpoint.characters);
    Uri completeUri = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
        queryParameters: {
          'apikey': publicKey,
          'ts': ts,
          'hash': hash,
          'offset': offset.toString(),
          'limit': limit.toString(),
        });
    // debugPrint('completeUri = $completeUri');

    final response = await http.get(
      completeUri,
    );
    var returnList = <Character>[];
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body.isNotEmpty) {
        // debugPrint('body: $body');
        final data = body['data'];

        final int count = data['count'];
        // debugPrint('count = $count');
        if (count != null)
          offset += count;
        final results = data['results'];
        // debugPrint('results: $results');
        for (var character in results) {
          // print('id: ${character['id']} name: ${character['name']}');
          final newCharacter = Character.fromJson(character);
          debugPrint('newCharacter = $newCharacter');
          returnList.add(newCharacter);
        }
        return returnList;
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
//   Future<EndpointData> getEndpointData({
//     @required Endpoint endpoint,
//   }) async {
//     final uri = api.endpointUri(endpoint);
//     final response = await http.get(
//       uri.toString(),
//       headers: {'Authorization': 'Bearer $accessToken'},
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       if (data.isNotEmpty) {
//         final Map<String, dynamic> endpointData = data[0];
//         final String responseJsonKey = _responseJsonKeys[endpoint];
//         final int result = endpointData[responseJsonKey];
//         final String dateString = endpointData['date'];
//         final date = DateTime.tryParse(dateString);
//
//         if (result != null) {
//           return EndpointData(value: result, date: date);
//         }
//       }
//     }
//     print(
//         'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
//     throw response;
//   }
}
