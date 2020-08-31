// File Contains All the functions needed to call and work with api
import 'dart:convert';
import 'package:http/http.dart' as http;


class API {
  static final String mainUrl = "https://restcountries.eu/rest/v2/all";

  static Future<List<dynamic>> getCountries() async {
    List<dynamic> countries=[];
    final response = await http.get(mainUrl);
    if (response.statusCode == 200) {
      var decoded=jsonDecode(response.body);
      for(var country in decoded){
         countries.add(country["name"]);
      }
    }
     return countries;
  }
}
