import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/posts_data_ui_model.dart';

class PostsRepo {
  ///no positional args can be passed to this as it is a static methods
  static Future<List<CountryDataModel>> fetchPosts(String country) async {
    var client = http.Client();

    try {
      // Fetch the posts in response
      var response = await client.get(
          Uri.parse(
            'https://api.api-ninjas.com/v1/country?name=$country',
          ),
          headers: {'X-Api-Key': 'YHtBiNuLo+9ux37f4+rJVQ==GMXz1VFAp7rGAULt'});

      if (response.statusCode == 200) {
        print("Connection is ok");
        print(country);
        List<dynamic> result = jsonDecode(response.body);

        // Check if the result is not empty
        if (result.isNotEmpty) {
          // Mapping the JSON body to a list of CountryDataModel
          CountryDataModel post =
              CountryDataModel.fromMap(result[0] as Map<String, dynamic>);

          return [post]; // Return the list instead of emitting state
        } else {
          print("No data found for the country: $country");
          throw Exception("No data found");
        }
      } else {
        print("Error in connection: ${response.statusCode}");
        throw Exception("Failed to fetch data");
      }
    } finally {
      client.close(); // Ensure the client is closed
    }
  }
}
