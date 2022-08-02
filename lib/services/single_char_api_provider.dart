import 'package:dio/dio.dart';
import '../blocs/models/single_char.model.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<SingleCharacterModel> fetchSingleChar(String data) async {
    try {
      Response response = await _dio.get(data);
      return SingleCharacterModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SingleCharacterModel.withError(
          "Data not found / Connection issue");
    }
  }
}
