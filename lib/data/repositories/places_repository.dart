import 'package:food_store/data/models/google_place_model.dart';
import 'package:food_store/data/models/suggestion_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PlacesRepository {
  final key = "AIzaSyBQO51j_oaJi9GcM_oJ4VD5GP3Lhpwbd0s";
  final sessiontoken = "";
  final location = "37.982633582786555, 23.720899120259258";
  final radius = "4000";
  final country = "country:gr";

  Future<List<Suggestion>> fetchSuggestions(
    String input, {
    String language = "en",
  }) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&language=$language&radius=$radius&location=$location&components=$country&types=address&strictbounds=true';

    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status'] == 'OK') {
        final suggestions = result['predictions'] as List;
        return suggestions.map((s) => Suggestion.fromJson(s)).toList();
      } else if (result['status'] == 'ZERO_RESULTS') {
        return <Suggestion>[];
      } else {
        throw Exception(
            'A exception has occured with status code: ${result['status']}.');
      }
    } else {
      throw HttpException(
          'Request failed with status: ${response.statusCode}.');
    }
  }

  Future<GooglePlace> getDetailsById(String placeId) async {
    var request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry&key=$key';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      if (result['status'] == 'OK') {
        var y = Result.fromJson(result['result']);
        var x = GooglePlace.fromResult(y);
        return x;
      } else {
        throw Exception(
            'A exception has occured with status code: ${result['status']}.');
      }
    } else {
      throw HttpException(
          'Request failed with status: ${response.statusCode}.');
    }
  }
}


/// Demo Store location:
/// Kolokinthous 27, Athina 104 36
/// 37.982633582786555, 23.720899120259258