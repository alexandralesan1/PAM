/// Erori "pentru utilizator", cu mesaj afișabil. Ajung până în Cubit.
abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('Nu există conexiune la internet sau serverul nu răspunde.');
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure()
      : super('Datele primite de la server au un format neașteptat.');
}
