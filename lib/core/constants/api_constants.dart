class ApiConstants {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/lab2026/v4';
  static const String feed = '/feed';
  static const String feedDetails = '/feed/details';

  // Serverul e pe un hosting gratuit: prima cerere poate dura mult.
  static const Duration timeout = Duration(seconds: 60);
}
