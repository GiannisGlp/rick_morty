import '../../../services/chars_api_provider.dart';
import "../models/all_chars_model.dart";

class ApiRepository {
  final _provider = ApiProvider();

  Future<CharactersModel> fetchCharsList() {
    return _provider.fetchCharsList();
  }
}

class NetworkError extends Error {}
