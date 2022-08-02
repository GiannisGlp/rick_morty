import 'package:dio/dio.dart';
import '../blocs/models/all_chars_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://rickandmortyapi.com/api/character';

  Future<CharactersModel> fetchCharsList() async {
    try {
      Response response = await _dio.get(_url);
      Response resEp;
      for (var result in response.data["results"]) {
        resEp = await _dio.get(result["episode"].first);
        result['firstEpisode'] = resEp.data;
      }
      return CharactersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CharactersModel.withError("Data not found / Connection issue");
    }
  }
}
