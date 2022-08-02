import '../../../services/single_char_api_provider.dart';
import "../models/single_char.model.dart";

class ApiRepository {
  final _provider = ApiProvider();

  Future<SingleCharacterModel> fetchSingleChar(String data) {
    return _provider.fetchSingleChar(data);
  }
}

class NetworkError extends Error {}
