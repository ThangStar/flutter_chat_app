class Success {
  final dynamic body;
  final int statusCode;

  Success({required this.body, this.statusCode = 200});
}

class Failure {
  final String? body;
  final int statusCode;
  final String message;

  Failure({this.body, this.statusCode = 404, this.message = ''});
}
