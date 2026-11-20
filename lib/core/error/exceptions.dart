/// Erori "tehnice", aruncate de stratul Data (datasource).

class NetworkException implements Exception {
  const NetworkException();
}

class ServerException implements Exception {
  final int statusCode;
  const ServerException(this.statusCode);
}

class ParsingException implements Exception {
  const ParsingException();
}
